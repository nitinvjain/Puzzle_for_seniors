import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puzzle/config/senior_mode.dart';
import 'package:puzzle/l10n/app_localizations.dart';

import '../../../../providers/user_providers.dart';
import '../../../../utils/design_system.dart';
import '../../../../utils/haptic_feedback.dart';
import '../../../../widgets/game_completion_dialog.dart';
import '../../../core/juice/game_scaffold.dart';
import 'number_connect_engine.dart';

class NumberConnectScreen extends ConsumerStatefulWidget {
  const NumberConnectScreen({super.key});

  @override
  ConsumerState<NumberConnectScreen> createState() =>
      _NumberConnectScreenState();
}

class _NumberConnectScreenState extends ConsumerState<NumberConnectScreen> {
  final NumberConnectEngine _engine = NumberConnectEngine();
  late NumberConnectBoard _board;

  /// The chain currently being dragged, in the order it was drawn.
  List<Point<int>> _path = [];

  int _merges = 0;
  int _best = 2;
  double _cellSize = 56;

  @override
  void initState() {
    super.initState();
    _board = _engine.newBoard();
  }

  // --- drag handling -------------------------------------------------------

  Point<int>? _cellAt(Offset local) {
    final c = (local.dx / _cellSize).floor();
    final r = (local.dy / _cellSize).floor();
    if (r < 0 || r >= _board.rows || c < 0 || c >= _board.cols) return null;
    return Point(r, c);
  }

  void _onPanStart(Offset local) {
    final cell = _cellAt(local);
    if (cell == null) return;
    HapticFeedbackUtil.selectionClick();
    setState(() => _path = [cell]);
  }

  void _onPanUpdate(Offset local) {
    final cell = _cellAt(local);
    if (cell == null || _path.isEmpty) return;
    if (cell == _path.last) return;

    // Dragging back onto the previous tile undoes the last step, so a
    // wandering finger can correct itself without starting over.
    if (_path.length >= 2 && cell == _path[_path.length - 2]) {
      HapticFeedbackUtil.selectionClick();
      setState(() => _path.removeLast());
      return;
    }
    if (_engine.canExtend(_board, _path, cell)) {
      HapticFeedbackUtil.lightImpact();
      setState(() => _path.add(cell));
    }
  }

  void _onPanEnd() {
    if (_path.length < 2) {
      setState(() => _path = []);
      return;
    }
    final produced = _engine.applyChain(_board, _path);
    setState(() {
      _path = [];
      if (produced > 0) {
        _merges++;
        if (produced > _best) _best = produced;
      }
    });
    if (produced > 0) {
      HapticFeedbackUtil.success();
      if (!_engine.hasMove(_board)) {
        // Effectively unreachable, but better than leaving him stuck.
        setState(() => _engine.reshuffle(_board));
      }
      final target =
          SeniorMode.overrideRoundLimits ? SeniorMode.roundTarget : 30;
      if (_merges >= target) _onComplete();
    }
  }

  void _onComplete() {
    HapticFeedbackUtil.victory();
    ref.read(gameStreakNotifierProvider.notifier).completeGame('number_connect');
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => GameCompletionDialog(
        title: 'NUMBER CONNECT',
        message: l10n.completed,
        onHome: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
        onPlayAgain: () {
          Navigator.of(context).pop();
          setState(() {
            _merges = 0;
            _best = 2;
            _board = _engine.newBoard();
          });
        },
      ),
    );
  }

  // --- rendering -----------------------------------------------------------

  /// Each power of two gets its own colour, so matching tiles can be spotted
  /// by colour before the number is even read.
  static const List<Color> _palette = [
    DesignSystem.gameBlue,
    DesignSystem.gameGreen,
    DesignSystem.gameAmber,
    DesignSystem.gameRose,
    DesignSystem.gamePurple,
    DesignSystem.gameOrange,
    DesignSystem.gameTeal,
  ];

  Color _colorFor(int value) {
    var exponent = 0;
    var v = value;
    while (v > 2) {
      v ~/= 2;
      exponent++;
    }
    return _palette[exponent % _palette.length];
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final chainValue = _engine.mergedValue(_board, _path);

    return GameScaffold(
      title: 'NUMBER CONNECT',
      subtitle: 'Join touching tiles that show the same number',
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh_rounded),
          tooltip: 'New board',
          onPressed: () => setState(() {
            _board = _engine.newBoard();
            _path = [];
          }),
        ),
      ],
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            _cellSize = min(
              (constraints.maxWidth - 24) / _board.cols,
              (constraints.maxHeight - 140) / _board.rows,
            ).clamp(40.0, 96.0);
            final boardWidth = _cellSize * _board.cols;
            final boardHeight = _cellSize * _board.rows;

            return Column(
              children: [
                // What the current chain would make, so the rounding-up rule
                // is visible as it happens rather than only in the help text.
                SizedBox(
                  height: 48,
                  child: Center(
                    child: Text(
                      _path.length >= 2
                          ? 'This chain makes $chainValue'
                          : 'Drag through tiles with the same number',
                      style: TextStyle(
                        fontSize: DesignSystem.fontSizeMD,
                        fontWeight: FontWeight.w700,
                        color: _path.length >= 2
                            ? _colorFor(chainValue)
                            : scheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: GestureDetector(
                      onPanStart: (d) => _onPanStart(d.localPosition),
                      onPanUpdate: (d) => _onPanUpdate(d.localPosition),
                      onPanEnd: (_) => _onPanEnd(),
                      onPanCancel: _onPanEnd,
                      child: SizedBox(
                        width: boardWidth,
                        height: boardHeight,
                        child: Stack(
                          children: [
                            for (var r = 0; r < _board.rows; r++)
                              for (var c = 0; c < _board.cols; c++)
                                _buildTile(r, c),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                if (!SeniorMode.disableScoring)
                  Padding(
                    padding: const EdgeInsets.only(
                        top: DesignSystem.spaceSM,
                        bottom: DesignSystem.spaceXS),
                    child: Text(
                      'Joins made: $_merges     Biggest tile: $_best',
                      style: TextStyle(
                        fontSize: DesignSystem.fontSizeSM,
                        fontWeight: FontWeight.w700,
                        color: scheme.onSurface.withValues(alpha: 0.75),
                      ),
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

  Widget _buildTile(int r, int c) {
    final value = _board.cells[r][c];
    final inPath = _path.contains(Point(r, c));
    final color = _colorFor(value);

    return Positioned(
      left: c * _cellSize,
      top: r * _cellSize,
      width: _cellSize,
      height: _cellSize,
      child: Padding(
        padding: EdgeInsets.all(_cellSize * 0.06),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          decoration: BoxDecoration(
            color: color.withValues(alpha: inPath ? 1.0 : 0.85),
            borderRadius: BorderRadius.circular(_cellSize * 0.22),
            border: inPath
                ? Border.all(color: Colors.white, width: 4)
                : Border.all(color: Colors.black.withValues(alpha: 0.12)),
            boxShadow: inPath
                ? [
                    BoxShadow(
                      color: color.withValues(alpha: 0.6),
                      blurRadius: 10,
                      spreadRadius: 1,
                    )
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              '$value',
              style: TextStyle(
                // Long numbers shrink so 1024 still fits inside its tile.
                fontSize: _cellSize * (value >= 1000 ? 0.26 : 0.36),
                fontWeight: FontWeight.w900,
                color: Colors.white,
                shadows: const [
                  Shadow(color: Color(0x55000000), blurRadius: 2),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
