import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puzzle/config/senior_mode.dart';
import 'package:puzzle/l10n/app_localizations.dart';

import '../../../../providers/user_providers.dart';
import '../../../../utils/design_system.dart';
import '../../../../utils/haptic_feedback.dart';
import '../../../../widgets/game_completion_dialog.dart';
import '../../../../widgets/tangible.dart';
import '../../../core/juice/game_scaffold.dart';
import 'cross_math_engine.dart';

class CrossMathScreen extends ConsumerStatefulWidget {
  const CrossMathScreen({super.key});

  @override
  ConsumerState<CrossMathScreen> createState() => _CrossMathScreenState();
}

class _CrossMathScreenState extends ConsumerState<CrossMathScreen> {
  final CrossMathEngine _engine = CrossMathEngine();

  late CrossMathPuzzle _puzzle;

  /// Values the player has placed, by cell.
  final Map<Point<int>, int> _placed = {};

  /// Which pool tile (by index) sits in which cell, so taking a number back
  /// returns the right tile even when the pool holds duplicates.
  final Map<int, Point<int>> _tileAt = {};

  int? _selectedTile;
  Point<int>? _selectedCell;
  int _solved = 0;

  @override
  void initState() {
    super.initState();
    _newPuzzle();
  }

  void _newPuzzle() {
    setState(() {
      // Twelve tiles rather than ten. The generator now also insists every
      // board can be finished by reasoning alone, so more blanks does not
      // mean more guessing -- it means more to work out.
      _puzzle = _engine.generate(blankCount: 12);
      _placed.clear();
      _tileAt.clear();
      _selectedTile = null;
      _selectedCell = null;
    });
  }

  // --- state helpers -------------------------------------------------------

  bool _isBlank(Point<int> p) => _puzzle.grid[p.x][p.y].isBlank;

  int? _valueAt(Point<int> p) {
    final cell = _puzzle.grid[p.x][p.y];
    if (cell.kind != CellKind.number) return null;
    return cell.isBlank ? _placed[p] : cell.value;
  }

  /// null while the equation is incomplete, otherwise whether it holds.
  ///
  /// Works for all three shapes rather than assuming `a op b = r`: the
  /// numbers are read in reading order and judged by the equation's form,
  /// which is the only thing that knows how many there are.
  bool? _equationState(Equation e) {
    final values = [for (final c in e.numberCells) _valueAt(c)];
    if (values.any((v) => v == null)) return null;
    switch (e.form) {
      case EquationForm.binary:
        return applyOp(values[0]!, e.ops[0], values[1]!) == values[2];
      case EquationForm.factorial:
        return _factorialOf(values[0]!) == values[1];
      case EquationForm.twoSided:
        final left = applyOp(values[0]!, e.ops[0], values[1]!);
        final right = applyOp(values[2]!, e.ops[1], values[3]!);
        return left != null && right != null && left == right;
    }
  }

  static int? _factorialOf(int n) {
    if (n < 2 || n > 6) return null;
    var r = 1;
    for (var i = 2; i <= n; i++) {
      r *= i;
    }
    return r;
  }

  bool get _isSolved =>
      _puzzle.blanks.every((p) => _placed.containsKey(p)) &&
      _puzzle.equations.every((e) => _equationState(e) == true);

  // --- interaction ---------------------------------------------------------

  void _tapTile(int index) {
    if (_tileAt.containsKey(index)) return; // already on the board
    setState(() {
      _selectedTile = _selectedTile == index ? null : index;
    });
    if (_selectedTile != null && _selectedCell != null) _place();
  }

  void _tapCell(Point<int> p) {
    if (!_isBlank(p)) return;
    // Taking a placed number back.
    int? existing;
    for (final entry in _tileAt.entries) {
      if (entry.value == p) {
        existing = entry.key;
        break;
      }
    }
    if (existing != null) {
      HapticFeedbackUtil.selectionClick();
      setState(() {
        _tileAt.remove(existing);
        _placed.remove(p);
        _selectedCell = null;
        _selectedTile = null;
      });
      return;
    }
    setState(() => _selectedCell = p);
    if (_selectedTile != null) _place();
  }

  void _place() {
    final tile = _selectedTile, cell = _selectedCell;
    if (tile == null || cell == null) return;
    _placeTile(tile, cell);
  }

  /// Puts pool tile [tile] into [cell]. Both ways of playing end up here:
  /// tapping a number and then a box, and dragging the number onto the box.
  ///
  /// Dropping onto a box that already holds a number swaps the old one back
  /// to the tray rather than refusing, so a tile can be corrected by dragging
  /// another one on top of it.
  void _placeTile(int tile, Point<int> cell) {
    if (!_isBlank(cell)) return;
    if (_tileAt.containsKey(tile)) return; // already on the board
    int? occupant;
    for (final entry in _tileAt.entries) {
      if (entry.value == cell) {
        occupant = entry.key;
        break;
      }
    }
    HapticFeedbackUtil.lightImpact();
    setState(() {
      if (occupant != null) _tileAt.remove(occupant);
      _placed[cell] = _puzzle.pool[tile];
      _tileAt[tile] = cell;
      _selectedTile = null;
      _selectedCell = null;
    });
    if (_isSolved) _onSolved();
  }

