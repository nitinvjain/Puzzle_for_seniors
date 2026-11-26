import 'dart:async';

import 'package:flutter/services.dart';

import '../config/senior_mode.dart';

/// Short sounds that confirm something happened, alongside the haptics.
///
/// Built on [SystemSound], which is part of Flutter itself, rather than on an
/// audio package. That is a deliberate choice: every audio plugin carries
/// native Android code, and this build sits on a particular Gradle and AGP
/// combination that took a while to settle. A click is enough to say "that
/// worked", and it is not worth risking the build for.
///
/// **What this costs.** Two things, and both matter.
///
/// The sounds are the platform's own, not chosen ones. There is no chime and
/// no tune; there is a click.
///
/// And on Android the click is the system touch sound, so it follows the
/// device's own setting for that. If the game is silent, that setting is off:
/// Settings > Sound and vibration > (Advanced) > Touch sounds, on most
/// builds. Nothing here throws if the platform has no sound to play, so a
/// device with it switched off simply plays nothing.
class SoundFeedbackUtil {
  const SoundFeedbackUtil._();

  static bool get _on => SeniorMode.enabled ? SeniorMode.soundFeedback : true;

  /// Clicks come from the haptics, which fire in bursts -- a success is two
  /// taps 50ms apart, a victory three. The hand feels those as one event and
  /// the ear should too, so clicks closer together than this are dropped.
  static const int _throttleMs = 90;
  static int _lastPlayed = 0;

  static void _click() {
    final now = DateTime.now().millisecondsSinceEpoch;
    if (now - _lastPlayed < _throttleMs) return;
    _lastPlayed = now;
    unawaited(SystemSound.play(SystemSoundType.click));
  }

  /// Something was tapped, dragged, placed or matched.
  static void tap() {
    if (!_on) return;
    _click();
  }

  /// Tiles have just joined into a new one.
  static void merge() => tap();

  /// A tap that did something, but did not complete a move.
  static void tick() => tap();

  /// The game is finished.
  ///
  /// Three clicks rather than one, spaced far enough apart to be heard as a
  /// little flourish rather than a stutter. It used to be
  /// [SystemSoundType.alert], which does nothing at all here: Flutter
  /// documents that as desktop-only, so the end of a game has been silent on
  /// his tablet since the sound was added. Clicks are thin, but a thin sound
  /// that plays beats a better one that does not.
  static void complete() {
    if (!_on) return;
    // Clear the throttle first: the move that finished the game has usually
    // just clicked, and the flourish should not lose its opening note to it.
    _lastPlayed = 0;
    _click();
    Timer(const Duration(milliseconds: 140), _click);
    Timer(const Duration(milliseconds: 280), _click);
  }
}
