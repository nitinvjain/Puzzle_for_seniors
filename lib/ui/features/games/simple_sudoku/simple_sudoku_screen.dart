import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puzzle/config/senior_mode.dart';
import 'package:puzzle/l10n/app_localizations.dart';

import '../../../../config/rewards.dart';
import '../../../../providers/user_providers.dart';
import '../../../../utils/design_system.dart';
import '../../../../utils/haptic_feedback.dart';
import '../../../../widgets/game_completion_dialog.dart';
import '../../../../widgets/tangible.dart';
import '../../../core/juice/game_scaffold.dart';
import 'simple_sudoku_engine.dart';

class SimpleSudokuScreen extends ConsumerStatefulWidget {
  const SimpleSudokuScreen({super.key});

  @override
  ConsumerState<SimpleSudokuScreen> createState() => _SimpleSudokuScreenState();
}

class _SimpleSudokuScreenState extends ConsumerState<SimpleSudokuScreen> {
  final SimpleSudokuEngine _engine = SimpleSudokuEngine();

  late SimpleSudokuPuzzle _puzzle;
  late List<List<int>> _entries; // 0 = still empty
  Point<int>? _selected;
  int _completed = 0;

  /// The 3x3 boxes that have already earned their stage points.
  ///
  /// A finished box is the one sub-goal sudoku really has: nine of them, each
  /// visibly bounded on the board, each small enough to finish in a sitting.
  /// Waiting for the whole grid would mean one reward for eighty-one cells.
  ///
  /// Held as a set rather than a count so that emptying a cell and refilling
  /// it cannot pay twice, and so that a box dealt already complete can be
  /// marked paid at the start and never earn anything he did not do.
  final Set<int> _boxesPaid = {};

  @override
  void initState() {
    super.initState();
    _newPuzzle();
  }

  void _newPuzzle() {
    final p = _engine.generate(maxBlanksPerUnit: 3);
    setState(() {
      _puzzle = p;
      _entries = [for (final row in p.puzzle) [...row]];
      _selected = null;
      _boxesPaid.clear();
      // Anything dealt already finished is marked paid before he touches it.
      for (var box = 0; box < 9; box++) {
        if (_boxIsDone(box)) _boxesPaid.add(box);
      }
    });
  }

  /// Is every cell of this 3x3 box filled in correctly?
  bool _boxIsDone(int box) {
    final first = (box ~/ 3) * 3;
    final second = (box % 3) * 3;
    for (var a = first; a < first + 3; a++) {
      for (var b = second; b < second + 3; b++) {
        if (_entries[a][b] != _puzzle.solution[a][b]) return false;
      }
    }
    return true;
  }

  /// Pay for any box finished since the last entry.
  void _payFinishedBoxes() {
    for (var box = 0; box < 9; box++) {
      if (_boxesPaid.contains(box)) continue;
      if (!_boxIsDone(box)) continue;
      _boxesPaid.add(box);
      ref
          .read(gameStreakNotifierProvider.notifier)
          .awardStage('simple_sudoku', xpAmount: Rewards.pointsPerStage);
    }
  }

  bool get _isSolved {
    for (var r = 0; r < 9; r++) {
      for (var c = 0; c < 9; c++) {
        if (_entries[r][c] != _puzzle.solution[r][c]) return false;
      }
    }
    return true;
  }

  void _enter(int value) {
    final sel = _selected;
    if (sel == null || _puzzle.isGiven(sel.x, sel.y)) return;
    setState(() => _entries[sel.x][sel.y] = value);
    if (value != 0 && value != _puzzle.solution[sel.x][sel.y]) {
      // Wrong answers simply do not advance: the digit sits there in red
      // until it is changed. Nothing is lost and nothing ends.
      HapticFeedbackUtil.error();
      return;
    }
    HapticFeedbackUtil.lightImpact();
    _payFinishedBoxes();
    if (_isSolved) _onSolved();
  }

