/// Cross Math: a lattice of equations sharing cells, with some of the numbers
/// lifted out into a tray for the player to put back.
///
/// Three things shape the generator.
///
/// **Equations come in two shapes.** A plain one is `n op n = n`; a two-sided
/// one is `n op n = n op n`, where the equals sign has work on both sides of
/// it. Five cells and seven, so nothing here may assume a fixed length.
///
/// Factorial and modulo were tried and taken out again: they read as
/// confusing rather than interesting, and factorial in particular dragged
/// values up to 720, which forced the cells wider than the board could
/// afford. Without them nothing on the board exceeds 81.
///
/// **The board is built rather than chosen.** It used to pick from three
/// hand-written templates, which meant three board shapes forever. Now a
/// tree of equations is grown at run time: each new one crosses exactly one
/// earlier one, at a cell that holds a number in both. Every board is
/// different and none of them has been eyeballed by hand, so the growing
/// code enforces what the hand-written ones were checked for -- in bounds,
/// crossings only on numbers, no two equations lying flush alongside each
/// other.
///
/// **A board must be solvable by reasoning, not only uniquely solvable.**
/// Those are not the same thing, and the difference matters here more than
/// anywhere. A unique board can still reach a point where the only way on is
/// to try a tile and see; measured over the old generator, half of its boards
/// were like that. So after the uniqueness check the board is solved a second
/// way, by forced steps alone -- for each equation, every way of filling its
/// gaps from the tiles still in the tray; a cell that takes the same value in
/// all of them is forced -- and the board is thrown away unless that alone
/// finishes it. He should never be stuck in front of a puzzle whose next move
/// can only be found by guessing.
library;

import 'dart:math';

// --------------------------------------------------------------------------
// Model
// --------------------------------------------------------------------------

enum CellKind { empty, number, operator, equals }

/// The three shapes an equation can take.
enum EquationForm {
  /// `n op n = n`
  binary,

  /// `n op n = n op n`
  twoSided,
}

extension EquationFormInfo on EquationForm {
  /// How many cells the equation occupies along its line.
  int get length => switch (this) {
        EquationForm.binary => 5,
        EquationForm.twoSided => 7,
      };

  /// Indices within the line that hold numbers.
  List<int> get numberIndices => switch (this) {
        EquationForm.binary => const [0, 2, 4],
        EquationForm.twoSided => const [0, 2, 4, 6],
      };

  /// Indices that hold an operator sign.
  List<int> get operatorIndices => switch (this) {
        EquationForm.binary => const [1],
        EquationForm.twoSided => const [1, 5],
      };

  /// Index of the equals sign.
  int get equalsIndex => switch (this) {
        EquationForm.binary => 3,
        EquationForm.twoSided => 3,
      };
}

class Cell {
  final CellKind kind;

  /// For [CellKind.number]: the correct value.
  final int value;

  /// For [CellKind.operator]: one of + - x / % !
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

/// One equation: the cells it occupies, in reading order, and its shape.
class Equation {
  final List<Point<int>> cells;
  final EquationForm form;

  /// The operator signs, in order. One for [EquationForm.binary], two for
  /// [EquationForm.twoSided].
  final List<String> ops;

  const Equation(this.cells, this.form, this.ops);

  /// The cells holding numbers, in reading order.
  List<Point<int>> get numberCells =>
      [for (final i in form.numberIndices) cells[i]];

  Equation withOps(List<String> newOps) => Equation(cells, form, newOps);
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
// Arithmetic
// --------------------------------------------------------------------------

const List<String> _binaryOps = ['+', '-', 'x', '/'];

/// Returns null where the operation does not produce a whole number above
/// zero, which keeps every value on the board a positive integer -- no
/// negatives, no zero, no fractions.
int? applyOp(int a, String op, int b) {
  switch (op) {
    case '+':
      return a + b;
    case '-':
      return a - b >= 1 ? a - b : null;
    case 'x':
      return a * b;
    case '/':
      if (b == 0 || a % b != 0) return null;
      final r = a ~/ b;
      return r >= 1 ? r : null;
  }
  return null;
}

// --------------------------------------------------------------------------
// Generation
// --------------------------------------------------------------------------

class CrossMathEngine {
  final Random _random;
  CrossMathEngine([int? seed]) : _random = Random(seed);

