import 'dart:async';

import 'package:flutter/services.dart';

import '../config/senior_mode.dart';

/// Short sounds that confirm something happened, alongside the haptics.
///
/// Built on [SystemSound], which is part of Flutter itself, rather than on an
/// audio package. That is a deliberate choice: every audio plugin carries
/// native Android code, and this build already sits on a particular
/// Gradle/AGP combination that took a while to settle. Nothing here needs more
/// than a click, so there is no reason to risk the build for it.
///
/// What that costs: the sounds are the platform's own, not chosen ones, and on
/// Android they follow the system **touch sounds** setting. If the game is
/// silent, that setting is off -- Settings > Sound > Advanced > Touch sounds on
/// most builds. Nothing here throws if the platform has no sound to play.
class SoundFeedbackUtil {
  const SoundFeedbackUtil._();

  static bool get _on => SeniorMode.enabled ? SeniorMode.soundFeedback : true;

  /// Tiles have just joined into a new one.
  static void merge() {
    if (!_on) return;
    unawaited(SystemSound.play(SystemSoundType.click));
  }

  /// A tap that did something, but did not complete a move.
  static void tick() {
    if (!_on) return;
    unawaited(SystemSound.play(SystemSoundType.click));
  }

  /// The game is finished.
  static void complete() {
    if (!_on) return;
    unawaited(SystemSound.play(SystemSoundType.alert));
  }
}
