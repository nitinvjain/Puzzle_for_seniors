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
      // Ten tiles to place on a nine-by-nine board, rather than four on a
      // five-by-five one.
      _puzzle = _engine.generate(blankCount: 10);
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

  int? _evaluate(Equation e) {
    final a = _valueAt(e.a), b = _valueAt(e.b);
    if (a == null || b == null) return null;
    final op = _puzzle.grid[e.opCell.x][e.opCell.y].op;
    switch (op) {
      case '+':
        return a + b;
      case '-':
        return a - b;
      case 'x':
        return a * b;
      case '/':
        if (b == 0 || a % b != 0) return null;
        return a ~/ b;
    }
    return null;
  }

  /// null while the equation is incomplete, otherwise whether it holds.
  bool? _equationState(Equation e) {
    final r = _valueAt(e.result);
    if (r == null) return null;
    final got = _evaluate(e);
    if (got == null) return null;
    return got == r;
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
    HapticFeedbackUtil.lightImpact();
    setState(() {
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
          child: Text(
            cell.kind == CellKind.equals
                ? '='
                : (_symbols[cell.op] ?? cell.op),
            style: TextStyle(
              fontSize: size * 0.46,
              fontWeight: FontWeight.w700,
              color: scheme.onSurface.withValues(alpha: 0.75),
            ),
          ),
        ),
      );
    }

    final isBlank = cell.isBlank;
    final value = _valueAt(p);
    final selected = _selectedCell == p;
    final feedback = isBlank && value != null ? _feedbackColor(p, scheme) : null;

    return Padding(
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
            final cellSize = min(
              (constraints.maxWidth - 32) / _puzzle.cols,
              (constraints.maxHeight * 0.52) / _puzzle.rows,
            ).clamp(44.0, 96.0);

            return Column(
              children: [
                const SizedBox(height: DesignSystem.spaceMD),
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
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
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: DesignSystem.spaceMD,
                    vertical: DesignSystem.spaceSM,
                  ),
                  child: Text(
                    'Tap a number below, then tap a grey box',
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
                  spacing: DesignSystem.spaceSM,
                  runSpacing: DesignSystem.spaceSM,
                  children: List.generate(_puzzle.pool.length, (i) {
                    final used = _tileAt.containsKey(i);
                    final selected = _selectedTile == i;
                    return Opacity(
                      opacity: used ? 0.25 : 1.0,
                      child: TangibleButton(
                        color: selected
                            ? DesignSystem.accentAmber
                            : scheme.surface,
                        radius: DesignSystem.radiusSM,
                        padding: EdgeInsets.zero,
                        onTap: used ? null : () => _tapTile(i),
                        child: SizedBox(
                          width: SeniorMode.minTapTarget,
                          height: SeniorMode.minTapTarget,
                          child: Center(
                            child: Text(
                              '${_puzzle.pool[i]}',
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w900,
                                color: scheme.onSurface,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: DesignSystem.spaceMD),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: DesignSystem.spaceLG),
                  child: TangibleButton(
                    color: scheme.surface,
                    width: double.infinity,
                    onTap: _clear,
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          'CLEAR',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.0,
                          ),
                        ),
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