  void _clear() {
    setState(() {
      _placed.clear();
      _tileAt.clear();
      _selectedTile = null;
      _selectedCell = null;
    });
  }

  void _onSolved() {
    HapticFeedbackUtil.victory();
    _solved++;
    final target =
        SeniorMode.overrideRoundLimits ? SeniorMode.roundTarget : 10;
    if (_solved < target) {
      Future.delayed(const Duration(milliseconds: 900), () {
        if (mounted) _newPuzzle();
      });
      return;
    }
    ref.read(gameStreakNotifierProvider.notifier).completeGame('cross_math');
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => GameCompletionDialog(
        title: 'CROSS MATH',
        message: l10n.completed,
        onHome: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
        onPlayAgain: () {
          Navigator.of(context).pop();
          setState(() => _solved = 0);
          _newPuzzle();
        },
      ),
    );
  }

  // --- rendering -----------------------------------------------------------

  static const Map<String, String> _symbols = {
    '+': '+',
    '-': '–',
    'x': '×',
    '/': '÷',
    // 'mod' spelled out would not fit a cell, and the sign is the one he
    // taught; '!' is its own symbol.
    '%': 'mod',
    '!': '!',
  };

  /// Tints a filled-in blank by whether every equation through it works out.
  Color? _feedbackColor(Point<int> p, ColorScheme scheme) {
    final through = _puzzle.equations.where((e) => e.cells.contains(p));
    final states = through.map(_equationState).toList();
    if (states.any((s) => s == false)) return DesignSystem.error;
    if (states.isNotEmpty && states.every((s) => s == true)) {
      return DesignSystem.success;
    }
    return null;
  }

  Widget _buildCell(Point<int> p, double size, ColorScheme scheme) {
    final cell = _puzzle.grid[p.x][p.y];
    if (cell.kind == CellKind.empty) return SizedBox(width: size, height: size);

    if (cell.kind == CellKind.operator || cell.kind == CellKind.equals) {
      return SizedBox(
        width: size,
        height: size,
        child: Center(
          // 'mod' is three characters in a cell built for one, so the sign
          // shrinks to fit rather than spilling over its neighbours.
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1),
              child: Text(
                cell.kind == CellKind.equals
                    ? '='
                    : (_symbols[cell.op] ?? cell.op),
                style: TextStyle(
                  fontSize: size * (cell.op == '%' ? 0.34 : 0.46),
                  fontWeight: FontWeight.w700,
                  color: scheme.onSurface.withValues(alpha: 0.8),
                ),
              ),
            ),
          ),
        ),
      );
    }

    final isBlank = cell.isBlank;
    final value = _valueAt(p);
    final selected = _selectedCell == p;
    final feedback = isBlank && value != null ? _feedbackColor(p, scheme) : null;

    final body = Padding(
      padding: const EdgeInsets.all(2),
      child: GestureDetector(
        onTap: isBlank ? () => _tapCell(p) : null,
        child: Container(
          width: size - 4,
          height: size - 4,
          decoration: BoxDecoration(
            color: selected
                ? DesignSystem.accentAmber.withValues(alpha: 0.35)
                : (isBlank && value == null
                    ? scheme.onSurface.withValues(alpha: 0.06)
                    : scheme.surface),
            borderRadius: BorderRadius.circular(DesignSystem.radiusXS),
            border: Border.all(
              color: feedback ??
                  (selected
                      ? DesignSystem.accentAmber
                      : scheme.onSurface.withValues(alpha: 0.45)),
              width: feedback != null || selected ? 3.0 : 2.0,
            ),
          ),
          child: Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                value?.toString() ?? '',
                style: TextStyle(
                  fontSize: size * (((value ?? 0) >= 100) ? 0.34 : 0.44),
                  fontWeight: FontWeight.w900,
                  color: feedback ?? scheme.onSurface,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    if (!isBlank) return body;

    // Carrying the number to the box is the point of the drag: it is one
    // continuous action rather than two taps that have to be held together
    // in mind. Tapping still works, for when dragging is the harder motion.
    return DragTarget<int>(
      onWillAcceptWithDetails: (_) => true,
      onAcceptWithDetails: (details) => _placeTile(details.data, p),
      builder: (context, candidate, rejected) {
        if (candidate.isEmpty) return body;
        // Something is hovering: show where it would land.
        return Transform.scale(scale: 1.08, child: body);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return GameScaffold(
      title: 'CROSS MATH',
      subtitle: 'Fill the gaps so every equation is true',
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
            // Six tray tiles to a row, and smaller ones: twelve numbers then
            // take two rows of modest height instead of three tall ones. The
            // tray is the smaller half of this screen now, which is the way
            // round it should have been -- the puzzle is the thing being
            // looked at.
            // The 4 is slack: six tiles plus five gaps worked out to exactly
            // the width available, and a rounding error either way would wrap
            // the row and make the tray three rows deep instead of two.
            final padTile = ((constraints.maxWidth -
                        DesignSystem.spaceMD * 2 -
                        DesignSystem.spaceXS * 5 -
                        4) /
                    6)
                .clamp(40.0, 54.0);

            return Column(
              children: [
                const SizedBox(height: DesignSystem.spaceMD),
                // The board is measured against the room it actually has,
                // not against a fraction of the whole screen.
                //
                // It used to take 0.52 of the total height whatever was
                // below it, so once the hint, the number pad and the Clear
                // button had taken their share there was less left than the
                // board had claimed, and the bottom rows were cut off. Asking
                // its own box how tall it is means the grid always fits.
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, board) {
                      final cellSize = min(
                        (board.maxWidth - 24) / _puzzle.cols,
                        (board.maxHeight - 24) / _puzzle.rows,
                      ).clamp(18.0, 96.0);
                      return Center(
                        // The puzzle on its own lit panel, so the board reads
                        // as the thing being worked on and the tray below as
                        // the things to work with.
                        child: Container(
                          padding: const EdgeInsets.all(DesignSystem.spaceXS),
                          decoration: BoxDecoration(
                            color: scheme.onSurface.withValues(alpha: 0.04),
                            borderRadius:
                                BorderRadius.circular(DesignSystem.radiusMD),
                            border: Border.all(
                              color: scheme.onSurface.withValues(alpha: 0.18),
                              width: 2,
                            ),
                          ),
                          child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(
                            _puzzle.rows,
                            (r) => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                _puzzle.cols,
                                (c) => _buildCell(Point(r, c), cellSize, scheme),
                              ),
                            ),
                          ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: DesignSystem.spaceMD,
                    vertical: DesignSystem.spaceSM,
                  ),
                  child: Text(
                    'Drag a number onto a grey box, or tap one then the other',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: DesignSystem.fontSizeSM,
                      color: scheme.onSurface.withValues(alpha: 0.7),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: DesignSystem.spaceXS,
                  runSpacing: DesignSystem.spaceXS,
                  children: List.generate(_puzzle.pool.length, (i) {
                    final used = _tileAt.containsKey(i);
                    final selected = _selectedTile == i;
                    final tile = Opacity(
                      opacity: used ? 0.25 : 1.0,
                      child: TangibleButton(
                        color: selected
                            ? DesignSystem.accentAmber
                            : scheme.surface,
                        radius: DesignSystem.radiusSM,
                        padding: EdgeInsets.zero,
                        onTap: used ? null : () => _tapTile(i),
                        child: SizedBox(
                          width: padTile,
                          height: padTile,
                          child: Center(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                '${_puzzle.pool[i]}',
                                style: TextStyle(
                                  fontSize: padTile * 0.42,
                                  fontWeight: FontWeight.w900,
                                  color: scheme.onSurface,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                    if (used) return tile;
                    return Draggable<int>(
                      data: i,
                      dragAnchorStrategy: pointerDragAnchorStrategy,
                      // Carried a little larger than it sits in the tray, and
                      // offset above the finger, so the number stays visible
                      // instead of hiding under his hand on the way across.
                      feedback: Transform.translate(
                        offset: Offset(-padTile * 0.6, -padTile * 1.1),
                        child: Material(
                          color: Colors.transparent,
                          child: Container(
                            width: padTile * 1.2,
                            height: padTile * 1.2,
                            decoration: BoxDecoration(
                              color: DesignSystem.accentAmber,
                              borderRadius: BorderRadius.circular(
                                  DesignSystem.radiusSM),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x33000000),
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Center(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  '${_puzzle.pool[i]}',
                                  style: TextStyle(
                                    fontSize: padTile * 0.5,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      childWhenDragging: Opacity(opacity: 0.3, child: tile),
                      onDragStarted: () {
                        HapticFeedbackUtil.selectionClick();
                        setState(() => _selectedTile = i);
                      },
                      child: tile,
                    );
                  }),
                ),
                const SizedBox(height: DesignSystem.spaceSM),
                // Clear is a way out, not a thing to aim for, so it no longer
                // runs the width of the screen: it sits in the middle at the
                // size of a button rather than a banner.
                Center(
                  child: TangibleButton(
                    color: scheme.surface,
                    radius: DesignSystem.radiusSM,
                    padding: const EdgeInsets.symmetric(
                      horizontal: DesignSystem.spaceLG,
                      vertical: DesignSystem.spaceXS,
                    ),
                    onTap: _clear,
                    child: const Text(
                      'CLEAR',
                      style: TextStyle(
                        fontSize: DesignSystem.fontSizeSM,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: DesignSystem.spaceLG),
              ],
            );
          },
        ),
      ),
    );
  }
}
