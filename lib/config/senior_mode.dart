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

  /// A timer that always runs, for countdowns that ADVANCE A PHASE rather
  /// than apply pressure — "memorise this grid" becoming "now recall it".
  ///
  /// Stopping those does not relax the game, it strands the player on the
  /// study screen with no way forward. They keep ticking; [studySeconds]
  /// lengthens them instead.
  static Timer phaseCountdown(Duration duration, void Function(Timer) cb) =>
      Timer.periodic(duration, cb);

  /// Lengthens a memorise-this phase.
  ///
  /// Four seconds to take in a grid is brisk for anyone and far too brisk
  /// here, so study windows are tripled with a sensible floor.
  static int studySeconds(int stock) =>
      enabled ? (stock * 3).clamp(12, 180) : stock;

  /// Slows a game that reveals items one at a time.
  ///
  /// Used where the pace of presentation, not a countdown, is the pressure.
  static Duration presentationPace(Duration stock) =>
      enabled ? stock * 2.5 : stock;

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

  /// Games hidden from the catalogue regardless of [limitGameList].
  ///
  /// For games whose rules cannot be made clear enough to be worth the
  /// confusion they cause.
  static const List<String> hiddenGameIds = <String>[
    'collatz', // the 3n+1 rule is unguessable without being told it
  ];

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

  /// Short confirming sounds when something lands -- a merge, a finished game.
  ///
  /// Worth having for him specifically: a change on screen can pass unnoticed,
  /// and a sound says "that worked" without his having to spot what moved.
  /// Set to false to go back to a silent game.
  static const bool soundFeedback = true;

  /// A gear on the home screen opening the settings page: sound, vibration,
  /// text size, the player's name, and the sound test that used to be its own
  /// speaker button.
  ///
  /// This does sit against the rule that there is nothing on screen to get
  /// lost in, and the screen behind it is built accordingly -- toggles and
  /// three labelled sizes, nothing to type but a name, nothing destructive.
  /// The worst his father can do by wandering in is turn the sound off, which
  /// is one tap to undo.
  ///
  /// Set to false to take the gear away entirely; the settings keep whatever
  /// values were last chosen.
  static const bool showSettings = true;

  /// Hide Android's status bar and navigation bar while the app is open.
  ///
  /// On an 11-inch tablet the system bar sits right under the game, and a
  /// hand resting at the bottom of the screen lands on Back, Home or Recents
  /// -- which closes the game, leaves the app, or drags it into split screen.
  /// On a large-screen Android there is a taskbar down there as well, so a
  /// stray touch can launch something else entirely. None of that is
  /// recoverable by an 84-year-old on his own.
  ///
  /// immersiveSticky hides both bars. A deliberate swipe from the edge brings
  /// them back for a few seconds and then they go again, so NJ can still
  /// reach Home while his father cannot do it by accident. Every screen in
  /// the app has its own Back arrow, so nothing depends on the system one.
  ///
  /// This does not stop a determined swipe. For that, see the note on screen
  /// pinning in the patch that added this.
  static const bool immersiveFullScreen = true;

  /// A dead strip along the bottom of the app, in logical pixels.
  ///
  /// With the bars hidden, the app runs to the very bottom edge -- which is
  /// exactly where the swipe that brings them back lives. Keeping every
  /// widget a little clear of it means a mis-aimed tap at the bottom row of
  /// a keypad hits nothing rather than summoning the navigation bar.
  static const double bottomKeepOut = 20.0;

  /// Swallow the system Back press at the games list.
  ///
  /// Back inside a game goes back to the list, which is wanted. Back AT the
  /// list closes the app, which is not: it is the single press that ends the
  /// session, and it is indistinguishable from the press that left a game.
  static const bool blockBackAtHome = true;

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

  /// Floor under the text scale for the WHOLE app, applied in main.dart.
  ///
  /// This is the one that does the heavy lifting: it reaches every piece of
  /// text in every screen, including the thousand-odd styles that name a font
  /// size outright and so never see [fontScale]. It is a floor, not a fixed
  /// value, so a larger system font setting still wins.
  static const double uiTextScale = 1.25;

  /// Ceiling on the same scale.
  ///
  /// The screens were laid out against unscaled text. Past roughly 1.6 the
  /// tighter ones begin to overflow, and a clipped board helps nobody, so a
  /// very large system font setting is capped here rather than allowed to
  /// break the layouts.
  static const double uiTextScaleCeiling = 1.6;

  /// Extra multiplier applied to the DesignSystem type scale, on top of
  /// [uiTextScale].
  ///
  /// The two stack: DesignSystem text renders at roughly
  /// `fontScale * uiTextScale`. This used to be 1.35 on its own, so it is set
  /// to the figure that keeps that total unchanged (1.08 x 1.25 = 1.35) now
  /// that the global scale carries most of the work. Without this the screens
  /// already tuned by hand -- the quiz, Word Search, the board games -- would
  /// jump by a further quarter and overflow.
  static const double fontScale = 1.08;

  /// Minimum side of any interactive element, in logical pixels.
  /// Material's default is 48; older hands and tremor need more.
  static const double minTapTarget = 72.0;

  /// Grid cells (sudoku, KenKen, magic squares) are drawn at least this big.
  static const double minGridCell = 56.0;
}
