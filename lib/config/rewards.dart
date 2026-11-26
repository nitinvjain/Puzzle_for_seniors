/// The reward system: what he gets for finishing a game.
///
/// Built on counters the app has been keeping all along -- `totalSolved` in
/// the user data and the per-game `solvedToday` flags -- so nothing new is
/// written to disk and the history already on his tablet counts from the
/// first day he used it. Adding a stored field would mean regenerating the
/// Hive adapters, and there is no reason to: everything below is derived.
///
/// Three rules shape it, and they are what make it safe for someone whose
/// memory is going:
///
///   * **the total only ever goes up.** No decay, no expiry, nothing to lose.
///     A number that falls reads as failure, and failure is the one thing
///     this build is meant never to show him.
///
///   * **nothing is compared.** Not with yesterday, not with anyone else.
///     The streak machinery stays switched off; `solvedToday` is used only as
///     a flag for "already counted today", never as a run that can break.
///
///   * **the moment matters more than the number.** He is unlikely to recall
///     that he had 347 yesterday. What lands is the star appearing now, so
///     the immediate reward is the loud part and the running total is quiet
///     underneath it.
library;

/// What a finished game was worth.
class RewardTally {
  final int points;

  /// Whether the count of games finished went up for this finish.
  ///
  /// Not the same as "he finished a game": a game already finished today is
  /// counted once, so a replay earns its points without moving the count.
  /// Milestones hang off this and nothing else.
  final bool countedNewGame;

  const RewardTally(this.points, this.countedNewGame);
}

/// Where points earned during a game are collected until the completion
/// screen can show them.
///
/// Stages are awarded while he is still playing -- a right answer here, a
/// board cleared there -- and the banner that reports them is not built until
/// the game ends, so the amounts have to wait somewhere. They wait in memory
/// rather than on disk: the running totals are already saved, and this is
/// only the "you just earned 45" line, which is worth nothing once it has
/// been read.
class RewardLog {
  const RewardLog._();

  static int _pending = 0;
  static bool _countedNewGame = false;

  /// Points for a stage finished inside a game still in progress.
  static void addStage(int points) {
    if (points > 0) _pending += points;
  }

  /// Points for finishing a game, and whether that moved the games count.
  static void addCompletion(int points, {required bool countedNewGame}) {
    if (points > 0) _pending += points;
    if (countedNewGame) _countedNewGame = true;
  }

  /// Called as a game is opened.
  ///
  /// Without this, points earned in a game he walked away from sat on the
  /// pile and were added to the next game's total -- finishing Word Search,
  /// worth twenty, could read "+65 points" because of nine right answers
  /// abandoned in KBC India half an hour earlier.
  static void startGame() {
    _pending = 0;
    _countedNewGame = false;
  }

  /// What the finish was worth, and clears the pile.
  static RewardTally take() {
    final tally = RewardTally(_pending, _countedNewGame);
    _pending = 0;
    _countedNewGame = false;
    return tally;
  }
}

/// What to show on the completion screen.
class RewardSnapshot {
  /// Points earned in the game just finished, stages included.
  final int pointsEarned;

  /// Points in total, all time. Never decreases.
  final int totalPoints;

  /// Games finished, all time. Never decreases.
  final int totalGames;

  /// Games finished today.
  final int gamesToday;

  /// Set when this finish crossed a milestone, otherwise null.
  final String? milestone;

  const RewardSnapshot({
    required this.pointsEarned,
    required this.totalPoints,
    required this.totalGames,
    required this.gamesToday,
    this.milestone,
  });
}

class Rewards {
  const Rewards._();

  /// Whether the reward banner is shown at all.
  static const bool enabled = true;

  /// The milestones, in order.
  ///
  /// Close together at the start and spreading out later, so something good
  /// happens in his first few sittings rather than after a fortnight. Past
  /// the end of this list every 250th game is a milestone.
  static const List<int> milestones = [
    1, 3, 5, 10, 15, 20, 25, 30, 40, 50,
    75, 100, 150, 200, 250, 300, 400, 500, 750, 1000,
  ];

  /// The label for a milestone, or null if [total] is not one.
  ///
  /// Worded as a statement of what he has done, in plain words and without
  /// an exclamation at every step -- a congratulation that fires constantly
  /// stops meaning anything.
  static String? milestoneLabel(int total) {
    if (total <= 0) return null;
    switch (total) {
      case 1:
        return 'Your first game finished';
      case 3:
        return 'Three games finished';
      case 5:
        return 'Five games finished';
      case 10:
        return 'Ten games finished';
      case 15:
        return 'Fifteen games finished';
      case 20:
        return 'Twenty games finished';
      case 25:
        return 'Twenty-five games finished';
      case 30:
        return 'Thirty games finished';
      case 40:
        return 'Forty games finished';
      case 50:
        return 'Fifty games finished';
      case 75:
        return 'Seventy-five games finished';
      case 100:
        return 'One hundred games finished';
      case 150:
        return 'One hundred and fifty games';
      case 200:
        return 'Two hundred games finished';
      case 250:
        return 'Two hundred and fifty games';
      case 300:
        return 'Three hundred games finished';
      case 400:
        return 'Four hundred games finished';
      case 500:
        return 'Five hundred games finished';
      case 750:
        return 'Seven hundred and fifty games';
      case 1000:
        return 'One thousand games finished';
    }
    if (total > 1000 && total % 250 == 0) {
      return '$total games finished';
    }
    return null;
  }

  /// Points awarded for finishing a whole game, and for one stage inside one.
  ///
  /// The stage award is small on purpose. It should feel like the total is
  /// moving while he plays without making the finish itself an afterthought.
  static const int pointsPerGame = 20;
  static const int pointsPerStage = 5;

  /// The loud line: what he just earned.
  static String earnedLine(int points) =>
      points > 0 ? '+$points points' : 'Well played';

  /// The running points total, with thousands separated so it stays readable
  /// once it runs into four and five figures.
  static String pointsLine(int totalPoints) =>
      '${_grouped(totalPoints)} points in all';

  static String _grouped(int n) {
    final s = n.toString();
    if (s.length <= 3) return s;
    final out = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) out.write(',');
      out.write(s[i]);
    }
    return out.toString();
  }

  /// The "today" line, or null when there is nothing worth saying.
  ///
  /// Left out entirely for the first game of the day: "1 today" invites the
  /// thought that there should be more, which is the sort of nudge this build
  /// has no business making.
  static String? todayLine(int gamesToday) {
    if (gamesToday <= 1) return null;
    return '$gamesToday today';
  }

  /// The two running totals on one quiet line.
  ///
  /// They used to be two lines, under a third saying what he had just earned
  /// and above a fourth for a milestone. Four numbers stacked up is a report,
  /// not a reward; the thing that just happened should be the only loud part.
  static String summaryLine(int totalPoints, int totalGames) {
    final games = totalGames == 1 ? '1 game' : '$totalGames games';
    return '${_grouped(totalPoints)} points  \u00b7  $games finished';
  }
}
