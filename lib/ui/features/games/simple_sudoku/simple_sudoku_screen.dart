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
import '../../../../widgets/grid_drop_area.dart';
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

  /// The digit chosen from the pad, 0 for the eraser.
  ///
  /// Cross Math works by picking a value and then touching the square it
  /// goes in, and NJ wants that one technique everywhere, so his father
  /// learns it once. Both orders work here, exactly as they do there: pick a
  /// digit then tap squares, or tap a square then pick a digit.
  ///
  /// One difference from Cross Math, on purpose. There a tray tile is used
  /// up when placed, so the selection clears. A sudoku digit is not used up
  /// -- a 5 goes in several squares -- so the chosen digit stays chosen and
  /// only the square clears. Picking it again for every square would be the
  /// same technique made tedious.
  int? _selectedValue;
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

  /// Measured by the drop area to work out which square a drop lands in.
  final GlobalKey _gridKey = GlobalKey();

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

  /// A digit on the pad was touched.
  void _tapPad(int value) {
    HapticFeedbackUtil.selectionClick();
    final waiting = _selected;
    setState(() {
      _selectedValue = _selectedValue == value ? null : value;
      if (_selectedValue != null) _selected = null;
    });
    // The other order round: a square was already waiting, so fill it.
    if (waiting != null && _selectedValue != null) _place(waiting, value);
  }

  /// A square was touched.
  void _tapCell(int r, int c) {
    if (_puzzle.isGiven(r, c)) return;
    final value = _selectedValue;
    if (value != null) {
      _place(Point(r, c), value);
      return;
    }
    HapticFeedbackUtil.selectionClick();
    setState(() => _selected = Point(r, c));
  }

  /// Put [value] in [at], however it got there -- tapped, or dropped.
  void _place(Point<int> at, int value) {
    if (_puzzle.isGiven(at.x, at.y)) return;
    setState(() {
      _entries[at.x][at.y] = value;
      // The digit stays chosen for the next square; the square does not.
      _selected = null;
    });
    if (value != 0 && value != _puzzle.solution[at.x][at.y]) {
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

  /// [hoverR],[hoverC] is the square a drop would currently land in, which
  /// the drop area works out for the whole grid at once. Each cell used to
  /// be its own DragTarget, which meant the gaps between them were dead
  /// ground and a drop there was silently thrown away.
  Widget _buildCell(int r, int c, double size, ColorScheme scheme, int? hoverR,
      int? hoverC) {
    return _cellBody(r, c, size, scheme, hoverR == r && hoverC == c);
  }

  /// [hovered] is true while a dragged digit is over this square, which
  /// lights it the same amber a chosen square gets -- so the drop lands
  /// where the colour says it will.
  Widget _cellBody(
      int r, int c, double size, ColorScheme scheme, bool hovered) {
    final given = _puzzle.isGiven(r, c);
    final value = _entries[r][c];
    final selected = _selected == Point(r, c) || hovered;
    final wrong = !given && value != 0 && value != _puzzle.solution[r][c];

    // Shade alternate 3x3 boxes so the box boundaries are obvious without
    // relying on line weight alone.
    final box = (r ~/ 3 + c ~/ 3) % 2 == 0;

    return GestureDetector(
      onTap: given ? null : () => _tapCell(r, c),
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

  /// One key of the number pad: 1 to 9, or 0 for the eraser.
  ///
  /// Tappable and draggable, the two ways Cross Math offers. The drag is
  /// what NJ asked for there and it carries over unchanged -- a digit picked
  /// up and carried to a square is a gesture that says what it does, which
  /// is worth more than a tap for someone who has to work out what a screen
  /// means each time.
  Widget _padKey(int value, ColorScheme scheme) {
    final chosen = _selectedValue == value;
    final label = value == 0
        ? Icon(Icons.backspace_outlined,
            size: 26, color: chosen ? Colors.white : scheme.onSurface)
        : Text(
            '$value',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w900,
              color: chosen ? Colors.white : scheme.onSurface,
            ),
          );

    final key = TangibleButton(
      color: chosen ? DesignSystem.primary : scheme.surface,
      radius: DesignSystem.radiusSM,
      padding: EdgeInsets.zero,
      borderWidth: 2.0,
      borderColor: chosen ? null : scheme.onSurface.withValues(alpha: 0.35),
      onTap: () => _tapPad(value),
      child: SizedBox(
        width: SeniorMode.minTapTarget,
        height: SeniorMode.minTapTarget,
        child: Center(child: label),
      ),
    );

    return Draggable<int>(
      data: value,
      dragAnchorStrategy: pointerDragAnchorStrategy,
      // Lifted up and to the left of the fingertip, so the digit being
      // carried is not under the hand carrying it.
      feedback: Transform.translate(
        offset: const Offset(-34, -54),
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 68,
            height: 68,
            decoration: BoxDecoration(
              color: DesignSystem.primary,
              borderRadius: BorderRadius.circular(DesignSystem.radiusSM),
              border: Border.all(color: Colors.white, width: 2.0),
            ),
            child: Center(
              child: value == 0
                  ? const Icon(Icons.backspace_outlined,
                      size: 30, color: Colors.white)
                  : Text(
                      '$value',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        ),
      ),
      childWhenDragging: Opacity(opacity: 0.35, child: key),
      // Picking a digit up chooses it too, so letting go over nothing still
      // leaves it ready to tap a square with.
      onDragStarted: () {
        HapticFeedbackUtil.selectionClick();
        setState(() {
          _selectedValue = value;
          _selected = null;
        });
      },
      child: key,
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

            // The drop area wraps the whole body, not just the board, so a
            // tile let go a little off the edge still finds its square.
            return GridDropArea(
              rows: 9,
              columns: 9,
              gridKey: _gridKey,
              canAccept: (r, c) => !_puzzle.isGiven(r, c),
              onPlace: (r, c, value) => _place(Point(r, c), value),
              builder: (context, hoverR, hoverC) => Column(
              children: [
                const SizedBox(height: DesignSystem.spaceSM),
                Expanded(
                  child: Center(
                    child: SizedBox(
                      key: _gridKey,
                      width: cell * 9,
                      height: cell * 9,
                      child: Column(
                        children: List.generate(
                          9,
                          (r) => Row(
                            children: List.generate(
                              9,
                              (c) =>
                                  _buildCell(r, c, cell, scheme, hoverR, hoverC),
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
                      for (var v = 1; v <= 9; v++) _padKey(v, scheme),
                      _padKey(0, scheme),
                    ],
                  ),
                ),
                const SizedBox(height: DesignSystem.spaceMD),
              ],
              ),
            );
          },
        ),
      ),
    );
  }
}
