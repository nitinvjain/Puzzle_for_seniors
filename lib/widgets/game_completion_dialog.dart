import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puzzle/config/rewards.dart';
import 'package:puzzle/config/senior_mode.dart';
import 'package:puzzle/l10n/app_localizations.dart';
import 'package:puzzle/utils/l10n_game_helpers.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/game_metadata.dart';
import '../data/game_registry.dart';
import '../data/models/game_streak.dart';
import '../utils/design_system.dart';
import '../utils/haptic_feedback.dart';
import '../utils/sound_feedback.dart';
import '../utils/navigation_utils.dart';
import '../providers/game_providers.dart';
import '../providers/game_session_provider.dart';
import '../providers/user_providers.dart';
import 'reward_banner.dart';
import 'tangible.dart';

class GameCompletionDialog extends ConsumerStatefulWidget {
  final VoidCallback onHome;
  final VoidCallback onPlayAgain;
  final String title;
  final String message;
  final bool isVictory;

  const GameCompletionDialog({
    super.key,
    required this.onHome,
    required this.onPlayAgain,
    this.title = '',
    required this.message,
    this.isVictory = true,
  });

  @override
  ConsumerState<GameCompletionDialog> createState() => _GameCompletionDialogState();
}

class _GameCompletionDialogState extends ConsumerState<GameCompletionDialog> {
  /// Senior build: there is no such thing as losing. Whatever the game passed
  /// in, the dialog is presented as a finish rather than a defeat — no "Game
  /// Over" heading, no error-buzz haptic, no score line.
  bool get _isVictory => SeniorMode.disableFailStates ? true : widget.isVictory;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_isVictory) {
        HapticFeedbackUtil.victory();
      } else {
        HapticFeedbackUtil.vibrate();
      }
      // Every one of the 310 games ends on this dialog, so the finishing
      // sound belongs here rather than in each of them. It plays either way:
      // reaching the end of a game is worth marking even when he did not get
      // everything right, and this build has nothing to say about that.
      SoundFeedbackUtil.complete();
    });
  }

  /// The "play this game again" button: green, labelled, with the circular
  /// arrow kept alongside the words rather than standing in for them.
  ///
  /// Green here is [DesignSystem.successDeep] rather than [DesignSystem.success]
  /// because the label sits on top of it in white, and the brighter mint is
  /// not dark enough to read against.
  Widget _playAgainButton(String label) {
    return TangibleButton(
      onTap: widget.onPlayAgain,
      color: DesignSystem.successDeep,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Center(
        // The label is sized from the type scale, which the senior build
        // multiplies by 1.35, so it is allowed to shrink rather than overflow
        // the button on a narrow dialog.
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.refresh_rounded, color: Colors.white, size: 20),
              const SizedBox(width: 6),
              Text(
                label.toUpperCase(),
                style: const TextStyle(
                  fontFamily: 'Geist',
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: DesignSystem.fontSizeMD,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// What the game just finished was worth, taken from the log exactly once
  /// on the first build. Taking it inside build would show the figure the
  /// first time the dialog painted and zero on every rebuild after it.
  late final RewardTally _tally = RewardLog.take();

  /// What the reward banner should show.
  ///
  /// Everything here is derived from counters the app already keeps, so the
  /// reward needs no storage of its own and his existing history counts.
  ///
  /// What the finish was worth comes from RewardLog, which the award calls
  /// write to as they happen, rather than from a flag threaded down through
  /// three hundred game screens.
  RewardSnapshot _rewardSnapshot(
    Map<String, GameStreak> streaks,
    String? lastGameId,
  ) {
    final userData = ref.read(userDataNotifierProvider);
    final total = userData.totalSolved ?? 0;
    final gamesToday = streaks.values.where((s) => s.solvedToday).length;

    return RewardSnapshot(
      pointsEarned: _tally.points,
      totalPoints: userData.xp,
      totalGames: total,
      gamesToday: gamesToday,
      // Only when the count of games finished actually moved. Hanging this
      // off "a game was just finished" instead meant a replay re-announced
      // the same milestone every time, which empties it of all meaning.
      milestone: _tally.countedNewGame ? Rewards.milestoneLabel(total) : null,
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!mounted) return const SizedBox.shrink();
    final l10n = AppLocalizations.of(context);
    if (l10n == null) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final session = ref.read(gameSessionNotifierProvider);
    final localizedTitles = {
      for (final game in allGamesMetadata)
        game.id: L10nGameHelpers.getGameTitle(context, game.id),
    };
    final gameList = ref.read(filteredGamesProvider(
      searchQuery: session.searchQuery,
      selectedCategory: session.selectedCategory,
      localizedTitles: localizedTitles,
    ));
    final streaks = ref.read(gameStreakNotifierProvider);

    GameMetadata? nextGame;
    bool isSameGame = true;

    if (gameList.isNotEmpty) {
      final currentIndex = session.lastGameId != null
          ? gameList.indexWhere((g) => g.id == session.lastGameId)
          : -1;

      // 1. Search forward from currentIndex + 1 for an unsolved game (not solved today)
      int searchStart = currentIndex != -1 ? (currentIndex + 1) % gameList.length : 0;
      for (int i = 0; i < gameList.length; i++) {
        final idx = (searchStart + i) % gameList.length;
        if (idx == currentIndex) continue;
        final candidate = gameList[idx];
        final isSolvedToday = streaks[candidate.id]?.solvedToday ?? false;
        if (!isSolvedToday) {
          nextGame = candidate;
          break;
        }
      }

      // 2. If all games are solved today, simply pick the next game in order
      if (nextGame == null) {
        if (currentIndex != -1) {
          final nextIndex = (currentIndex + 1) % gameList.length;
          nextGame = gameList[nextIndex];
        } else {
          nextGame = gameList.first;
        }
      }

      isSameGame = nextGame.id == session.lastGameId;
    }

    final next = nextGame;

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: DesignSystem.spaceLG),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 380),
        child: TangibleContainer(
          radius: DesignSystem.radiusLG,
          padding: const EdgeInsets.all(DesignSystem.spaceLG),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Senior build hides the review / report-issue links: both open
              // an external browser, which is a dead end for him.
              if (!SeniorMode.enabled)
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () => _launchUrl('https://play.google.com/store/apps/details?id=com.sidhant.puzzle'),
                      borderRadius: BorderRadius.circular(DesignSystem.radiusXS),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              size: 14,
                              color: DesignSystem.accentAmber,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              l10n.leaveReview.toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                color: colorScheme.onSurface.withValues(alpha: 0.6),
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 12,
                      color: colorScheme.outline.withValues(alpha: 0.5),
                    ),
                    InkWell(
                      onTap: () => _launchUrl('https://github.com/sidhant947/Puzzle/issues'),
                      borderRadius: BorderRadius.circular(DesignSystem.radiusXS),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.bug_report_rounded,
                              size: 14,
                              color: DesignSystem.error,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              l10n.reportError.toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                color: colorScheme.onSurface.withValues(alpha: 0.6),
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: DesignSystem.spaceMD),
              Text(
                // A game that passed a defeat title ("Game Over", "You Lose")
                // gets a neutral, already-localised heading instead.
                (SeniorMode.disableFailStates && !widget.isVictory
                        ? l10n.wellDone
                        : widget.title)
                    .toUpperCase(),
                textAlign: TextAlign.center,
                style: theme.textTheme.displaySmall?.copyWith(
                  fontSize: 32,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: DesignSystem.spaceSM),
              // The per-game message carries the score ("SCORE: 240"), so the
              // senior build drops it and leaves the congratulation alone.
              if (!SeniorMode.disableScoring)
              Text(
                widget.message.toUpperCase(),
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.7),
                  fontWeight: FontWeight.w700,
                  fontSize: 13.5,
                ),
              ),
              if (Rewards.enabled) ...[
                const SizedBox(height: DesignSystem.spaceMD),
                RewardBanner(snapshot: _rewardSnapshot(streaks, session.lastGameId)),
              ],
              const SizedBox(height: DesignSystem.spaceLG),
              if (next != null && !isSameGame)
                Row(
                  children: [
                    // Replaying the same game used to be a bare circular
                    // arrow in the same pale colour as everything else, a
                    // quarter the width of PLAY NEXT. It is the thing he most
                    // often wants, so it now says what it does, in green, and
                    // takes equal space.
                    Expanded(
                      child: _playAgainButton(l10n.playAgain),
                    ),
                    const SizedBox(width: DesignSystem.spaceSM),
                    Expanded(
                      child: TangibleButton(
                        onTap: () {
                          ref.read(gameSessionNotifierProvider.notifier).setSession(
                            gameId: next.id,
                            category: session.selectedCategory,
                            query: session.searchQuery,
                          );
                          final nav = Navigator.of(context);
                          nav.pop();
                          nav.pushReplacement(
                            CustomPageRoute(page: next.builder(nav.context)),
                          );
                        },
                        color: DesignSystem.primary,
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              l10n.playNext.toUpperCase(),
                              style: const TextStyle(
                                fontFamily: 'Geist',
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: DesignSystem.fontSizeMD,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              else
                // Nothing different to move on to, so play again gets the
                // whole width — still green, so the button he is looking for
                // is the same colour wherever it appears.
                _playAgainButton(l10n.playAgain),
              const SizedBox(height: DesignSystem.spaceMD),
              Row(
                children: [
                  Expanded(
                    child: TangibleButton(
                      onTap: widget.onHome,
                      color: colorScheme.surface,
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                      child: Center(
                        child: Text(
                          l10n.home.toUpperCase(),
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: colorScheme.onSurface.withValues(alpha: 0.6),
                            fontWeight: FontWeight.w700,
                            fontSize: DesignSystem.fontSizeSM,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: DesignSystem.spaceSM),
                  Expanded(
                    child: TangibleButton(
                      onTap: () {
                        final navigator = Navigator.of(context);
                        navigator.pop();
                        navigator.push(
                          PageRouteBuilder(
                            opaque: false,
                            barrierColor: Colors.black.withValues(alpha: 0.05),
                            transitionDuration: const Duration(milliseconds: 200),
                            pageBuilder: (reviewCtx, _, __) {
                              return Consumer(
                                builder: (reviewCtx, ref, _) {
                                  final reviewTheme = Theme.of(reviewCtx);
                                  final reviewColorScheme = reviewTheme.colorScheme;
                                  final reviewL10n = AppLocalizations.of(reviewCtx) ?? l10n;

                                  return Material(
                                    color: Colors.transparent,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 0,
                                          right: 0,
                                          bottom: 0,
                                          child: SafeArea(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: DesignSystem.spaceLG,
                                                right: DesignSystem.spaceLG,
                                                bottom: DesignSystem.spaceXL,
                                              ),
                                              child: Center(
                                                child: Container(
                                                  width: double.infinity,
                                                  constraints: const BoxConstraints(maxWidth: 380),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: TangibleButton(
                                                          onTap: () {
                                                            final nav = Navigator.of(reviewCtx);
                                                            nav.popUntil((route) => route.isFirst);
                                                          },
                                                          color: reviewColorScheme.surface,
                                                          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                                                          child: Center(
                                                            child: Text(
                                                              reviewL10n.home.toUpperCase(),
                                                              style: reviewTheme.textTheme.labelMedium?.copyWith(
                                                                color: reviewColorScheme.onSurface.withValues(alpha: 0.7),
                                                                fontWeight: FontWeight.w700,
                                                                fontSize: DesignSystem.fontSizeMD,
                                                                letterSpacing: 0.5,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(width: DesignSystem.spaceMD),
                                                      Expanded(
                                                        child: TangibleButton(
                                                          onTap: () {
                                                            final nav = Navigator.of(reviewCtx);
                                                            if (next != null) {
                                                              ref.read(gameSessionNotifierProvider.notifier).setSession(
                                                                gameId: next.id,
                                                                category: session.selectedCategory,
                                                                query: session.searchQuery,
                                                              );
                                                              nav.pushAndRemoveUntil(
                                                                CustomPageRoute(page: next.builder(nav.context)),
                                                                (route) => route.isFirst,
                                                              );
                                                            } else {
                                                              nav.popUntil((route) => route.isFirst);
                                                            }
                                                          },
                                                          // Green when it means
                                                          // play again, so that
                                                          // button is the same
                                                          // colour everywhere.
                                                          color: next != null && !isSameGame
                                                              ? DesignSystem.primary
                                                              : DesignSystem.successDeep,
                                                          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                                                          child: Center(
                                                            child: Text(
                                                              (next != null && !isSameGame ? reviewL10n.playNext : reviewL10n.playAgain).toUpperCase(),
                                                              style: const TextStyle(
                                                                fontFamily: 'Geist',
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.w700,
                                                                fontSize: DesignSystem.fontSizeMD,
                                                                letterSpacing: 0.5,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        );
                      },
                      color: colorScheme.surface,
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            l10n.seeCompleted.toUpperCase(),
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: colorScheme.onSurface.withValues(alpha: 0.6),
                              fontWeight: FontWeight.w700,
                              fontSize: DesignSystem.fontSizeSM,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: DesignSystem.spaceMD),
              // Also hidden in the senior build, for the same reason as the
              // review and report-issue links above: it opens an external
              // browser, which he cannot get back from.
              if (!SeniorMode.enabled)
              InkWell(
                onTap: () => _launchUrl('https://ko-fi.com/sidhant947'),
                borderRadius: BorderRadius.circular(DesignSystem.radiusXS),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.local_cafe_rounded,
                        size: 14,
                        color: DesignSystem.accentAmber,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'BUY ME A COFFEE',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: colorScheme.onSurface.withValues(alpha: 0.7),
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
