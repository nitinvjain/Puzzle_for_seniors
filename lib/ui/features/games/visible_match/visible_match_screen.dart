import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers/user_providers.dart';
import '../../../../utils/design_system.dart';
import '../../../../utils/haptic_feedback.dart';
import '../../../../utils/sound_feedback.dart';
import '../../../../widgets/game_completion_dialog.dart';
import '../../../../widgets/tangible.dart';
import '../../../core/juice/game_scaffold.dart';
import 'visible_match_data.dart';

/// Match the thing on the left to the thing on the right.
///
/// Both columns stay face up, which is the whole point. The familiar pairs
/// game hides the cards and asks you to remember where they were -- that is
/// working memory, the first thing dementia takes, so the gentlest-looking
/// game on the shelf turns out to be the cruellest. Here nothing is hidden
/// and nothing is timed: it asks only whether he knows that Jaipur goes with
/// Rajasthan, which is knowledge he has had for sixty years.
///
/// A wrong pairing does nothing at all. It does not buzz, deduct, or reset --
/// the two tiles simply let go of each other and he can try again.
class VisibleMatchScreen extends ConsumerStatefulWidget {
  const VisibleMatchScreen({super.key});

  @override
  ConsumerState<VisibleMatchScreen> createState() => _VisibleMatchScreenState();
}

class _VisibleMatchScreenState extends ConsumerState<VisibleMatchScreen> {
  /// Boards per round. Four pairs each, so a round is twenty-four matches.
  static const int _boards = 6;
  static const int _pairsPerBoard = 4;

  final Random _random = Random();

  late List<MatchPair> _pairs; // the four pairs on this board
  late List<String> _rightColumn; // shuffled right-hand labels
  String? _selectedLeft;
  final Set<String> _solved = {}; // left labels already matched
  int _board = 0;
  int _matches = 0;

  @override
  void initState() {
    super.initState();
    _startRound();
  }

  void _startRound() {
    setState(() {
      _board = 0;
      _matches = 0;
      _dealBoard();
    });
  }

  void _dealBoard() {
    final set = matchSets[_random.nextInt(matchSets.length)];
    // Two pairs sharing a right-hand label would put the same tile on the
    // board twice and leave one of them impossible to match, so a board is
    // built from pairs whose right-hand labels are all different.
    final chosen = <MatchPair>[];
    final taken = <String>{};
    for (final pair in [...set.pairs]..shuffle(_random)) {
      if (!taken.add(pair.right)) continue;
      chosen.add(pair);
      if (chosen.length == _pairsPerBoard) break;
    }
    _pairs = chosen;
    _rightColumn = chosen.map((p) => p.right).toList()..shuffle(_random);
    _selectedLeft = null;
    _solved.clear();
  }

  String get _heading {
    for (final set in matchSets) {
      if (set.pairs.any((p) => p.left == _pairs.first.left)) return set.prompt;
    }
    return 'Match each one to its pair';
  }

  void _tapLeft(String left) {
    if (_solved.contains(left)) return;
    HapticFeedbackUtil.selectionClick();
    setState(() => _selectedLeft = _selectedLeft == left ? null : left);
  }

  void _tapRight(String right) {
    final left = _selectedLeft;
    if (left == null) return;
    if (_solved.contains(left)) return;

    final pair = _pairs.firstWhere((p) => p.left == left);
    if (pair.right != right) {
      // Wrong: let go, and say nothing about it.
      setState(() => _selectedLeft = null);
      return;
    }

    HapticFeedbackUtil.success();
    SoundFeedbackUtil.merge();
    setState(() {
      _solved.add(left);
      _selectedLeft = null;
      _matches++;
    });

    if (_solved.length == _pairs.length) {
      Future.delayed(const Duration(milliseconds: 700), () {
        if (!mounted) return;
        if (_board >= _boards - 1) {
          _finish();
        } else {
          setState(() {
            _board++;
            _dealBoard();
          });
        }
      });
    }
  }

