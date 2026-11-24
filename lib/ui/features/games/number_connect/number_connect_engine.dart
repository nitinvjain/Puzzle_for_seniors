import 'dart:math';

/// Number Connect: drag a path through touching tiles that all show the same
/// number. On release they collapse into one tile worth their total, rounded
/// up to the next power of two.
///
///   two 4s  -> 8   (8 is already a power of two)
///   three 4s -> 12 -> 16
///   five 2s  -> 10 -> 16
///
/// Longer chains therefore pay off out of proportion to their length, which
/// is where the interest is. Tiles are always powers of two, so a merge can
/// never produce a value that could not appear on the board.
class NumberConnectBoard {
  final int rows;
  final int cols;

  /// Row-major. 0 means the cell is empty, which only happens mid-move.
  final List<List<int>> cells;

  NumberConnectBoard({
    required this.rows,
    required this.cols,
    required this.cells,
  });
}

class NumberConnectEngine {
  final Random _random;
  final int rows;
  final int cols;

  NumberConnectEngine({this.rows = 7, this.cols = 5, int? seed})
      : _random = Random(seed);

  /// Values a fresh tile may take. Weighted towards the small end so there is
  /// always something to connect.
  static const List<int> _spawnValues = [2, 2, 2, 4, 4, 4, 8, 8, 16];

  int _spawn() => _spawnValues[_random.nextInt(_spawnValues.length)];

  NumberConnectBoard newBoard() => NumberConnectBoard(
        rows: rows,
        cols: cols,
        cells: List.generate(rows, (_) => List.generate(cols, (_) => _spawn())),
      );

  /// Smallest power of two greater than or equal to [n].
  static int roundUpToPowerOfTwo(int n) {
    if (n < 2) return 2;
    var p = 2;
    while (p < n) {
      p *= 2;
    }
    return p;
  }

  /// Whether [b] touches [a], counting diagonals.
  static bool areAdjacent(Point<int> a, Point<int> b) {
    final dr = (a.x - b.x).abs();
    final dc = (a.y - b.y).abs();
    return dr <= 1 && dc <= 1 && (dr != 0 || dc != 0);
  }

  /// Whether [next] may extend [path] on [board].
  ///
  /// Every tile in a chain must show the same number, must touch the one
  /// before it, and may not already be in the chain.
  bool canExtend(
    NumberConnectBoard board,
    List<Point<int>> path,
    Point<int> next,
  ) {
    if (next.x < 0 || next.x >= board.rows) return false;
    if (next.y < 0 || next.y >= board.cols) return false;
    if (board.cells[next.x][next.y] == 0) return false;
    if (path.isEmpty) return true;
    if (path.contains(next)) return false;
    final last = path.last;
    if (!areAdjacent(last, next)) return false;
    return board.cells[next.x][next.y] ==
        board.cells[path.first.x][path.first.y];
  }

  /// The value a chain would produce. Returns 0 for a chain too short to
  /// merge.
  int mergedValue(NumberConnectBoard board, List<Point<int>> path) {
    if (path.length < 2) return 0;
    final sum = path.fold<int>(
      0,
      (total, p) => total + board.cells[p.x][p.y],
    );
    return roundUpToPowerOfTwo(sum);
  }

  /// Applies a chain: the merged tile lands on the LAST tile dragged to, the
  /// rest empty out, everything above falls, and fresh tiles drop in at the
  /// top. Returns the value produced, or 0 if the chain was too short.
  int applyChain(NumberConnectBoard board, List<Point<int>> path) {
    final value = mergedValue(board, path);
    if (value == 0) return 0;

    for (final p in path) {
      board.cells[p.x][p.y] = 0;
    }
    final landing = path.last;
    board.cells[landing.x][landing.y] = value;

    _collapse(board);
    return value;
  }

  /// Gravity, then refill from the top.
  void _collapse(NumberConnectBoard board) {
    for (var c = 0; c < board.cols; c++) {
      final column = <int>[];
      for (var r = board.rows - 1; r >= 0; r--) {
        if (board.cells[r][c] != 0) column.add(board.cells[r][c]);
      }
      for (var r = board.rows - 1; r >= 0; r--) {
        final index = board.rows - 1 - r;
        board.cells[r][c] =
            index < column.length ? column[index] : _spawn();
      }
    }
  }

  /// True when at least one pair of touching tiles share a value.
  ///
  /// The board is refilled after every move, so this is effectively always
  /// true; it exists so the screen can reshuffle in the rare case it is not,
  /// rather than leave the player stuck with nothing to do.
  bool hasMove(NumberConnectBoard board) {
    for (var r = 0; r < board.rows; r++) {
      for (var c = 0; c < board.cols; c++) {
        final v = board.cells[r][c];
        if (v == 0) continue;
        for (var dr = -1; dr <= 1; dr++) {
          for (var dc = -1; dc <= 1; dc++) {
            if (dr == 0 && dc == 0) continue;
            final nr = r + dr, nc = c + dc;
            if (nr < 0 || nr >= board.rows || nc < 0 || nc >= board.cols) {
              continue;
            }
            if (board.cells[nr][nc] == v) return true;
          }
        }
      }
    }
    return false;
  }

  void reshuffle(NumberConnectBoard board) {
    for (var r = 0; r < board.rows; r++) {
      for (var c = 0; c < board.cols; c++) {
        board.cells[r][c] = _spawn();
      }
    }
  }
}