  /// Board size and how many equations to grow onto it.
  ///
  /// Eleven across with ten equations rather than nine with seven: about
  /// twenty-four numbers on the board where there used to be seventeen. The
  /// cells come out smaller for it, which is the trade NJ asked for -- more
  /// of the puzzle visible, each piece of it a little smaller -- and is only
  /// affordable because no value now runs past two digits.
  static const int _size = 11;
  static const int _equationCount = 10;

  /// [blankCount] is how many tiles the player places.
  CrossMathPuzzle generate({int blankCount = 12}) {
    for (var attempt = 0; attempt < 120; attempt++) {
      final equations = _buildTemplate();
      if (equations == null) continue;

      final values = <Point<int>, int>{};
      final filled = <Equation>[];
      var ok = true;
      for (final e in equations) {
        final done = _fillEquation(e, values);
        if (done == null) {
          ok = false;
          break;
        }
        filled.add(done);
      }
      if (!ok) continue;

      final numberCells = <Point<int>>[];
      for (final e in filled) {
        for (final c in e.numberCells) {
          if (!numberCells.contains(c)) numberCells.add(c);
        }
      }
      if (numberCells.length < blankCount + 1) continue;

      for (var tries = 0; tries < 30; tries++) {
        final shuffled = [...numberCells]..shuffle(_random);
        final blanks =
            _orderForPruning(shuffled.take(blankCount).toList(), filled);
        final pool = blanks.map((p) => values[p]!).toList()..sort();

        if (_countSolutions(filled, values, blanks, pool, 2) != 1) continue;
        // Unique is not enough: it must also be reasonable.
        if (!_solvableByReasoning(filled, values, blanks, pool)) continue;

        return _assemble(filled, values, blanks, pool);
      }
    }
    return _fallback();
  }

  // ------------------------------------------------------------- the board

  /// Grows a tree of equations, each crossing exactly one earlier one.
  List<Equation>? _buildTemplate() {
    // cell -> role, so a crossing can be checked to be a number in both.
    final role = <Point<int>, CellKind>{};
    final out = <Equation>[];

    List<Point<int>> lineCells(int r, int c, bool horiz, EquationForm f) => [
          for (var i = 0; i < f.length; i++)
            horiz ? Point(r, c + i) : Point(r + i, c),
        ];

    CellKind roleAt(EquationForm f, int i) {
      if (f.numberIndices.contains(i)) return CellKind.number;
      if (i == f.equalsIndex) return CellKind.equals;
      return CellKind.operator;
    }

    /// Returns the cells if the equation can go here, else null.
    List<Point<int>>? tryPlace(
      int r,
      int c,
      bool horiz,
      EquationForm f, {
      Point<int>? mustCross,
    }) {
      final cs = lineCells(r, c, horiz, f);
      for (final p in cs) {
        if (p.x < 0 || p.x >= _size || p.y < 0 || p.y >= _size) return null;
      }
      var crossings = 0;
      for (var i = 0; i < cs.length; i++) {
        final existing = role[cs[i]];
        if (existing == null) continue;
        // Only ever cross on a cell that is a number in both equations.
        if (existing != CellKind.number ||
            roleAt(f, i) != CellKind.number) {
          return null;
        }
        crossings++;
      }
      if (mustCross == null) {
        if (crossings != 0) return null;
      } else {
        if (crossings != 1 || !cs.contains(mustCross)) return null;
      }
      // Two equations lying flush alongside each other read as one long line,
      // so a new cell may not touch a cell of another equation.
      for (final p in cs) {
        if (role.containsKey(p)) continue;
        for (final d in const [Point(1, 0), Point(-1, 0), Point(0, 1), Point(0, -1)]) {
          final nb = Point(p.x + d.x, p.y + d.y);
          if (role.containsKey(nb) && !cs.contains(nb)) return null;
        }
      }
      return cs;
    }

    void commit(List<Point<int>> cs, EquationForm f, bool horiz) {
      for (var i = 0; i < cs.length; i++) {
        role.putIfAbsent(cs[i], () => roleAt(f, i));
      }
      out.add(Equation(cs, f, const []));
    }

    // The first equation, placed anywhere it fits.
    var seeded = false;
    for (var attempt = 0; attempt < 200 && !seeded; attempt++) {
      final f = EquationForm.values[_random.nextInt(EquationForm.values.length)];
      final horiz = _random.nextBool();
      final r = _random.nextInt(horiz ? _size : _size - f.length + 1);
      final c = _random.nextInt(horiz ? _size - f.length + 1 : _size);
      final cs = tryPlace(r, c, horiz, f);
      if (cs != null) {
        commit(cs, f, horiz);
        seeded = true;
      }
    }
    if (!seeded) return null;

    final horizontals = <bool>[
      out.first.cells.length > 1 &&
          out.first.cells[0].x == out.first.cells[1].x,
    ];

    var guard = 0;
    while (out.length < _equationCount && guard < 4000) {
      guard++;
      final parentIndex = _random.nextInt(out.length);
      final parent = out[parentIndex];
      final parentNums = parent.numberCells;
      final cross = parentNums[_random.nextInt(parentNums.length)];

      final f = EquationForm.values[_random.nextInt(EquationForm.values.length)];
      final horiz = !horizontals[parentIndex];
      final nums = f.numberIndices;
      final idx = nums[_random.nextInt(nums.length)];

      final r = horiz ? cross.x : cross.x - idx;
      final c = horiz ? cross.y - idx : cross.y;

      final cs = tryPlace(r, c, horiz, f, mustCross: cross);
      if (cs == null) continue;
      commit(cs, f, horiz);
      horizontals.add(horiz);
    }
    return out.length == _equationCount ? out : null;
  }

