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

/// Hands out questions so the player works through the bank before meeting
/// one again.
///
/// Drawing a fresh random five each game sounds like enough variety, but it
/// is not: with five hard questions drawn from two hundred, a repeat turns up
/// after about three games however big the bank gets. Growing the bank from
/// 117 questions to over a thousand would have been nearly invisible. So
/// instead each difficulty keeps a shuffled queue, and a game takes the next
/// few from the front. Every question in the bank is asked once before any is
/// asked twice -- around sixty-seven games at fifteen questions each.
///
/// The queues are static so they survive leaving the game and coming back.
/// They start afresh when the app restarts, which is fine: a new shuffle is
/// not a repeat.
class _QuestionPool {
  _QuestionPool._();

  static final Map<int, List<QuizQuestion>> _queues = {};
  static final Random _rng = Random();

  static List<QuizQuestion> _shuffledPool(int difficulty) =>
      quizQuestions.where((q) => q.difficulty == difficulty).toList()
        ..shuffle(_rng);

  static List<QuizQuestion> take(int difficulty, int count) {
    final queue = _queues.putIfAbsent(difficulty, () => _shuffledPool(difficulty));

    if (queue.length < count) {
      // Refill, keeping whatever is left at the front and leaving those out of
      // the new shuffle, so the queue holds each question exactly once and a
      // single round can never draw the same question twice.
      final leftover = List<QuizQuestion>.of(queue);
      final refill = _shuffledPool(difficulty)
        ..removeWhere((q) => leftover.contains(q));
      queue
        ..clear()
        ..addAll(leftover)
        ..addAll(refill);
    }

    final drawn = queue.take(count).toList();
    queue.removeRange(0, drawn.length);
    return drawn;
  }
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

  /// Bumped every time a game starts. A reveal that is still counting down
  /// when the game restarts belongs to a game that no longer exists, so it
  /// checks this before doing anything.
  int _generation = 0;

  @override
  void initState() {
    super.initState();
    _startGame();
  }

  void _startGame() {
    // Five easy, then five medium, then five hard: the ladder gets harder as
    // the prize money climbs, the way the television show does it.
    final round = <QuizQuestion>[];
    for (final level in [1, 2, 3]) {
      round.addAll(_QuestionPool.take(level, 5));
    }
    setState(() {
      _round = round;
      _rung = 0;
      _usedFiftyFifty = false;
      _generation++;
      _prepareQuestion();
    });
  }

  /// How many rungs this game has.
  ///
  /// The ladder is fifteen prizes long and the round is built to match. Taking
  /// the smaller of the two means that if a bank were ever edited down to
  /// fewer than five questions at some difficulty, the game would simply be
  /// shorter instead of running off the end of the list.
  int get _rungs => min(_round.length, _prizes.length);

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
      // Take the highest safe rung passed, not the last one looked at: a set
      // has no promised iteration order, so comparing is what makes this
      // right rather than luck.
      if (_rung > rung && _prizes[rung] > won) won = _prizes[rung];
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

    final generation = _generation;
    final correct = index == _question.answer;
    if (correct) {
      HapticFeedbackUtil.success();
      Future.delayed(const Duration(milliseconds: 1100), () {
        if (!mounted || generation != _generation) return;
        if (_rung >= _rungs - 1) {
          _finish(won: _prizes[_rungs - 1], perfect: true);
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
        if (!mounted || generation != _generation) return;
        _finish(won: _guaranteed, perfect: false);
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
            ? 'All $_rungs questions right — ₹${formatIndianNumber(won)}'
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

  /// One answer button.
  ///
  /// [index] is the position in the question's own options list, which is what
  /// decides the text and the right answer. [position] is where the button
  /// sits on screen, which is what decides its letter: the options are shown
  /// in a shuffled order, so taking the letter from [index] would label them
  /// out of sequence -- C above A above D -- and after the 50:50 would leave
  /// two letters with a gap between them.
  Widget _buildOption(
    int index,
    int position,
    QuizQuestion q,
    ColorScheme scheme,
  ) {
    final highlighted =
        _revealed && (index == _question.answer || index == _chosen);

    return Padding(
      padding: const EdgeInsets.only(bottom: DesignSystem.spaceSM),
      child: TangibleButton(
        color: _optionColor(index, scheme),
        radius: DesignSystem.radiusMD,
        // Deliberately always non-null. TangibleButton paints a disabled
        // button in a faded surface colour and ignores the colour passed to
        // it, which would throw away the green and the red at the exact
        // moment they matter. _answer ignores taps once the answer is shown,
        // so leaving this live costs nothing.
        onTap: () => _answer(index),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: DesignSystem.spaceSM,
            horizontal: DesignSystem.spaceXS,
          ),
          child: Row(
            children: [
              Text(
                '${String.fromCharCode(65 + position)}.  ',
                style: TextStyle(
                  fontSize: DesignSystem.fontSizeMD,
                  fontWeight: FontWeight.w900,
                  color: highlighted
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
                    color: highlighted ? Colors.white : scheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final q = _question;

    // The options in the order they will be shown, with anything the 50:50
    // removed already dropped, so the A-D labels can follow the rows.
    final visible = [
      for (final index in _optionOrder)
        if (!_hidden.contains(index)) index,
    ];

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
                      'Question ${_rung + 1} of $_rungs',
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
              // the same place. The letters follow the rows, not the
              // underlying order, so they always read A, B, C, D downwards.
              for (var position = 0; position < visible.length; position++)
                _buildOption(visible[position], position, q, scheme),

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
