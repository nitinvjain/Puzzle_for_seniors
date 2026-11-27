import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/app_settings.dart';

/// A snapshot of the adjustable settings, so screens can watch them.
///
/// [AppSettings] is the store and can be read from anywhere synchronously;
/// this is the reactive face of it, for the widgets that have to rebuild when
/// something is toggled -- the settings screen itself, the text scale in
/// main.dart, and the points line on the home screen.
class SettingsState {
  final bool sound;
  final bool vibration;
  final bool showPoints;
  final double textScale;

  const SettingsState({
    required this.sound,
    required this.vibration,
    required this.showPoints,
    required this.textScale,
  });

  /// Read straight out of the store, which main.dart has already opened.
  factory SettingsState.current() => SettingsState(
        sound: AppSettings.sound,
        vibration: AppSettings.vibration,
        showPoints: AppSettings.showPoints,
        textScale: AppSettings.textScale,
      );
}

/// Hand-rolled rather than annotated with @riverpod, like the player name,
/// because the code generator cannot be run from here. The behaviour is the
/// same.
final settingsProvider =
    NotifierProvider<SettingsNotifier, SettingsState>(SettingsNotifier.new);

class SettingsNotifier extends Notifier<SettingsState> {
  @override
  SettingsState build() => SettingsState.current();

  /// Each setter writes to the store and then re-reads the lot, so the state
  /// can never drift from what is on disk -- including when a write fails and
  /// the store quietly keeps the old value.
  Future<void> setSound(bool value) async {
    await AppSettings.setBool(AppSettings.keySound, value);
    state = SettingsState.current();
  }

  Future<void> setVibration(bool value) async {
    await AppSettings.setBool(AppSettings.keyVibration, value);
    state = SettingsState.current();
  }

  Future<void> setShowPoints(bool value) async {
    await AppSettings.setBool(AppSettings.keyShowPoints, value);
    state = SettingsState.current();
  }

  Future<void> setTextScale(double value) async {
    await AppSettings.setDouble(AppSettings.keyTextScale, value);
    state = SettingsState.current();
  }
}
