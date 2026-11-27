import 'dart:math';

import 'package:flutter/material.dart';

/// Where the dragged tile is painted, relative to the fingertip.
///
/// Every game that carries a value uses [pointerDragAnchorStrategy], which
/// puts the feedback widget's top-left on the fingertip, and then shifts it
/// up and to the left so the hand is not covering it. A 64px tile shifted by
/// (-32, -52) has its centre 20 pixels above the finger; the 68px one in
/// Simple Sudoku, shifted by (-34, -54), works out the same.
const Offset kCarriedTileCentre = Offset(0, -20);

/// Lands a dragged value in the nearest cell of a rows x columns grid,
/// instead of only where the finger happens to be.
///
/// This exists because NJ's father kept missing. Two things were against
/// him, and neither was his aim.
///
/// The drop point was the fingertip, but what he was aiming was the tile --
/// and the tile is painted 20 pixels above his finger so that his hand does
/// not hide it. Line the tile up with a square on a 9x9 grid and the finger
/// is more than half a cell low, so the number went in underneath. That is
/// why the 3x3 magic square misfired least: 20 pixels is a smaller part of a
/// big cell.
///
/// And a DragTarget per cell leaves dead ground. The cells have gaps between
/// them, so a drop that landed in a gap was simply discarded, with no
/// feedback to say why.
///
/// So the whole grid is one target. The aim point is the tile's centre, not
/// the finger; whichever cell's share of the grid contains that point wins,
/// so there is no gap to fall down; and a drop up to [overshoot] outside the
/// grid still lands in the nearest edge cell, which covers the last row and
/// column where the hand runs off the board.
///
/// [child] may be much larger than the grid -- the whole screen body is
/// fine, and is what the games pass, so that a drop anywhere near the board
/// is caught. The geometry is measured from [gridKey], which must be on the
/// grid itself, so what the child's own size is does not matter.
class GridDropArea extends StatefulWidget {
  final int rows;
  final int columns;

  /// Must be attached to the grid widget, not to [child].
  final GlobalKey gridKey;

  /// How far outside the grid a drop is still taken as meant for it.
  final double overshoot;

  /// False for a cell that cannot take a value -- a given number, say. A
  /// drop that snaps to one of those is ignored rather than redirected,
  /// since moving it somewhere he did not point would be worse than nothing.
  final bool Function(int row, int column) canAccept;

  final void Function(int row, int column, int value) onPlace;

  /// Gets the cell the drop would currently land in, so it can be lit up.
  /// Both are null when no drag is in range.
  final Widget Function(BuildContext context, int? row, int? column) builder;

  const GridDropArea({
    super.key,
    required this.rows,
    required this.columns,
    required this.gridKey,
    required this.canAccept,
    required this.onPlace,
    required this.builder,
    this.overshoot = 44.0,
  });

  @override
  State<GridDropArea> createState() => _GridDropAreaState();
}

class _GridDropAreaState extends State<GridDropArea> {
  Point<int>? _hover;

  /// Which cell a drop at this fingertip position would land in.
  ///
  /// Returns null when the tile is nowhere near the grid, so that letting go
  /// over the number pad puts the value down rather than placing it.
  Point<int>? _cellAt(Offset fingertip) {
    final box = widget.gridKey.currentContext?.findRenderObject();
    if (box is! RenderBox || !box.hasSize) return null;
    final size = box.size;
    if (size.width <= 0 || size.height <= 0) return null;

    final aim = box.globalToLocal(fingertip + kCarriedTileCentre);
    final slack = widget.overshoot;
    if (aim.dx < -slack || aim.dx > size.width + slack) return null;
    if (aim.dy < -slack || aim.dy > size.height + slack) return null;

    final column = (aim.dx / (size.width / widget.columns))
        .floor()
        .clamp(0, widget.columns - 1);
    final row =
        (aim.dy / (size.height / widget.rows)).floor().clamp(0, widget.rows - 1);
    return Point<int>(row, column);
  }

  void _setHover(Point<int>? cell) {
    if (_hover == cell) return;
    setState(() => _hover = cell);
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<int>(
      onMove: (details) {
        final cell = _cellAt(details.offset);
        _setHover(
            cell != null && widget.canAccept(cell.x, cell.y) ? cell : null);
      },
      onLeave: (_) => _setHover(null),
      onAcceptWithDetails: (details) {
        final cell = _cellAt(details.offset);
        _setHover(null);
        if (cell == null) return;
        if (!widget.canAccept(cell.x, cell.y)) return;
        widget.onPlace(cell.x, cell.y, details.data);
      },
      builder: (context, candidate, rejected) =>
          widget.builder(context, _hover?.x, _hover?.y),
    );
  }
}
