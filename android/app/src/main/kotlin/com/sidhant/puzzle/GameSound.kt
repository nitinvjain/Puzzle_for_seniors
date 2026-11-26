package com.sidhant.puzzle

import android.content.Context
import android.media.AudioFormat
import android.media.AudioManager
import android.media.AudioTrack
import java.util.concurrent.Executors
import java.util.concurrent.atomic.AtomicBoolean
import kotlin.math.exp
import kotlin.math.sin

/**
 * The game sounds, synthesised here and played through the framework's own
 * AudioTrack.
 *
 * Why native code rather than an audio plugin: every Flutter audio package
 * carries its own Android module, and this build sits on a Gradle and AGP
 * combination that took several evenings to settle. AudioTrack is part of
 * Android itself, so none of that moves. Nothing is added to pubspec.yaml,
 * no dependency is resolved, and a Gradle sync has nothing new to find.
 *
 * Why not [android.media.SystemSound]-style platform clicks, which is what
 * this replaced: on Android that click is the system *touch* sound, so it
 * obeys Settings > Sound > Touch sounds and plays at the system's own volume.
 * On a phone with touch sounds off -- the default on a good many builds -- the
 * app was simply silent, which is what NJ reported. This route does not
 * consult that setting.
 *
 * The sounds themselves are generated rather than borrowed: a sine with a
 * little second and third harmonic, a 6ms attack and an exponential decay
 * forced to exactly zero at the tail, so there is no click at either end.
 * Both are pitched between 500 and 800 Hz. That is deliberate -- age-related
 * hearing loss takes the top of the range first, and a bright 2kHz "ding" is
 * the one an 84-year-old is least likely to hear. C5 for a tap, and a C-E-G
 * rise to finish on.
 *
 * Nothing here throws into Flutter. Every platform call is wrapped, and a
 * failure is remembered for [describe] rather than reported as an error, so a
 * device that will not play a sound still plays the game.
 */
class GameSound(private val context: Context) {

    companion object {
        const val CHANNEL = "puzzle_for_seniors/sound"

        /** Index into [clips]. */
        const val TAP = 0
        const val COMPLETE = 1

        private const val SAMPLE_RATE = 44100

        /** Attack, in seconds. Long enough to kill the click, short enough
         *  that the sound still feels instant. */
        private const val ATTACK = 0.006

        /** Milliseconds held after a clip's own length before the track is
         *  released. See the note in [playNow]. */
        private const val TAIL_MS = 40L
    }

    /** Two threads, so the finishing chime never waits behind a tap. */
    private val worker = Executors.newFixedThreadPool(2)

    private val clips: Array<ShortArray> = arrayOf(buildTap(), buildComplete())

    /** One in-flight play per clip. A second tap arriving while the first is
     *  still sounding is dropped, not queued: feedback that lags behind the
     *  finger is worse than feedback that is missing. */
    private val busy = arrayOf(AtomicBoolean(false), AtomicBoolean(false))

    /**
     * Written on the audio thread, read on the main thread by [describe].
     *
     * Volatile so the diagnostic reports what actually happened rather than a
     * stale "none" -- the whole value of that button is that it is honest.
     */
    @Volatile
    private var lastError: String = "none"

    fun play(which: Int) {
        val clip = clips.getOrNull(which) ?: return
        val flag = busy.getOrNull(which) ?: return
        if (!flag.compareAndSet(false, true)) return
        try {
            worker.execute {
                try {
                    playNow(clip)
                } finally {
                    flag.set(false)
                }
            }
        } catch (t: Throwable) {
            // Executor shut down, or refused the task.
            flag.set(false)
            lastError = describeThrowable(t)
        }
    }

    // The stream-type AudioTrack constructor is deprecated in favour of
    // AudioTrack.Builder, which needs API 23. Builder would mean either a
    // version check or raising minSdk, and this build's minSdk comes from
    // Flutter rather than from here, so the old constructor stays: it works on
    // every level the app supports and the deprecation is only a warning.
    @Suppress("DEPRECATION")
    private fun playNow(clip: ShortArray) {
        var track: AudioTrack? = null
        try {
            track = AudioTrack(
                streamType(),
                SAMPLE_RATE,
                AudioFormat.CHANNEL_OUT_MONO,
                AudioFormat.ENCODING_PCM_16BIT,
                clip.size * 2,
                AudioTrack.MODE_STATIC
            )
            // Static mode wants the whole buffer in before play().
            track.write(clip, 0, clip.size)
            track.play()
            // Hold the track until the sound has actually come out, then let
            // it go; a released track stops mid-note.
            //
            // The margin matters more than it looks. This thread is what the
            // busy flag below is tracking, so clip length plus margin is how
            // long a tap sound blocks the next one -- and if that ever exceeds
            // the throttle in SoundFeedbackUtil, a fast hand loses every other
            // note. 114ms for a tap against a 150ms throttle leaves slack for
            // scheduling jitter without being so generous it starts dropping.
            Thread.sleep(clip.size * 1000L / SAMPLE_RATE + TAIL_MS)
        } catch (t: Throwable) {
            lastError = describeThrowable(t)
        } finally {
            try {
                track?.stop()
            } catch (t: Throwable) {
                // A track that never initialised refuses to stop. Nothing to do.
            }
            try {
                track?.release()
            } catch (t: Throwable) {
                // Likewise.
            }
        }
    }

