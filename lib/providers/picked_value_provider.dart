import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The value the player has picked up and not yet put down.
///
/// Cross Math works by choosing a tile and then touching the square it goes
/// in. NJ asked for that same technique in every game that fills blanks from
/// a list of values, so his father learns one gesture and it works
/// everywhere; this holds the chosen value for the games whose board cells
/// are separate widgets and cannot see the pad's own state.
///
/// 0 means the eraser. Null means nothing is picked up, and the older
/// order -- touch the square first, then the value -- still applies.
///
/// Hand-rolled rather than annotated with @riverpod, like the player name
/// and the settings, because the code generator cannot be run from here.
final pickedValueProvider =
    NotifierProvider<PickedValueNotifier, int?>(PickedValueNotifier.new);

class PickedValueNotifier extends Notifier<int?> {
  @override
  int? build() => null;

  /// Touching the value that is already held puts it down again, so there is
  /// always a way out of a choice without having to place it somewhere.
  void toggle(int value) => state = state == value ? null : value;

  void pick(int value) => state = value;

  void clear() => state = null;
}