  // ------------------------------------------------------------ the values

  /// Fills one equation, honouring any cell already fixed by a crossing.
  ///
  /// The sign is picked first, from a shuffled list, and only then are values
  /// searched for it. Pooling every candidate of every sign and choosing at
  /// random instead would hand the board to whichever sign has the most
  /// combinations -- modulo, by a wide margin, which took two of every five
  /// slots before this was changed.
  Equation? _fillEquation(Equation e, Map<Point<int>, int> values) {
    final slots = e.numberCells;
    final known = [for (final s in slots) values[s]];

    final order = [..._binaryOps]..shuffle(_random);

    switch (e.form) {
      case EquationForm.binary:
        for (final op in order) {
          final found = _searchBinary(op, known[0], known[1], known[2]);
          if (found == null) continue;
          for (var i = 0; i < 3; i++) {
            values[slots[i]] = found[i];
          }
          return e.withOps([op]);
        }
        return null;

      case EquationForm.twoSided:
        for (final left in order) {
          for (final right in order) {
            final found = _searchTwoSided(
                left, right, known[0], known[1], known[2], known[3]);
            if (found == null) continue;
            for (var i = 0; i < 4; i++) {
              values[slots[i]] = found[i];
            }
            return e.withOps([left, right]);
          }
        }
        return null;
    }
  }

  /// A random (a, b, r) with `a op b == r`, respecting whatever is known.
  List<int>? _searchBinary(String op, int? ka, int? kb, int? kr) {
    final hits = <List<int>>[];
    for (var a = ka ?? 1; a <= (ka ?? 9); a++) {
      if (a < 1 || a > 9) break;
      for (var b = kb ?? 1; b <= (kb ?? 9); b++) {
        if (b < 1 || b > 9) break;
        final r = applyOp(a, op, b);
        if (r == null) continue;
        if (kr != null && r != kr) continue;
        hits.add([a, b, r]);
        if (hits.length >= 400) break;
      }
    }
    if (hits.isEmpty) return null;
    return hits[_random.nextInt(hits.length)];
  }

  /// A random (a, b, c, d) with `a left b == c right d`.
  List<int>? _searchTwoSided(
      String left, String right, int? ka, int? kb, int? kc, int? kd) {
    // Left-hand values, indexed by what they come to.
    final byValue = <int, List<List<int>>>{};
    for (var a = ka ?? 1; a <= (ka ?? 9); a++) {
      if (a < 1 || a > 9) break;
      for (var b = kb ?? 1; b <= (kb ?? 9); b++) {
        if (b < 1 || b > 9) break;
        final v = applyOp(a, left, b);
        if (v == null) continue;
        (byValue[v] ??= []).add([a, b]);
      }
    }
    if (byValue.isEmpty) return null;

    final hits = <List<int>>[];
    for (var c = kc ?? 1; c <= (kc ?? 9); c++) {
      if (c < 1 || c > 9) break;
      for (var d = kd ?? 1; d <= (kd ?? 9); d++) {
        if (d < 1 || d > 9) break;
        final v = applyOp(c, right, d);
        if (v == null) continue;
        final lefts = byValue[v];
        if (lefts == null) continue;
        final l = lefts[_random.nextInt(lefts.length)];
        hits.add([l[0], l[1], c, d]);
        if (hits.length >= 400) break;
      }
    }
    if (hits.isEmpty) return null;
    return hits[_random.nextInt(hits.length)];
  }

