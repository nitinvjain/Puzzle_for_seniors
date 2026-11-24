import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers/user_providers.dart';
import '../../../../utils/design_system.dart';
import '../../../../utils/haptic_feedback.dart';
import '../../../../widgets/game_completion_dialog.dart';
import '../../../../widgets/tangible.dart';
import '../../../core/juice/game_scaffold.dart';
import 'quiz_ladder_questions.dart';

/// A fifteen-rung prize ladder, in the shape everyone in India already knows.
/// The money is imaginary; the point is the climb.
const List<int> _prizes = [
  1000, 2000, 3000, 5000, 10000, // ₹10,000 guaranteed
  20000, 40000, 80000, 160000, 320000, // ₹3,20,000 guaranteed
  640000, 1250000, 2500000, 5000000, 10000000,
];

/// Rungs you cannot fall below once passed, as indices into [_prizes].
const Set<int> _safeRungs = {4, 9};

/// Groups digits the Indian way — 1,00,00,000 rather than 10,000,000: three
/// digits at the end, then pairs.
String formatIndianNumber(int value) {
  final digits = value.toString();
  if (digits.length <= 3) return digits;
  final lastThree = digits.substring(digits.length - 3);
  var remaining = digits.substring(0, digits.length - 3);
  final groups = <String>[];
  while (remaining.length > 2) {
    groups.insert(0, remaining.substring(remaining.length - 2));
    remaining = remaining.substring(0, remaining.length - 2);
  }
  if (remaining.isNotEmpty) groups.insert(0, remaining);
  return '${groups.join(',')},$lastThree';
}

class QuizLadderScreen extends ConsumerStatefulWidget {
  const QuizLadderScreen({super.key});

  @override
  ConsumerState<QuizLadderScreen> createState() => _QuizLadderScreenState();
}

class _QuizLadderScreenState extends ConsumerState<QuizLadderScreen> {
  final Random _random = Random();

  late List<QuizQuestion> _round;
  late List<int> _optionOrder; // display order of the current question
  int _rung = 0;
  int? _chosen;
  bool _revealed = false;
  bool _usedFiftyFifty = false;
  Set<int> _hidden = {};

  @override
  void initState() {
    super.initState();
    _startGame();
  }

  void _startGame() {
    final byDifficulty = {1: <QuizQuestion>[], 2: <QuizQuestion>[], 3: <QuizQuestion>[]};
    for (final q in quizQuestions) {
      byDifficulty[q.difficulty]?.add(q);
    }
    final round = <QuizQuestion>[];
    for (final level in [1, 2, 3]) {
      final pool = [...byDifficulty[level]!]..shuffle(_random);
      round.addAll(pool.take(5));
    }
    setState(() {
      _round = round;
      _rung = 0;
      _usedFiftyFifty = false;
      _prepareQuestion();
    });
  }

  void _prepareQuestion() {
    _chosen = null;
    _revealed = false;
    _hidden = {};
    _optionOrder = [0, 1, 2, 3]..shuffle(_random);
  }

  QuizQuestion get _question => _round[_rung];

  /// The amount already banked if the player stops or slips here.
  int get _guaranteed {
    var won = 0;
    for (final rung in _safeRungs) {
      if (_rung > rung) won = _prizes[rung];
    }
    return won;
  }

  void _useFiftyFifty() {
    if (_usedFiftyFifty || _revealed) return;
    final wrong = [for (var i = 0; i < 4; i++) if (i != _question.answer) i]
      ..shuffle(_random);
    setState(() {
      _usedFiftyFifty = true;
      _hidden = wrong.take(2).toSet();
    });
  }

  void _answer(int index) {
    if (_revealed) return;
    setState(() {
      _chosen = index;
      _revealed = true;
    });

    final correct = index == _question.answer;
    if (correct) {
      HapticFeedbackUtil.success();
      Future.delayed(const Duration(milliseconds: 1100), () {
        if (!mounted) return;
        if (_rung == _prizes.length - 1) {
          _finish(won: _prizes.last, perfect: true);
        } else {
          setState(() {
            _rung++;
            _prepareQuestion();
          });
        }
      });
    } else {
      HapticFeedbackUtil.error();
      Future.delayed(const Duration(milliseconds: 1600), () {
        if (mounted) _finish(won: _guaranteed, perfect: false);
      });
    }
  }