  void _onSolved() {
    HapticFeedbackUtil.victory();
    _completed++;
    ref.read(gameStreakNotifierProvider.notifier).completeGame('simple_sudoku');
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => GameCompletionDialog(
        title: 'SIMPLE SUDOKU',
        message: l10n.completed,
        onHome: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
        onPlayAgain: () {
          Navigator.of(context).pop();
          _newPuzzle();
        },
      ),
    );
  }

  Widget _buildCell(int r, int c, double size, ColorScheme scheme) {
    final given = _puzzle.isGiven(r, c);
    final value = _entries[r][c];
    final selected = _selected == Point(r, c);
    final wrong = !given && value != 0 && value != _puzzle.solution[r][c];

    // Shade alternate 3x3 boxes so the box boundaries are obvious without
    // relying on line weight alone.
    final box = (r ~/ 3 + c ~/ 3) % 2 == 0;

    return GestureDetector(
      onTap: given ? null : () => setState(() => _selected = Point(r, c)),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: selected
              ? DesignSystem.accentAmber.withValues(alpha: 0.35)
              : (box
                  ? scheme.onSurface.withValues(alpha: 0.05)
                  : scheme.surface),
          border: Border(
            top: BorderSide(
              width: r % 3 == 0 ? 2.5 : 0.6,
              color: scheme.onSurface.withValues(alpha: r % 3 == 0 ? 0.8 : 0.3),
            ),
            left: BorderSide(
              width: c % 3 == 0 ? 2.5 : 0.6,
              color: scheme.onSurface.withValues(alpha: c % 3 == 0 ? 0.8 : 0.3),
            ),
            right: BorderSide(
              width: c == 8 ? 2.5 : 0,
              color: scheme.onSurface.withValues(alpha: 0.8),
            ),
            bottom: BorderSide(
              width: r == 8 ? 2.5 : 0,
              color: scheme.onSurface.withValues(alpha: 0.8),
            ),
          ),
        ),
        child: Center(
          child: Text(
            value == 0 ? '' : '$value',
            style: TextStyle(
              fontSize: size * 0.58,
              fontWeight: given ? FontWeight.w900 : FontWeight.w600,
              color: wrong
                  ? DesignSystem.error
                  : (given
                      ? scheme.onSurface
                      : DesignSystem.primary),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return GameScaffold(
      title: 'SIMPLE SUDOKU',
      subtitle: 'Every row, column and box holds 1 to 9',
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh_rounded),
          tooltip: 'New puzzle',
          onPressed: _newPuzzle,
        ),
      ],
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final boardSide = min(
              constraints.maxWidth - 16,
              constraints.maxHeight * 0.62,
            );
            final cell = boardSide / 9;

            return Column(
              children: [
                const SizedBox(height: DesignSystem.spaceSM),
                Expanded(
                  child: Center(
                    child: SizedBox(
                      width: cell * 9,
                      height: cell * 9,
                      child: Column(
                        children: List.generate(
                          9,
                          (r) => Row(
                            children: List.generate(
                              9,
                              (c) => _buildCell(r, c, cell, scheme),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: DesignSystem.spaceSM),
                // Number pad: 1-9 plus an eraser.
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: DesignSystem.spaceSM),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: DesignSystem.spaceXS,
                    runSpacing: DesignSystem.spaceXS,
                    children: [
                      for (var v = 1; v <= 9; v++)
                        TangibleButton(
                          color: scheme.surface,
                          radius: DesignSystem.radiusSM,
                          padding: EdgeInsets.zero,
                          onTap: () => _enter(v),
                          child: SizedBox(
                            width: SeniorMode.minTapTarget,
                            height: SeniorMode.minTapTarget,
                            child: Center(
                              child: Text(
                                '$v',
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w900,
                                  color: scheme.onSurface,
                                ),
                              ),
                            ),
                          ),
                        ),
                      TangibleButton(
                        color: scheme.surface,
                        radius: DesignSystem.radiusSM,
                        padding: EdgeInsets.zero,
                        onTap: () => _enter(0),
                        child: SizedBox(
                          width: SeniorMode.minTapTarget,
                          height: SeniorMode.minTapTarget,
                          child: Center(
                            child: Icon(
                              Icons.backspace_outlined,
                              size: 26,
                              color: scheme.onSurface,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: DesignSystem.spaceMD),
              ],
            );
          },
        ),
      ),
    );
  }
}
