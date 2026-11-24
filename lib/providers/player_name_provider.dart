import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

/// The name of whoever is playing.
///
/// Stored in a plain Hive box of its own, the same way the theme and the
/// locale are, rather than as a field on UserData. Adding a field there means
/// regenerating the freezed and Hive code, and a name is a setting rather
/// than part of the play record, so it belongs here with the other settings.
///
/// Written as a hand-rolled [NotifierProvider] rather than with the @riverpod
/// annotation used elsewhere, for the same reason: the annotation generates a
/// .g.dart file and the generator cannot be run from here. The behaviour is
/// identical.
final playerNameProvider =
    NotifierProvider<PlayerNameNotifier, String?>(PlayerNameNotifier.new);

class PlayerNameNotifier extends Notifier<String?> {
  static const String _boxName = 'player_profile';
  static const String _nameKey = 'player_name';

  /// Long enough for a full name, short enough that it cannot push the
  /// greeting off the screen.
  static const int maxLength = 24;

  static Box? _cachedBox;

  static Future<Box> _getBox() async {
    if (_cachedBox != null && _cachedBox!.isOpen) return _cachedBox!;
    _cachedBox = await Hive.openBox(_boxName);
    return _cachedBox!;
  }

  @override
  String? build() {
    _load();
    return null;
  }

  Future<void> _load() async {
    try {
      final box = await _getBox();
      final saved = box.get(_nameKey);
      if (saved is String && saved.trim().isNotEmpty) {
        state = saved.trim();
      }
    } catch (_) {
      // A name that will not load is not worth failing the app over; the
      // greeting simply falls back to asking for one.
    }
  }

  /// Saves a name, or clears it when given something blank.
  Future<void> setName(String? name) async {
    final cleaned = _clean(name);
    state = cleaned;
    try {
      final box = await _getBox();
      if (cleaned == null) {
        await box.delete(_nameKey);
      } else {
        await box.put(_nameKey, cleaned);
      }
    } catch (_) {
      // Keep the name for this session even if it could not be written.
    }
  }

  /// Trimmed, collapsed and capped.
  ///
  /// Returns null for anything blank, so "no name" has exactly one
  /// representation rather than drifting between null, '' and '   '.
  static String? _clean(String? raw) {
    if (raw == null) return null;
    final collapsed = raw.trim().replaceAll(RegExp(r'\s+'), ' ');
    if (collapsed.isEmpty) return null;
    return collapsed.length <= maxLength
        ? collapsed
        : collapsed.substring(0, maxLength).trim();
  }

  /// Exposed for testing the cleaning rules without a Hive box.
  static String? cleanForTest(String? raw) => _clean(raw);
}