  // ------------------------------------------------------------- checking

  /// True when every number of [e] is known and the equation holds.
  bool _holds(Equation e, int? Function(Point<int>) get) {
    final v = [for (final c in e.numberCells) get(c)];
    if (v.any((x) => x == null)) return true; // not yet judgeable
    switch (e.form) {
      case EquationForm.binary:
        return applyOp(v[0]!, e.ops[0], v[1]!) == v[2];
      case EquationForm.twoSided:
        final l = applyOp(v[0]!, e.ops[0], v[1]!);
        final r = applyOp(v[2]!, e.ops[1], v[3]!);
        return l != null && r != null && l == r;
    }
  }

  /// How many ways the tray fills the blanks, stopping at [cap].
  int _countSolutions(
    List<Equation> equations,
    Map<Point<int>, int> values,
    List<Point<int>> blanks,
    List<int> pool,
    int cap,
  ) {
    final blankSet = blanks.toSet();
    final assign = <Point<int>, int>{};
    final used = List<bool>.filled(pool.length, false);
    var found = 0;

    int? get(Point<int> c) =>
        blankSet.contains(c) ? assign[c] : values[c];

    void rec(int i) {
      if (found >= cap) return;
      if (i == blanks.length) {
        found++;
        return;
      }
      final cell = blanks[i];
      final tried = <int>{};
      for (var j = 0; j < pool.length; j++) {
        if (used[j] || !tried.add(pool[j])) continue;
        used[j] = true;
        assign[cell] = pool[j];
        var good = true;
        for (final e in equations) {
          if (!_holds(e, get)) {
            good = false;
            break;
          }
        }
        if (good) rec(i + 1);
        used[j] = false;
        assign.remove(cell);
        if (found >= cap) return;
      }
    }

    rec(0);
    return found;
  }

  /// Can the board be finished by forced steps alone?
  ///
  /// For each equation, every way of filling its gaps from the tiles still in
  /// the tray is enumerated; a cell taking the same value in all of them is
  /// forced and gets placed. Repeat until nothing more gives. If that empties
  /// the tray, nothing in the board ever required a guess.
  bool _solvableByReasoning(
    List<Equation> equations,
    Map<Point<int>, int> values,
    List<Point<int>> blanks,
    List<int> pool,
  ) {
    final unknown = blanks.toSet();
    final assign = <Point<int>, int>{};
    final tray = [...pool];

    int? get(Point<int> c) =>
        unknown.contains(c) ? assign[c] : values[c];

    var progress = true;
    while (unknown.isNotEmpty && progress) {
      progress = false;
      for (final e in equations) {
        final slots = e.numberCells;
        final current = [for (final c in slots) get(c)];
        final missing = <int>[
          for (var i = 0; i < current.length; i++)
            if (current[i] == null) i,
        ];
        if (missing.isEmpty || missing.length > 3) continue;

        // Every arrangement of tray tiles that satisfies this equation.
        final solutions = <List<int>>[];
        void place(int k, List<int> candidate, List<bool> taken) {
          if (solutions.length > 60) return;
          if (k == missing.length) {
            final trial = [...candidate];
            if (_holdsValues(e, trial)) {
              solutions.add([for (final i in missing) trial[i]]);
            }
            return;
          }
          final seen = <int>{};
          for (var j = 0; j < tray.length; j++) {
            if (taken[j] || !seen.add(tray[j])) continue;
            taken[j] = true;
            candidate[missing[k]] = tray[j];
            place(k + 1, candidate, taken);
            taken[j] = false;
            candidate[missing[k]] = -1;
          }
        }

        place(0, [for (final v in current) v ?? -1],
            List<bool>.filled(tray.length, false));
        if (solutions.isEmpty) continue;

        for (var pos = 0; pos < missing.length; pos++) {
          final distinct = {for (final s in solutions) s[pos]};
          if (distinct.length != 1) continue;
          final v = distinct.first;
          final cell = slots[missing[pos]];
          if (!unknown.contains(cell) || !tray.remove(v)) continue;
          assign[cell] = v;
          unknown.remove(cell);
          progress = true;
        }
      }
    }
    return unknown.isEmpty;
  }

