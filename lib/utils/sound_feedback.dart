import 'dart:async';

import 'package:flutter/services.dart';

import '../config/app_settings.dart';

/// Short sounds that confirm something happened, alongside the haptics.
///
/// This used to call [SystemSound.play], which is part of Flutter and needed
/// nothing added to the build. It never made a noise on NJ's father's phone,
/// and the reason is in Android rather than in the code: on Android that call
/// plays the system *touch* sound, which follows Settings > Sound > Touch
/// sounds and comes out at the system's own volume. With touch sounds off --
/// the default on a good many builds -- the app was silent, and no amount of
/// tuning on this side could have changed that.
///
/// So the sounds now come from [GameSound] on the Android side, which
/// synthesises them and plays them through AudioTrack on the media volume.
/// That is native code, but it is native code written here: no audio plugin,
/// nothing added to pubspec.yaml, and nothing for Gradle to resolve.
///
/// [SystemSound] stays as the fallback. If the channel is missing -- a desktop
/// or iOS build, or an Android build from before this change -- the platform
/// click is still better than nothing, and the app behaves exactly as it did.
///
/// Two rules shape which events make a noise, and both still hold.
///
/// Nothing that marks a mistake sounds. A wrong move costs nothing in this
/// build, and a noise for it would say otherwise.
///
/// A burst of haptics is one sound. Success is two taps 50ms apart and victory
/// is three; the hand reads those as one event and the ear should too.
class SoundFeedbackUtil {
  const SoundFeedbackUtil._();

  static const MethodChannel _channel =
      MethodChannel('puzzle_for_seniors/sound');

  /// Settings now decides, not the build. [AppSettings.sound] falls back to
  /// the SeniorMode constant when nothing has been chosen, so a fresh install
  /// behaves exactly as before.
  static bool get _on => AppSettings.sound;

  /// Whether the native channel answered. Null until the first attempt, false
  /// once it is known to be absent -- after which nothing tries it again.
  static bool? _hasChannel;

  /// Known once the sound test has run; reported by [describe].
  static String? _lastReport;

  /// Minimum gap between tap sounds.
  ///
  /// Longer than the old 90ms, because a real note is longer than a click. The
  /// native side holds a tap for 114ms -- 75ms of sound plus a margin -- and
  /// drops anything that arrives while it is still sounding. So this has to be
  /// the larger of the two numbers, or a fast hand would lose every other note
  /// to that drop. 150ms is still about six taps a second, well clear of
  /// anything he does, and it is the one place these two files have to agree.
  static const int _throttleMs = 150;
  static int _lastPlayed = 0;

  static void _fallbackClick() {
    unawaited(SystemSound.play(SystemSoundType.click));
  }

  /// Something was tapped, dragged, placed or matched.
  static void tap() {
    if (!_on) return;
    final now = DateTime.now().millisecondsSinceEpoch;
    if (now - _lastPlayed < _throttleMs) return;
    _lastPlayed = now;
    unawaited(_play('tap'));
  }

  /// Tiles have just joined into a new one.
  static void merge() => tap();

  /// A tap that did something, but did not complete a move.
  static void tick() => tap();

  /// The game is finished: a three-note rise, C-E-G.
  ///
  /// The throttle is set rather than cleared, since the chime is one sound of
  /// its own and a tap arriving on top of it would muddy it.
  static void complete() {
    if (!_on) return;
    _lastPlayed = DateTime.now().millisecondsSinceEpoch;
    unawaited(_play('complete'));
  }

  static Future<void> _play(String method) async {
    if (_hasChannel == false) {
      _clickFallbackFor(method);
      return;
    }
    try {
      await _channel.invokeMethod<void>(method);
      _hasChannel = true;
    } on MissingPluginException {
      // No native side on this build. Fall back from here on without retrying.
      _hasChannel = false;
      _clickFallbackFor(method);
    } catch (error) {
      _lastReport = 'the sound channel failed: $error';
      _clickFallbackFor(method);
    }
  }

  static void _clickFallbackFor(String method) {
    _fallbackClick();
    if (method == 'complete') {
      // Three clicks, spaced to read as a little flourish rather than a
      // stutter. Thin, but a thin sound that plays beats a better one that
      // does not.
      Timer(const Duration(milliseconds: 140), _fallbackClick);
      Timer(const Duration(milliseconds: 280), _fallbackClick);
    }
  }

  /// Play the finishing chime whatever the sound setting says.
  ///
  /// For the test button only. Every other entry point here respects [_on],
  /// which is right -- but a button labelled "Test the sound" that stays
  /// silent because sound is switched off tells you nothing about the thing
  /// you came to test.
  static void playTest() {
    _lastPlayed = DateTime.now().millisecondsSinceEpoch;
    unawaited(_play('complete'));
  }

  /// What the device says about its own sound, in plain language.
  ///
  /// Used by the sound test on the home screen. The point is to end the
  /// guessing: if the chime cannot be heard, this says whether the phone is
  /// muted, which stream the sound went out on, and whether the audio call
  /// itself failed.
  static Future<String> describe() async {
    try {
      final report = await _channel.invokeMethod<String>('describe');
      _hasChannel = true;
      if (report != null && report.isNotEmpty) return report;
      return 'the sound channel answered but said nothing';
    } on MissingPluginException {
      _hasChannel = false;
      return 'this build has no sound channel, so it is using the system '
          'click, which follows Settings > Sound > Touch sounds';
    } catch (error) {
      return _lastReport ?? 'the sound channel failed: $error';
    }
  }
}
