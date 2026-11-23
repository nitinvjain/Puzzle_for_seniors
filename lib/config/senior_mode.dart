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

import 'dart:async';

class SeniorMode {
  const SeniorMode._();

  /// Drop-in replacement for `Timer.periodic` at **pressure countdown** call
  /// sites only — the once-a-second tick that decrements a clock and ends the
  /// game when it hits zero.
  ///
  /// When [disableTimers] is set this returns a timer that never fires, so the
  /// clock never advances and the timeout branch (which is what sets
  /// `isGameOver`) is never reached. It is a real [Timer], so the `_timer?.
  /// cancel()` calls scattered through the providers keep working untouched.
  ///
  /// Deliberately NOT used for:
  ///   * sub-second game loops and animation ticks — stopping those freezes
  ///     the game rather than relaxing it;
  ///   * phase-advance countdowns in the memory games, which move the player
  ///     from "study the grid" to "now recall it". Without them the game sits
  ///     on the study screen forever.
  static Timer periodicCountdown(
    Duration duration,
    void Function(Timer) callback,
  ) {
    if (disableTimers) {
      // Far-future one-shot: never realistically fires, cancels cleanly.
      return Timer(const Duration(days: 365000), () {});
    }
    return Timer.periodic(duration, callback);
  }

  /// Whether every game uses one common round target in place of its own.
  ///
  /// Stock limits vary from eight correct answers to twenty trials, and each
  /// game interrupts with a "Play Again" modal when it gets there. Overriding
  /// them with a single, much higher target means a session lasts as long as
  /// he wants to keep going, while still ending somewhere rather than running
  /// forever.
  static const bool overrideRoundLimits = true;

  /// The common target substituted for each game's own limit.
  ///
  /// Set long enough that reaching it is a real sitting rather than a
  /// interruption after a couple of minutes. A plain `const int`, so it stays
  /// valid in both the `static const` fields and the constructor defaults
  /// where those limits are declared.
  static const int roundTarget = 50;

  /// Applies a wrong-answer time penalty, or doesn't.
  ///
  /// Several games dock the clock a few seconds for each mistake. With the
  /// countdown stopped those deductions become a disguised attempt limit —
  /// enough wrong answers still drive the clock to zero and end the game — so
  /// the senior build returns the clock unchanged and the penalty is inert.
  static int applyTimePenalty(int current, int penalty) {
    if (disableTimers || disableFailStates) return current;
    return current - penalty;
  }

  /// Master switch. Set to false to get the stock upstream behaviour back.
  static const bool enabled = true;

  /// Whether to show only [enabledGameIds], or the whole catalogue.
  ///
  /// `false` shows all 304 games, still with every senior-mode behaviour
  /// applied: no countdowns, no fail states, large type, no stats or settings
  /// screens. Set it back to `true` to narrow the home screen again — a short
  /// list is easier to learn, so that remains the gentler default.
  static const bool limitGameList = false;

  /// The games shown when [limitGameList] is true, in the order they appear on
  /// the home screen. These ids must match `GameMetadata.id`, which is also the
  /// folder name under lib/ui/features/games/.
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

  /// Hide in-game score and progress readouts.
  ///
  /// Off: he likes seeing the count climb, and a score within a single
  /// sitting is encouragement rather than comparison. What stays off is
  /// [disableStreaks] — the day-to-day history that invites comparison with
  /// how he did last week.
  static const bool disableScoring = false;

  /// No daily streaks. A missed day must never be surfaced.
  static const bool disableStreaks = true;

  /// Always generate the easiest variant and hide any difficulty selector.
  static const bool lockEasiestDifficulty = true;

  /// Hide the stats and settings destinations; one Back route only.
  static const bool simplifiedNavigation = true;

  /// Whether the home screen keeps its search box and category filters.
  ///
  /// With a short curated list they are pure clutter. With the full catalogue
  /// they are the only way to find anything among 304 tiles, so they come back
  /// automatically — the stats and settings destinations stay hidden either
  /// way.
  static bool get showGameFilters => enabled && !limitGameList;

  // --- Presentation --------------------------------------------------------

  /// Multiplier applied to the DesignSystem type scale.
  static const double fontScale = 1.35;

  /// Minimum side of any interactive element, in logical pixels.
  /// Material's default is 48; older hands and tremor need more.
  static const double minTapTarget = 72.0;

  /// Grid cells (sudoku, KenKen, magic squares) are drawn at least this big.
  static const double minGridCell = 56.0;
}