  /// [_holds] for a list of values already gathered, with no unknowns.
  bool _holdsValues(Equation e, List<int> v) {
    if (v.any((x) => x < 0)) return false;
    switch (e.form) {
      case EquationForm.binary:
        return applyOp(v[0], e.ops[0], v[1]) == v[2];
      case EquationForm.twoSided:
        final l = applyOp(v[0], e.ops[0], v[1]);
        final r = applyOp(v[2], e.ops[1], v[3]);
        return l != null && r != null && l == r;
    }
  }

  /// Orders the blanks so each equation is completed as early as possible in
  /// the uniqueness search, which is what makes that search quick.
  static List<Point<int>> _orderForPruning(
    List<Point<int>> blanks,
    List<Equation> equations,
  ) {
    final remaining = {...blanks};
    final ordered = <Point<int>>[];
    for (final e in equations) {
      for (final c in e.numberCells) {
        if (remaining.remove(c)) ordered.add(c);
      }
    }
    final leftover = remaining.toList()
      ..sort((p, q) => p.x != q.x ? p.x - q.x : p.y - q.y);
    return [...ordered, ...leftover];
  }

  // ------------------------------------------------------------- assembly

  CrossMathPuzzle _assemble(
    List<Equation> equations,
    Map<Point<int>, int> values,
    List<Point<int>> blanks,
    List<int> pool,
  ) {
    final grid = List.generate(
      _size,
      (_) => List.filled(_size, const Cell(kind: CellKind.empty)),
    );
    for (final e in equations) {
      final f = e.form;
      var opSeen = 0;
      for (var i = 0; i < e.cells.length; i++) {
        final p = e.cells[i];
        if (f.numberIndices.contains(i)) {
          grid[p.x][p.y] = Cell(kind: CellKind.number, value: values[p]!);
        } else if (i == f.equalsIndex) {
          grid[p.x][p.y] = const Cell(kind: CellKind.equals);
        } else {
          grid[p.x][p.y] =
              Cell(kind: CellKind.operator, op: e.ops[opSeen++]);
        }
      }
    }
    for (final p in blanks) {
      grid[p.x][p.y] = grid[p.x][p.y].copyWith(isBlank: true);
    }
    return CrossMathPuzzle(
      rows: _size,
      cols: _size,
      grid: grid,
      equations: equations,
      pool: pool,
      blanks: blanks,
    );
  }

  /// Used only if generation somehow fails: small, and certainly solvable.
  CrossMathPuzzle _fallback() {
    final equations = <Equation>[
      Equation(const [Point(0, 0), Point(0, 1), Point(0, 2), Point(0, 3), Point(0, 4)],
          EquationForm.binary, const ['+']),
      Equation(const [Point(0, 2), Point(1, 2), Point(2, 2), Point(3, 2), Point(4, 2)],
          EquationForm.binary, const ['x']),
    ];
    final values = <Point<int>, int>{
      const Point(0, 0): 3,
      const Point(0, 2): 4,
      const Point(0, 4): 7,
      const Point(2, 2): 2,
      const Point(4, 2): 8,
    };
    final blanks = <Point<int>>[const Point(0, 0), const Point(2, 2)];
    final grid = List.generate(
      5,
      (_) => List.filled(5, const Cell(kind: CellKind.empty)),
    );
    for (final e in equations) {
      var opSeen = 0;
      for (var i = 0; i < e.cells.length; i++) {
        final p = e.cells[i];
        if (e.form.numberIndices.contains(i)) {
          grid[p.x][p.y] = Cell(kind: CellKind.number, value: values[p]!);
        } else if (i == e.form.equalsIndex) {
          grid[p.x][p.y] = const Cell(kind: CellKind.equals);
        } else {
          grid[p.x][p.y] = Cell(kind: CellKind.operator, op: e.ops[opSeen++]);
        }
      }
    }
    for (final p in blanks) {
      grid[p.x][p.y] = grid[p.x][p.y].copyWith(isBlank: true);
    }
    return CrossMathPuzzle(
      rows: 5,
      cols: 5,
      grid: grid,
      equations: equations,
      pool: [3, 2]..sort(),
      blanks: blanks,
    );
  }
}