    /**
     * Media volume, unless it is all the way down.
     *
     * Games belong on STREAM_MUSIC: the volume keys reach it while the app is
     * open, which makes it the one stream he can adjust himself. But a phone
     * whose media volume sits at zero would be silent again, and that is the
     * failure this whole change exists to end, so in that one case the sound
     * goes out on the notification stream instead, which is almost never off.
     */
    private fun streamType(): Int {
        try {
            val manager = context.getSystemService(Context.AUDIO_SERVICE) as AudioManager
            if (manager.getStreamVolume(AudioManager.STREAM_MUSIC) == 0) {
                return AudioManager.STREAM_NOTIFICATION
            }
        } catch (t: Throwable) {
            lastError = describeThrowable(t)
        }
        return AudioManager.STREAM_MUSIC
    }

    /**
     * A plain-language report for the sound test on the home screen.
     *
     * The point of this is to end the guessing. If the chime is inaudible,
     * this says whether the phone is muted, which stream the sound went to,
     * and whether the audio call failed -- rather than another round of "still
     * no sound" with nothing to go on.
     */
    fun describe(): String {
        return try {
            val manager = context.getSystemService(Context.AUDIO_SERVICE) as AudioManager
            val media = manager.getStreamVolume(AudioManager.STREAM_MUSIC)
            val mediaMax = manager.getStreamMaxVolume(AudioManager.STREAM_MUSIC)
            val note = manager.getStreamVolume(AudioManager.STREAM_NOTIFICATION)
            val noteMax = manager.getStreamMaxVolume(AudioManager.STREAM_NOTIFICATION)
            val ringer = when (manager.ringerMode) {
                AudioManager.RINGER_MODE_SILENT -> "silent"
                AudioManager.RINGER_MODE_VIBRATE -> "vibrate"
                else -> "normal"
            }
            val using = if (media == 0) "notification" else "media"
            "playing on the $using volume. Media $media of $mediaMax, " +
                "notification $note of $noteMax, ringer $ringer. Audio errors: $lastError"
        } catch (t: Throwable) {
            "could not read the volume settings (" + describeThrowable(t) + ")"
        }
    }

    fun release() {
        try {
            worker.shutdownNow()
        } catch (t: Throwable) {
            // Going away anyway.
        }
    }

    private fun describeThrowable(t: Throwable): String {
        val message = t.message
        return if (message == null || message.isEmpty()) {
            t.javaClass.simpleName
        } else {
            t.javaClass.simpleName + " - " + message
        }
    }

    // ---- synthesis -------------------------------------------------------

    private class Note(
        val start: Double,
        val freq: Double,
        val dur: Double,
        val h2: Double,
        val h3: Double
    )

    /** A single soft C5, 70ms. Something was tapped, placed or matched. */
    private fun buildTap(): ShortArray = render(
        0.075,
        listOf(Note(0.000, 523.25, 0.070, 0.18, 0.00)),
        0.55
    )

    /** C-E-G, overlapping, 580ms. The game is finished. */
    private fun buildComplete(): ShortArray = render(
        0.580,
        listOf(
            Note(0.000, 523.25, 0.210, 0.22, 0.08),
            Note(0.160, 659.25, 0.210, 0.22, 0.08),
            Note(0.320, 783.99, 0.250, 0.22, 0.08)
        ),
        0.85
    )

    /**
     * Sum the notes into one buffer, then scale the whole thing so its loudest
     * sample lands on [target].
     *
     * Normalising at the end rather than per note is what keeps the chime from
     * clipping where two notes overlap, and it means the harmonic amounts above
     * can be changed without having to re-check the levels.
     */
    private fun render(total: Double, notes: List<Note>, target: Double): ShortArray {
        val buffer = DoubleArray((total * SAMPLE_RATE).toInt())
        for (note in notes) {
            val offset = (note.start * SAMPLE_RATE).toInt()
            val length = (note.dur * SAMPLE_RATE).toInt()
            for (i in 0 until length) {
                val t = i.toDouble() / SAMPLE_RATE
                val envelope: Double
                if (t < ATTACK) {
                    envelope = t / ATTACK
                } else {
                    val x = (t - ATTACK) / (note.dur - ATTACK)
                    envelope = if (x >= 1.0) 0.0 else exp(-4.2 * x) * (1.0 - x)
                }
                val sample = (sin(2.0 * Math.PI * note.freq * t) +
                    note.h2 * sin(4.0 * Math.PI * note.freq * t) +
                    note.h3 * sin(6.0 * Math.PI * note.freq * t)) * envelope
                val at = offset + i
                if (at < buffer.size) {
                    buffer[at] = buffer[at] + sample
                }
            }
        }

        var peak = 0.0
        for (value in buffer) {
            val magnitude = if (value < 0.0) -value else value
            if (magnitude > peak) peak = magnitude
        }
        if (peak <= 0.0) peak = 1.0
        val gain = target / peak

        val out = ShortArray(buffer.size)
        for (i in buffer.indices) {
            var value = (buffer[i] * gain * 32767.0).toInt()
            if (value > 32767) value = 32767
            if (value < -32767) value = -32767
            out[i] = value.toShort()
        }
        return out
    }
}
