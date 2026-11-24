import 'dart:math';

/// Cross Math: short equations laid out crossword-style, crossing at shared
/// number cells, with a pool of tiles to drop into the gaps.
///
/// Each equation is five cells read left-to-right or top-to-bottom:
///   number, operator, number, equals, result.
///
/// Layouts are fixed templates rather than generated, which keeps the board a
/// predictable size on a tablet and guarantees every crossing is perpendicular
/// with clear space either side — two equations never run on collinearly,
/// which would leave it ambiguous where one ends and the next begins.
/// Every template is a tree (each equation attaches to exactly one earlier
/// one), so the puzzle can always be solved a step at a time rather than by
/// trial and error.

enum CellKind { empty, number, operator, equals }

class Cell {
  final CellKind kind;

  /// For [CellKind.number]: the correct value.
  final int value;

  /// For [CellKind.operator]: one of + - x /.
  final String op;

  /// True when the player must supply this number.
  final bool isBlank;

  const Cell({
    required this.kind,
    this.value = 0,
    this.op = '',
    this.isBlank = false,
  });

  Cell copyWith({bool? isBlank}) => Cell(
        kind: kind,
        value: value,
        op: op,
        isBlank: isBlank ?? this.isBlank,
      );
}

/// One equation: the five cell positions it occupies, in reading order.
class Equation {
  final List<Point<int>> cells;
  const Equation(this.cells);

  Point<int> get a => cells[0];
  Point<int> get b => cells[2];
  Point<int> get result => cells[4];
  Point<int> get opCell => cells[1];
}

class CrossMathPuzzle {
  final int rows;
  final int cols;

  /// Row-major grid. Cells not part of any equation are [CellKind.empty].
  final List<List<Cell>> grid;
  final List<Equation> equations;

  /// Tile values the player places, in sorted order. May contain duplicates.
  final List<int> pool;

  /// Positions the player must fill, in a stable order.
  final List<Point<int>> blanks;

  const CrossMathPuzzle({
    required this.rows,
    required this.cols,
    required this.grid,
    required this.equations,
    required this.pool,
    required this.blanks,
  });
}

// --------------------------------------------------------------------------
// Templates
// --------------------------------------------------------------------------

/// A template describes where equations sit. `true` = horizontal.
class _Template {
  final int rows;
  final int cols;
  final List<List<int>> specs; // [row, col, horizontal ? 1 : 0]
  const _Template(this.rows, this.cols, this.specs);
}

/// Seven equations on a 9x9 board, which gives fifteen distinct number cells
/// and so room for ten or more blanks.
///
/// Every one of these satisfies the rules in the header comment, and they were
/// checked rather than eyeballed: all cells in bounds, crossings only where
/// BOTH equations have a number (never on an operator or an equals sign), no
/// two equations of the same direction sharing a row or column, and a tree --
/// each equation attaches to exactly one earlier one by exactly one cell.
/// The last part matters twice over: it is what lets the board be solved a
/// step at a time, and [_fillEquation] relies on an equation's parent being
/// filled before it, so the order within each template is not arbitrary.
const List<_Template> _templates = [
  // A five-by-five block in the top-left corner, then a staircase of
  // equations stepping away to the bottom-right.
  _Template(9, 9, [
    [0, 0, 1],
    [0, 0, 0],
    [0, 2, 0],
    [0, 4, 0],
    [4, 4, 1],
    [4, 8, 0],
    [8, 4, 1],
  ]),
  // The same shape mirrored, stepping down to the bottom-left.
  _Template(9, 9, [
    [0, 4, 1],
    [0, 8, 0],
    [0, 6, 0],
    [0, 4, 0],
    [4, 0, 1],
    [4, 0, 0],
    [8, 0, 1],
  ]),
  // A spine down the middle with three arms off it, and a branch off the
  // right-hand arm.
  _Template(9, 9, [
    [0, 4, 0],
    [0, 0, 1],
    [2, 4, 1],
    [4, 0, 1],
    [2, 8, 0],
    [6, 4, 1],
    [4, 0, 0],
  ]),
];

/// The board used only if generation somehow fails: small, and solved.
const _Template _fallbackTemplate = _Template(5, 5, [
  [0, 0, 1],
  [0, 2, 0],
  [4, 0, 1],
]);

List<Equation> _buildEquations(_Template t) => t.specs.map((s) {
      final r = s[0], c = s[1], horiz = s[2] == 1;
      return Equation(List.generate(
        5,
        (i) => horiz ? Point(r, c + i) : Point(r + i, c),
      ));
    }).toList();

