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

  /// Joins per stage. He plays all ten board games, so this one has to pay
  /// its way like the others rather than holding everything back until the
  /// round target lands -- at a target of fifty, a round is a long walk for a
  /// single reward at the end.
  ///
  /// Ten is a tenth of a 2048-style board's working life and a visible
  /// landmark in the counter at the bottom of the screen, so the points
  /// arrive at a moment that already looks like getting somewhere.
  static const int _joinsPerStage = 10;

  /// Stages already paid for, so a stage cannot be earned twice. Reset only
  /// where [_merges] is -- the New board button deliberately keeps the count,
  /// since he is still working towards the same target.
  int _stagesPaid = 0;
  double _cellSize = 56;

  /// Which cell the last merge produced, and which cells were refilled behind
  /// it. [_mergeSeq] changes on every merge and is used as the animation key,
  /// so each merge replays the animation instead of the first one sticking.
  Point<int>? _mergedAt;
  Set<Point<int>> _freshCells = {};
  int _mergeSeq = 0;

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

    // Walk towards the finger one tile at a time rather than only trying the
    // tile it is on now. A quick or unsteady drag moves more than one tile
    // between updates, and the tile it lands on is then not touching the end
    // of the chain -- so the chain used to stop dead where the jump happened
    // and he would have to start the drag again. Stepping through the tiles
    // in between keeps the chain under the finger.
    final path = [..._path];
    while (path.last != cell) {
      final from = path.last;
      final step = Point(
        from.x + (cell.x - from.x).sign,
        from.y + (cell.y - from.y).sign,
      );
      if (!_engine.canExtend(_board, path, step)) break;
      path.add(step);
    }

    if (path.length != _path.length) {
      HapticFeedbackUtil.lightImpact();
      setState(() => _path = path);
    }
  }

  /// A cancelled gesture discards the chain instead of playing it. Cancels
  /// come from outside the game -- another gesture winning, a notification --
  /// so treating one as a release would make a move he did not finish.
  void _onPanCancel() {
    if (_path.isEmpty) return;
    setState(() => _path = []);
  }

  void _onPanEnd() {
    if (_path.length < 2) {
      setState(() => _path = []);
      return;
    }
    final outcome = _engine.applyChain(_board, _path);
    final produced = outcome.value;
    setState(() {
      _path = [];
      if (produced > 0) {
        _merges++;
        _mergeSeq++;
        _mergedAt = outcome.landing;
        _freshCells = outcome.spawned.toSet();
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
      if (_merges >= target) {
        _onComplete();
      } else {
        final due = _merges ~/ _joinsPerStage;
        if (due > _stagesPaid) {
          _stagesPaid = due;
          ref
              .read(gameStreakNotifierProvider.notifier)
              .awardStage('number_connect', xpAmount: Rewards.pointsPerStage);
        }
      }
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
            _stagesPaid = 0;
            _board = _engine.newBoard();
            _path = [];
            _mergedAt = null;
            _freshCells = {};
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
    final base = _palette[exponent % _palette.length];

    // There are seven colours and play reaches 1024, so the hues come round
    // again: without this a 256 would be exactly the colour of a 2, and the
    // colour is the first thing he matches on -- he would keep trying to join
    // two tiles that only look alike. Each time round the palette the colour
    // is deepened, so the repeat is still obvious at a glance.
    final laps = exponent ~/ _palette.length;
    if (laps == 0) return base;
    return Color.lerp(base, Colors.black, min(0.45, 0.2 * laps))!;
  }

  /// The largest number currently on the board.
  int get _biggestTile {
    var biggest = 0;
    for (final row in _board.cells) {
      for (final value in row) {
        if (value > biggest) biggest = value;
      }
    }
    return biggest;
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
            _mergedAt = null;
            _freshCells = {};
          }),
        ),
      ],
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            _cellSize = min(
              (constraints.maxWidth - 24) / _board.cols,
              (constraints.maxHeight - 140) / _board.rows,
            ).clamp(28.0, 96.0);
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
                      onPanCancel: _onPanCancel,
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
                      'Joins made: $_merges     Biggest tile: $_biggestTile',
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
    final cell = Point(r, c);
    final inPath = _path.contains(cell);
    final color = _colorFor(value);

    return Positioned(
      left: c * _cellSize,
      top: r * _cellSize,
      width: _cellSize,
      height: _cellSize,
      child: _animateArrival(
        cell,
        Padding(
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
      ),
    );
  }

  /// Animates a tile that has just appeared.
  ///
  /// Two different arrivals, because they mean different things and should not
  /// look the same: the merged tile is the result of what he just did, so it
  /// swells into place and is the thing the eye is drawn to; the tiles
  /// refilling the board behind it are not his doing, so they only fade down
  /// from above, quietly.
  ///
  /// Keyed on [_mergeSeq] so every merge replays rather than only the first
  /// one animating.
  Widget _animateArrival(Point<int> cell, Widget tile) {
    if (cell == _mergedAt) {
      return TweenAnimationBuilder<double>(
        key: ValueKey('merged-$_mergeSeq'),
        tween: Tween(begin: 0.4, end: 1.0),
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOutBack,
        builder: (_, t, child) => Transform.scale(scale: t, child: child),
        child: tile,
      );
    }

    if (_freshCells.contains(cell)) {
      return TweenAnimationBuilder<double>(
        key: ValueKey('fresh-$_mergeSeq'),
        tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOut,
        builder: (_, t, child) => Opacity(
          opacity: t,
          child: Transform.translate(
            offset: Offset(0, -_cellSize * 0.35 * (1 - t)),
            child: child,
          ),
        ),
        child: tile,
      );
    }

    return tile;
  }
}
