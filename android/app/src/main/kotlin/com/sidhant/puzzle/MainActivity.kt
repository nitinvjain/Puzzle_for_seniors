package com.sidhant.puzzle

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private var sound: GameSound? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Configured once per engine normally, but a cached engine can arrive
        // here twice; letting the old player go first means no orphaned audio
        // threads if it ever does.
        sound?.release()

        val player = GameSound(applicationContext)
        sound = player

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, GameSound.CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "tap" -> {
                        player.play(GameSound.TAP)
                        result.success(null)
                    }
                    "complete" -> {
                        player.play(GameSound.COMPLETE)
                        result.success(null)
                    }
                    "describe" -> result.success(player.describe())
                    else -> result.notImplemented()
                }
            }
    }

    override fun onDestroy() {
        sound?.release()
        sound = null
        super.onDestroy()
    }
}
