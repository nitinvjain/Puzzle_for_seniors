/// Central configuration for the senior / dementia-friendly build.
///
/// Everything that makes this fork different from upstream is switched from
/// here, so the customisation stays in one readable place and upstream merges
/// stay manageable.
///
/// Design intent: the app should never apply time pressure, never tell the
/// player they failed, and never invite comparison with a previous day's
/// performance. A wrong answer simply does not advance.
library;

class SeniorMode {
  const SeniorMode._();

  /// Master switch. Set to false to get the stock upstream behaviour back.
  static const bool enabled = true;

  /// The only games shown in the app, in the order they appear on the home
  /// screen. These ids must match `GameMetadata.id`.
  ///
  /// To change the selection, edit this list only — nothing else refers to
  /// individual games.
  static const List<String> enabledGameIds = <String>[
    'kenken',
    'sum_pyramid',
    'target_10',
    'number_bonds',
    'magic_squares',
    'sudoku',
  ];

  // --- Behaviour flags -----------------------------------------------------

  /// No countdowns, no elapsed clocks, no per-move time limits anywhere.
  static const bool disableTimers = true;

  /// No "game over", no lives, no losing. A wrong answer is simply not
  /// accepted and the player tries again.
  static const bool disableFailStates = true;

  /// No scores, no stars, no accuracy percentages, no leaderboards.
  static const bool disableScoring = true;

  /// No daily streaks. A missed day must never be surfaced.
  static const bool disableStreaks = true;

  /// Always generate the easiest variant and hide any difficulty selector.
  static const bool lockEasiestDifficulty = true;

  /// Hide the stats and settings destinations; one Back route only.
  static const bool simplifiedNavigation = true;

  // --- Presentation --------------------------------------------------------

  /// Multiplier applied to the DesignSystem type scale.
  static const double fontScale = 1.35;

  /// Minimum side of any interactive element, in logical pixels.
  /// Material's default is 48; older hands and tremor need more.
  static const double minTapTarget = 72.0;

  /// Grid cells (sudoku, KenKen, magic squares) are drawn at least this big.
  static const double minGridCell = 56.0;
}