  void _finish() {
    HapticFeedbackUtil.victory();
    SoundFeedbackUtil.complete();
    ref.read(gameStreakNotifierProvider.notifier).completeGame('visible_match');
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => GameCompletionDialog(
        title: 'MATCHING PAIRS',
        message: 'You matched $_matches pairs',
        onHome: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
        onPlayAgain: () {
          Navigator.of(context).pop();
          _startRound();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return GameScaffold(
      title: 'MATCHING PAIRS',
      subtitle: 'Tap one on the left, then its pair on the right',
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh_rounded),
          tooltip: 'Start again',
          onPressed: _startRound,
        ),
      ],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(DesignSystem.spaceMD),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Board ${_board + 1} of $_boards',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: DesignSystem.fontSizeSM,
                  fontWeight: FontWeight.w700,
                  color: scheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
              const SizedBox(height: DesignSystem.spaceSM),
              Text(
                _heading,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: DesignSystem.fontSizeLG,
                  fontWeight: FontWeight.w800,
                  color: scheme.onSurface,
                ),
              ),
              const SizedBox(height: DesignSystem.spaceLG),
              LayoutBuilder(builder: (context, box) {
                // Two columns with a gap between them.
                final tileWidth =
                    (box.maxWidth - DesignSystem.spaceMD) / 2;
                final fontSize = _labelFontSize(
                  tileWidth,
                  MediaQuery.textScalerOf(context).scale(100.0) / 100.0,
                );
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          for (final pair in _pairs)
                            _tile(
                              label: pair.left,
                              done: _solved.contains(pair.left),
                              selected: _selectedLeft == pair.left,
                              onTap: () => _tapLeft(pair.left),
                              scheme: scheme,
                              fontSize: fontSize,
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(width: DesignSystem.spaceMD),
                    Expanded(
                      child: Column(
                        children: [
                          for (final right in _rightColumn)
                            _tile(
                              label: right,
                              done: _pairs.any((p) =>
                                  p.right == right && _solved.contains(p.left)),
                              selected: false,
                              onTap: () => _tapRight(right),
                              scheme: scheme,
                              fontSize: fontSize,
                            ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
              const SizedBox(height: DesignSystem.spaceMD),
              Text(
                'Pairs matched: $_matches',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: DesignSystem.fontSizeSM,
                  fontWeight: FontWeight.w700,
                  color: scheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: DesignSystem.spaceLG),
            ],
          ),
        ),
      ),
    );
  }

  /// One type size for every tile on the board.
  ///
  /// A bare FittedBox lets each tile shrink on its own, so Jaipur came out
  /// large and Thiruvananthapuram came out tiny in the same column and
  /// several blocks ended up too small to read. Sizing them all to the
  /// longest label on the board keeps them even and legible.
  ///
  /// Labels may take three lines, so what has to fit on one line is the
  /// longest unbreakable word rather than the whole label: "The Grand Old
  /// Man of India" is twenty-six characters but its longest word is five.
  double _labelFontSize(double tileWidth, double textScale) {
    final labels = <String>[
      for (final p in _pairs) p.left,
      ..._rightColumn,
    ];
    final needs = <double>[];
    for (final label in labels) {
      final words = label.split(' ');
      double longestWord = 1;
      for (final w in words) {
        if (w.length > longestWord) longestWord = w.length.toDouble();
      }
      final overThreeLines = (label.length / 3).ceilToDouble();
      needs.add(longestWord > overThreeLines ? longestWord : overThreeLines);
    }
    needs.sort((a, b) => b.compareTo(a));
    // Size to the second longest, not the longest.
    //
    // One unbreakable outlier -- Thiruvananthapuram is eighteen characters
    // with nowhere to wrap -- would otherwise drag all eight tiles down to
    // the floor to accommodate it. Sizing to the next one down keeps seven
    // tiles properly large and lets the FittedBox shrink the one that
    // genuinely cannot fit.
    final longest = needs.length > 1 ? needs[1] : needs.first;
    final budget = tileWidth - (DesignSystem.spaceXS + _tileBorder) * 2;
    final scale = textScale <= 0 ? 1.0 : textScale;
    // 0.62 em per character is the widest the app's font runs at this weight.
    return (budget / (longest * 0.62 * scale))
        .clamp(13.0, DesignSystem.fontSizeLG);
  }

  /// Thicker than the app default, so each block reads as its own object.
  static const double _tileBorder = 3.0;

  Widget _tile({
    required String label,
    required bool done,
    required bool selected,
    required VoidCallback onTap,
    required ColorScheme scheme,
    required double fontSize,
  }) {
    final color = done
        ? DesignSystem.successDeep
        : (selected ? DesignSystem.accentAmber : scheme.surface);
    return Padding(
      padding: const EdgeInsets.only(bottom: DesignSystem.spaceSM),
      child: TangibleButton(
        color: color,
        radius: DesignSystem.radiusMD,
        borderWidth: _tileBorder,
        // Always live, so TangibleButton keeps the colour it is given; a
        // matched tile ignores its own taps instead of being disabled.
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: DesignSystem.spaceMD,
            horizontal: DesignSystem.spaceXS,
          ),
          child: Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 3,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w800,
                  color: done || selected ? Colors.white : scheme.onSurface,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
