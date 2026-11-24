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

/// What to show on the completion screen.
class RewardSnapshot {
  /// Games finished, all time. Never decreases.
  final int totalGames;

  /// Games finished today.
  final int gamesToday;

  /// Whether this particular finish added to the total.
  ///
  /// False when he has already finished this game once today -- the app
  /// counts a game once a day, so replaying it does not add another. The
  /// banner then simply leaves out the "+1" rather than inventing one.
  final bool earnedStar;

  /// Set when this finish crossed a milestone, otherwise null.
  final String? milestone;

  const RewardSnapshot({
    required this.totalGames,
    required this.gamesToday,
    required this.earnedStar,
    this.milestone,
  });
}

class Rewards {
  const Rewards._();

  /// Whether the reward banner is shown at all.
  static const bool enabled = true;

  /// A finish counts as "just now" if the game's record was written within
  /// this long. Used to tell a fresh completion from a replay of something
  /// already finished earlier today, without changing all 300 call sites to
  /// pass a flag down.
  static const Duration justNow = Duration(seconds: 5);

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

  /// The quiet line under the star.
  ///
  /// Deliberately not a score and not a rate: just a count of a thing he did,
  /// phrased the way a person would say it.
  static String totalLine(int totalGames) {
    if (totalGames <= 0) return 'Well played';
    if (totalGames == 1) return '1 game finished';
    return '$totalGames games finished';
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

  /// How many stars to draw in the row, given the running total.
  ///
  /// Capped, because a row of three hundred stars is a smear rather than a
  /// reward. It fills up to [maxStarsShown] and stays full after that; the
  /// exact count is carried by the line of text underneath.
  static const int maxStarsShown = 5;

  static int starsToDraw(int totalGames) {
    if (totalGames <= 0) return 0;
    if (totalGames >= maxStarsShown) return maxStarsShown;
    return totalGames;
  }
}