  void _finish({required int won, required bool perfect}) {
    if (perfect) {
      ref.read(gameStreakNotifierProvider.notifier).completeGame('quiz_ladder');
    }
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => GameCompletionDialog(
        title: perfect ? 'YOU WON THE TOP PRIZE' : 'GOOD GAME',
        message: perfect
            ? 'All fifteen questions right — ₹${formatIndianNumber(won)}'
            : (won > 0
                ? 'You take home ₹${formatIndianNumber(won)}'
                : 'No prize this time — have another go'),
        onHome: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
        onPlayAgain: () {
          Navigator.of(context).pop();
          _startGame();
        },
      ),
    );
  }

  // --- rendering -----------------------------------------------------------

  Color _optionColor(int index, ColorScheme scheme) {
    if (!_revealed) return scheme.surface;
    if (index == _question.answer) return DesignSystem.success;
    if (index == _chosen) return DesignSystem.error;
    return scheme.surface;
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final q = _question;

    return GameScaffold(
      title: 'QUIZ LADDER',
      subtitle: 'Fifteen questions, climbing for the top prize',
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh_rounded),
          tooltip: 'Start again',
          onPressed: _startGame,
        ),
      ],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(DesignSystem.spaceMD),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Where we are on the ladder.
              TangibleContainer(
                radius: DesignSystem.radiusMD,
                padding: const EdgeInsets.all(DesignSystem.spaceMD),
                child: Column(
                  children: [
                    Text(
                      'Question ${_rung + 1} of ${_prizes.length}',
                      style: TextStyle(
                        fontSize: DesignSystem.fontSizeSM,
                        fontWeight: FontWeight.w700,
                        color: scheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                    const SizedBox(height: DesignSystem.spaceXS),
                    Text(
                      'Playing for ₹${formatIndianNumber(_prizes[_rung])}',
                      style: TextStyle(
                        fontSize: DesignSystem.fontSizeXL,
                        fontWeight: FontWeight.w900,
                        color: DesignSystem.accentAmber,
                      ),
                    ),
                    if (_guaranteed > 0) ...[
                      const SizedBox(height: DesignSystem.spaceXS),
                      Text(
                        'Guaranteed so far: ₹${formatIndianNumber(_guaranteed)}',
                        style: TextStyle(
                          fontSize: DesignSystem.fontSizeSM,
                          fontWeight: FontWeight.w600,
                          color: DesignSystem.success,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: DesignSystem.spaceLG),

              // The question.
              Text(
                q.topic.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: DesignSystem.fontSize2XS,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                  color: scheme.primary,
                ),
              ),
              const SizedBox(height: DesignSystem.spaceSM),
              Text(
                q.question,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: DesignSystem.fontSizeLG,
                  fontWeight: FontWeight.w700,
                  height: 1.4,
                  color: scheme.onSurface,
                ),
              ),
              const SizedBox(height: DesignSystem.spaceLG),

              // Options, in a shuffled order so the answer is not always in
              // the same place.
              for (final index in _optionOrder)
                if (!_hidden.contains(index))
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: DesignSystem.spaceSM),
                    child: TangibleButton(
                      color: _optionColor(index, scheme),
                      radius: DesignSystem.radiusMD,
                      onTap: _revealed ? null : () => _answer(index),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: DesignSystem.spaceSM,
                          horizontal: DesignSystem.spaceXS,
                        ),
                        child: Row(
                          children: [
                            Text(
                              '${String.fromCharCode(65 + index)}.  ',
                              style: TextStyle(
                                fontSize: DesignSystem.fontSizeMD,
                                fontWeight: FontWeight.w900,
                                color: _revealed &&
                                        (index == _question.answer ||
                                            index == _chosen)
                                    ? Colors.white
                                    : scheme.onSurface.withValues(alpha: 0.6),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                q.options[index],
                                style: TextStyle(
                                  fontSize: DesignSystem.fontSizeMD,
                                  fontWeight: FontWeight.w700,
                                  color: _revealed &&
                                          (index == _question.answer ||
                                              index == _chosen)
                                      ? Colors.white
                                      : scheme.onSurface,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

              const SizedBox(height: DesignSystem.spaceMD),
              // One lifeline, which is plenty: more would be more to remember.
              TangibleButton(
                color: _usedFiftyFifty
                    ? scheme.surface
                    : DesignSystem.gamePurple,
                radius: DesignSystem.radiusMD,
                onTap: _usedFiftyFifty || _revealed ? null : _useFiftyFifty,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: DesignSystem.spaceSM),
                  child: Center(
                    child: Text(
                      _usedFiftyFifty
                          ? '50 : 50  already used'
                          : 'USE 50 : 50  (removes two wrong answers)',
                      style: TextStyle(
                        fontSize: DesignSystem.fontSizeSM,
                        fontWeight: FontWeight.w900,
                        color: _usedFiftyFifty
                            ? scheme.onSurface.withValues(alpha: 0.5)
                            : Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: DesignSystem.spaceLG),
            ],
          ),
        ),
      ),
    );
  }
}
