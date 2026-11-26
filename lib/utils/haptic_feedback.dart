import 'package:flutter/services.dart';

import 'sound_feedback.dart';

/// Centralized haptic feedback utility for consistent haptic patterns across
/// the app, and the one place a sound is attached to them.
///
/// Sound rides along with the haptics rather than being called separately by
/// each game. 295 of the 310 game screens already call something here, so
/// this reaches almost the whole app without touching any of them, and any
/// game added later gets it for nothing.
///
/// Two rules shape which of these make a noise.
///
/// Nothing that marks a mistake does. [error] stays silent: a sound for a
/// wrong move is a penalty, and this build does not penalise. He can put a
/// tile anywhere, as often as he likes, and nothing will tell him off for it.
///
/// A burst of haptics is one sound. Success is two taps 50ms apart and
/// victory is three; the hand reads those as one event and the ear should
/// too, so the sound side throttles them down to a single click.
class HapticFeedbackUtil {
  static int _lastHapticTime = 0;
  static const int _throttleMs = 30; // Min time between haptics

  static bool _shouldThrottle() {
    final now = DateTime.now().millisecondsSinceEpoch;
    if (now - _lastHapticTime < _throttleMs) return true;
    _lastHapticTime = now;
    return false;
  }

  // The bare platform calls, used to build the patterns below. These never
  // make a sound: whether something is audible is decided by the named
  // methods, not by whichever impacts they happen to be assembled from.
  static void _rawLight() {
    if (_shouldThrottle()) return;
    HapticFeedback.lightImpact();
  }

  static void _rawMedium() {
    if (_shouldThrottle()) return;
    HapticFeedback.mediumImpact();
  }

  static void _rawHeavy() {
    if (_shouldThrottle()) return;
    HapticFeedback.heavyImpact();
  }

  /// Light impact for selection/tap interactions
  static void lightImpact() {
    _rawLight();
    SoundFeedbackUtil.tap();
  }

  /// Medium impact for important interactions
  static void mediumImpact() {
    _rawMedium();
    SoundFeedbackUtil.tap();
  }

  /// Heavy impact for significant events
  static void heavyImpact() {
    _rawHeavy();
    SoundFeedbackUtil.tap();
  }

  /// Selection click for cell/button selections
  static void selectionClick() {
    if (!_shouldThrottle()) HapticFeedback.selectionClick();
    SoundFeedbackUtil.tap();
  }

  static void selection() => selectionClick();

  static void light() => lightImpact();

  /// Vibrate for errors or warnings. Silent, like [error].
  static void vibrate() {
    HapticFeedback.vibrate();
  }

  /// Custom haptic pattern for game-specific interactions
  static void gameInteraction() {
    // Light impact for game interactions
    lightImpact();
  }

  /// Success pattern for completing puzzles
  static void success() {
    // Double light impact for success, heard as one click.
    _rawLight();
    Future.delayed(const Duration(milliseconds: 50), _rawLight);
    SoundFeedbackUtil.tap();
  }

  /// Error pattern for mistakes.
  ///
  /// Felt but not heard, on purpose. A wrong move costs nothing in this
  /// build, and a noise for it would say otherwise.
  static void error() {
    _rawHeavy();
  }

  /// Victory pattern for game completion.
  ///
  /// No sound here either, but for a different reason: the completion
  /// screen plays the finishing flourish for every game in the app, so a
  /// sound at this point would double it.
  static void victory() {
    _rawHeavy();
    Future.delayed(const Duration(milliseconds: 100), _rawMedium);
    Future.delayed(const Duration(milliseconds: 200), _rawLight);
  }
}
