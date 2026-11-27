import 'package:hive/hive.dart';

import 'senior_mode.dart';

/// The handful of things that can be changed while the app is running.
///
/// Everything in [SeniorMode] is a compile-time constant: it is the shape of
/// the build, decided once by whoever assembles the APK. These are different.
/// They are the knobs NJ asked for -- sound off, larger type -- and they have
/// to be readable from anywhere and writable from the settings screen.
///
/// Reads are synchronous on purpose. [SoundFeedbackUtil] and
/// [HapticFeedbackUtil] are static utilities called from hundreds of places
/// on the path of a tap; they cannot await a box or hold a Riverpod ref. So
/// the box is opened once during startup, before the first frame, and read
/// straight from memory after that. [init] is what makes that safe, and
/// nothing here throws if it was never called -- the defaults simply stand.
///
/// For the screens, [settingsProvider] wraps this and rebuilds on change.
/// Write through the provider rather than calling [setBool] directly, or the
/// UI will not notice.
class AppSettings {
  const AppSettings._();

  static const String boxName = 'app_settings';

  static Box? _box;

  /// Opens the box. Call once, from main, after Hive.initFlutter.
  static Future<void> init() async {
    try {
      _box = await Hive.openBox(boxName);
    } catch (_) {
      // A settings box that will not open is not worth failing the app over.
      // Every getter below falls back to its default.
      _box = null;
    }
  }

  // --- keys, and what they fall back to -------------------------------------

  static const String keySound = 'sound';
  static const String keyVibration = 'vibration';
  static const String keyShowPoints = 'show_points';
  static const String keyTextScale = 'text_scale';

  /// The three type sizes offered. The ceiling in [SeniorMode] is 1.6, so
  /// none of these can be set past what the layouts were checked against.
  static const double textNormal = 1.0;
  static const double textLarge = 1.25;
  static const double textLargest = 1.5;

  static bool get sound =>
      _read(keySound, SeniorMode.enabled ? SeniorMode.soundFeedback : true);

  static bool get vibration => _read(keyVibration, true);

  static bool get showPoints => _read(keyShowPoints, true);

  /// The floor applied to the whole app's text scaling.
  ///
  /// Clamped on the way out as well as on the way in: a value written by an
  /// older build, or a half-finished write, must not be able to push the
  /// floor above the ceiling, which would throw inside MediaQuery.
  static double get textScale {
    final stored = _read(keyTextScale, SeniorMode.uiTextScale);
    if (stored.isNaN) return SeniorMode.uiTextScale;
    if (stored < 1.0) return 1.0;
    if (stored > SeniorMode.uiTextScaleCeiling) {
      return SeniorMode.uiTextScaleCeiling;
    }
    return stored;
  }

  // --- plumbing -------------------------------------------------------------

  static T _read<T>(String key, T fallback) {
    try {
      final value = _box?.get(key);
      return value is T ? value : fallback;
    } catch (_) {
      return fallback;
    }
  }

  static Future<void> setBool(String key, bool value) => _write(key, value);

  static Future<void> setDouble(String key, double value) => _write(key, value);

  static Future<void> _write(String key, Object value) async {
    try {
      await _box?.put(key, value);
    } catch (_) {
      // The change still holds for this session; it just will not survive a
      // restart. Better than losing the tap.
    }
  }
}
