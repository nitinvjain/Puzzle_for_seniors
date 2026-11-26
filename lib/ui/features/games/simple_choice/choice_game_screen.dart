import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puzzle/config/senior_mode.dart';

import '../../../../providers/user_providers.dart';
import '../../../../config/rewards.dart';
import '../../../../utils/design_system.dart';
import '../../../../utils/haptic_feedback.dart';
import '../../../../widgets/game_completion_dialog.dart';
import '../../../../widgets/tangible.dart';
import '../../../core/juice/game_scaffold.dart';
import 'choice_question.dart';

/// The screen behind the five four-answer games.
///
/// Built around what stays rather than what goes. There is no clock, nothing
/// to hold in mind between one question and the next, and no way to lose: a
/// wrong answer shows which one was right, in green, and the game moves on.
/// Getting one wrong costs nothing but the point, so the game can be played
/// badly for an hour without ever telling him he has failed.
class ChoiceGameScreen extends ConsumerStatefulWidget {
  /// The game's id, for recording a finished round.
  final String gameId;
  final String title;
  final String subtitle;

  /// The whole pool. A round is drawn from it; it does not have to be large,
  /// but the bigger it is the longer before a question comes round again.
  final List<ChoiceQuestion> pool;

  /// Built fresh instead of drawn from [pool], for a game whose questions are
  /// generated rather than written down. Takes precedence over [pool].
  final List<ChoiceQuestion> Function(Random random, int count)? generate;

  const ChoiceGameScreen({
    super.key,
    required this.gameId,
    required this.title,
    required this.subtitle,
    this.pool = const [],
    this.generate,
  });

  @override
  ConsumerState<ChoiceGameScreen> createState() => _ChoiceGameScreenState();
}

class _ChoiceGameScreenState extends ConsumerState<ChoiceGameScreen> {
  /// Fifteen is a sitting, not a marathon. The other games run to fifty, but
  /// fifty of these is a long time to concentrate, and Play Again is right
  /// there for a day when he wants more.
  static const int _roundLength = 15;

  final Random _random = Random();

  late List<ChoiceQuestion> _round;
  late List<int> _order; // display order of the current question's options
  int _index = 0;
  int _right = 0;
  int? _chosen;
  bool _revealed = false;

  /// Bumped when a round starts, so a reveal still counting down from the
  /// previous round cannot advance this one.
  int _generation = 0;

  @override
  void initState() {
    super.initState();
    _startRound();
  }

  void _startRound() {
    final drawn = widget.generate != null
        ? widget.generate!(_random, _roundLength)
        : (<ChoiceQuestion>[...widget.pool]..shuffle(_random))
            .take(_roundLength)
            .toList();
    setState(() {
      _round = drawn;
      _index = 0;
      _right = 0;
      _generation++;
      _prepare();
    });
  }

  void _prepare() {
    _chosen = null;
    _revealed = false;
    _order = [0, 1, 2, 3]..shuffle(_random);
  }

  ChoiceQuestion get _question => _round[_index];

  void _answer(int index) {
    if (_revealed) return;
    final correct = index == _question.answer;
    setState(() {
      _chosen = index;
      _revealed = true;
      if (correct) _right++;
    });

    if (correct) {
      HapticFeedbackUtil.success();
      ref
          .read(gameStreakNotifierProvider.notifier)
          .awardStage(widget.gameId, xpAmount: Rewards.pointsPerStage);
    } else {
      HapticFeedbackUtil.selectionClick();
    }

    final generation = _generation;
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (!mounted || generation != _generation) return;
      if (_index >= _round.length - 1) {
        _finish();
      } else {
        setState(() {
          _index++;
          _prepare();
        });
      }
    });
  }

  void _finish() {
    HapticFeedbackUtil.victory();
    ref.read(gameStreakNotifierProvider.notifier).completeGame(widget.gameId);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => GameCompletionDialog(
        title: widget.title.toUpperCase(),
        message: 'You got $_right of ${_round.length} right',
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

  Color _optionColor(int index, ColorScheme scheme) {
    if (!_revealed) return scheme.surface;
    if (index == _question.answer) return DesignSystem.successDeep;
    if (index == _chosen) return DesignSystem.error;
    return scheme.surface;
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final q = _question;

    return GameScaffold(
      title: widget.title.toUpperCase(),
      subtitle: widget.subtitle,
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
                'Question ${_index + 1} of ${_round.length}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: DesignSystem.fontSizeSM,
                  fontWeight: FontWeight.w700,
                  color: scheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
              const SizedBox(height: DesignSystem.spaceLG),

              // The prompt, given room: it is the thing to read.
              TangibleContainer(
                radius: DesignSystem.radiusMD,
                padding: const EdgeInsets.all(DesignSystem.spaceLG),
                child: Column(
                  children: [
                    Text(
                      q.prompt,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: DesignSystem.fontSizeXL,
                        fontWeight: FontWeight.w800,
                        height: 1.4,
                        color: scheme.onSurface,
                      ),
                    ),
                    if (q.note.isNotEmpty) ...[
                      const SizedBox(height: DesignSystem.spaceSM),
                      Text(
                        q.note,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: DesignSystem.fontSizeSM,
                          fontWeight: FontWeight.w600,
                          color: scheme.onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: DesignSystem.spaceLG),

              for (var position = 0; position < _order.length; position++)
                _buildOption(_order[position], q, scheme),

              if (!SeniorMode.disableScoring) ...[
                const SizedBox(height: DesignSystem.spaceMD),
                Text(
                  'Right so far: $_right',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: DesignSystem.fontSizeSM,
                    fontWeight: FontWeight.w700,
                    color: scheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ],
              const SizedBox(height: DesignSystem.spaceLG),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOption(int index, ChoiceQuestion q, ColorScheme scheme) {
    final highlighted =
        _revealed && (index == _question.answer || index == _chosen);

    return Padding(
      padding: const EdgeInsets.only(bottom: DesignSystem.spaceSM),
      child: TangibleButton(
        color: _optionColor(index, scheme),
        radius: DesignSystem.radiusMD,
        // Deliberately always non-null: TangibleButton paints a disabled
        // button in a faded surface colour and throws away the colour passed
        // to it, which would lose the green at the moment it matters.
        // _answer ignores taps once the answer is showing.
        onTap: () => _answer(index),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: DesignSystem.spaceMD,
            horizontal: DesignSystem.spaceXS,
          ),
          child: Center(
            child: Text(
              q.options[index],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: DesignSystem.fontSizeLG,
                fontWeight: FontWeight.w700,
                color: highlighted ? Colors.white : scheme.onSurface,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