// --------------------------------------------------------------------------
// Generation
// --------------------------------------------------------------------------

int? _apply(int a, String op, int b) {
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

class CrossMathEngine {
  final Random _random;
  CrossMathEngine([int? seed]) : _random = Random(seed);

  /// [ops] limits which signs appear; [blankCount] is how many tiles the
  /// player places.
  CrossMathPuzzle generate({
    List<String> ops = const ['+', '-', 'x', '/'],
    int blankCount = 4,
  }) {
    for (var attempt = 0; attempt < 4000; attempt++) {
      final t = _templates[_random.nextInt(_templates.length)];
      final equations = _buildEquations(t);
      final values = <Point<int>, int>{};
      final opFor = <int, String>{};

      var ok = true;
      for (var i = 0; i < equations.length && ok; i++) {
        ok = _fillEquation(equations[i], values, opFor, i, ops);
      }
      if (!ok) continue;

      // Build the grid.
      final grid = List.generate(
        t.rows,
        (_) => List.filled(t.cols, const Cell(kind: CellKind.empty)),
      );
      for (var i = 0; i < equations.length; i++) {
        final e = equations[i];
        grid[e.cells[0].x][e.cells[0].y] =
            Cell(kind: CellKind.number, value: values[e.cells[0]]!);
        grid[e.cells[1].x][e.cells[1].y] =
            Cell(kind: CellKind.operator, op: opFor[i]!);
        grid[e.cells[2].x][e.cells[2].y] =
            Cell(kind: CellKind.number, value: values[e.cells[2]]!);
        grid[e.cells[3].x][e.cells[3].y] = const Cell(kind: CellKind.equals);
        grid[e.cells[4].x][e.cells[4].y] =
            Cell(kind: CellKind.number, value: values[e.cells[4]]!);
      }

      // Choose blanks and check the answer is the only one that fits.
      final numberCells = <Point<int>>[];
      for (final e in equations) {
        for (final i in [0, 2, 4]) {
          if (!numberCells.contains(e.cells[i])) numberCells.add(e.cells[i]);
        }
      }
      if (numberCells.length < blankCount + 1) continue;

      for (var tries = 0; tries < 24; tries++) {
        final shuffled = [...numberCells]..shuffle(_random);
        final blanks =
            _orderForPruning(shuffled.take(blankCount).toList(), equations);
        final pool = blanks.map((p) => values[p]!).toList()..sort();
        if (_countSolutions(grid, equations, blanks, pool, 2) != 1) continue;

        for (final p in blanks) {
          grid[p.x][p.y] = grid[p.x][p.y].copyWith(isBlank: true);
        }
        return CrossMathPuzzle(
          rows: t.rows,
          cols: t.cols,
          grid: grid,
          equations: equations,
          pool: pool,
          blanks: blanks,
        );
      }
    }
    // Templates are small and the constraints loose, so this is effectively
    // unreachable; fall back to the simplest possible board rather than throw.
    return _fallback();
  }

  /// Orders the blanks so that each equation is completed as early as possible
  /// in the uniqueness search.
  ///
  /// This is about generation speed, not about the puzzle. [_countSolutions]
  /// can only reject a guess once all three numbers of some equation are
  /// known, so reading the blanks top-left to bottom-right -- which is what
  /// this used to do -- can leave one equation's cells scattered across the
  /// whole search, and nothing gets rejected until the very end. Filling
  /// equation by equation instead lets a wrong tile be thrown out at once.
  /// On a nine-by-nine board with twelve blanks that is the difference
  /// between roughly 51,000 search steps and roughly 2,200.
  static List<Point<int>> _orderForPruning(
    List<Point<int>> blanks,
    List<Equation> equations,
  ) {
    final remaining = {...blanks};
    final ordered = <Point<int>>[];
    for (final e in equations) {
      for (final i in [0, 2, 4]) {
        if (remaining.remove(e.cells[i])) ordered.add(e.cells[i]);
      }
    }
    // Anything not covered above (there should be nothing) keeps a stable
    // order rather than being dropped.
    final leftover = remaining.toList()
      ..sort((p, q) => p.x != q.x ? p.x - q.x : p.y - q.y);
    return [...ordered, ...leftover];
  }

  /// Fills one equation, honouring any cell already fixed by a crossing.
  bool _fillEquation(
    Equation e,
    Map<Point<int>, int> values,
    Map<int, String> opFor,
    int index,
    List<String> ops,
  ) {
    for (var attempt = 0; attempt < 300; attempt++) {
      final op = ops[_random.nextInt(ops.length)];
      final knownA = values[e.a];
      final knownB = values[e.b];
      final knownR = values[e.result];

      int? a = knownA, b = knownB, r = knownR;

      if (r != null && (a == null || b == null)) {
        // The result is fixed by a crossing: search for a pair that gives it.
        final candidates = <List<int>>[];
        for (var x = a ?? 1; x <= (a ?? 9); x++) {
          for (var y = b ?? 1; y <= (b ?? 9); y++) {
            if (_apply(x, op, y) == r) candidates.add([x, y]);
          }
        }
        if (candidates.isEmpty) continue;
        final pick = candidates[_random.nextInt(candidates.length)];
        a = pick[0];
        b = pick[1];
      } else {
        a ??= 1 + _random.nextInt(9);
        b ??= 1 + _random.nextInt(9);
        final computed = _apply(a, op, b);
        if (computed == null || computed < 1 || computed > 99) continue;
        if (r != null && r != computed) continue;
        r = computed;
      }

      if (a! < 1 || a > 99 || b! < 1 || b > 99 || r! < 1 || r > 99) continue;
      if (_apply(a, op, b) != r) continue;

      values[e.a] = a;
      values[e.b] = b;
      values[e.result] = r;
      opFor[index] = op;
      return true;
    }
    return false;
  }

  /// Counts the ways [pool] can be placed into [blanks] so every equation
  /// holds, stopping once [cap] is reached.
  int _countSolutions(
    List<List<Cell>> grid,
    List<Equation> equations,
    List<Point<int>> blanks,
    List<int> pool,
    int cap,
  ) {
    final assign = <Point<int>, int>{};
    final used = List<bool>.filled(pool.length, false);
    var count = 0;

    int? valueAt(Point<int> p) =>
        assign[p] ?? (blanks.contains(p) ? null : grid[p.x][p.y].value);

    bool consistent(Point<int> justSet) {
      for (var i = 0; i < equations.length; i++) {
        final e = equations[i];
        if (!e.cells.contains(justSet)) continue;
        final a = valueAt(e.a), b = valueAt(e.b), r = valueAt(e.result);
        if (a == null || b == null || r == null) continue;
        if (_apply(a, grid[e.opCell.x][e.opCell.y].op, b) != r) return false;
      }
      return true;
    }

    void rec(int i) {
      if (count >= cap) return;
      if (i == blanks.length) {
        count++;
        return;
      }
      final tried = <int>{};
      for (var k = 0; k < pool.length; k++) {
        if (used[k] || tried.contains(pool[k])) continue;
        tried.add(pool[k]);
        assign[blanks[i]] = pool[k];
        used[k] = true;
        if (consistent(blanks[i])) rec(i + 1);
        assign.remove(blanks[i]);
        used[k] = false;
        if (count >= cap) return;
      }
    }

    rec(0);
    return count;
  }

  CrossMathPuzzle _fallback() {
    final equations = _buildEquations(_fallbackTemplate);
    final grid = List.generate(
      5,
      (_) => List.filled(5, const Cell(kind: CellKind.empty)),
    );
    void put(Equation e, int a, String op, int b, int r) {
      grid[e.cells[0].x][e.cells[0].y] = Cell(kind: CellKind.number, value: a);
      grid[e.cells[1].x][e.cells[1].y] = Cell(kind: CellKind.operator, op: op);
      grid[e.cells[2].x][e.cells[2].y] = Cell(kind: CellKind.number, value: b);
      grid[e.cells[3].x][e.cells[3].y] = const Cell(kind: CellKind.equals);
      grid[e.cells[4].x][e.cells[4].y] = Cell(kind: CellKind.number, value: r);
    }

    put(equations[0], 3, '+', 4, 7);
    put(equations[1], 4, '+', 2, 6);
    put(equations[2], 5, '+', 6, 11);
    final blanks = [equations[0].a, equations[1].b];
    for (final p in blanks) {
      grid[p.x][p.y] = grid[p.x][p.y].copyWith(isBlank: true);
    }
    return CrossMathPuzzle(
      rows: 5,
      cols: 5,
      grid: grid,
      equations: equations,
      pool: [2, 3],
      blanks: blanks,
    );
  }
}
