import 'dart:math';

/// A deliberately gentle 9x9 sudoku, matching the printed books: few blanks,
/// and never more than [maxBlanksPerUnit] missing from any row, column or box.
///
/// That cap is what makes it solvable by scanning alone — look along a line,
/// see which digit is absent, write it in — with no pencil-marking, no
/// candidate lists and no guessing.
class SimpleSudokuPuzzle {
  /// 9x9, 0 for a blank the player must fill.
  final List<List<int>> puzzle;
  final List<List<int>> solution;

  const SimpleSudokuPuzzle({required this.puzzle, required this.solution});

  bool isGiven(int r, int c) => puzzle[r][c] != 0;
}

class SimpleSudokuEngine {
  final Random _random;
  SimpleSudokuEngine([int? seed]) : _random = Random(seed);

  static const int _n = 9;

  /// [maxBlanksPerUnit] 2 gives roughly 16-18 blanks, 3 gives roughly 25.
  SimpleSudokuPuzzle generate({int maxBlanksPerUnit = 3}) {
    final solution = _fullGrid();
    final puzzle = [for (final row in solution) [...row]];

    final rowBlanks = List<int>.filled(_n, 0);
    final colBlanks = List<int>.filled(_n, 0);
    final boxBlanks = List<int>.filled(_n, 0);

    final cells = <Point<int>>[
      for (var r = 0; r < _n; r++)
        for (var c = 0; c < _n; c++) Point(r, c),
    ]..shuffle(_random);

    for (final cell in cells) {
      final r = cell.x, c = cell.y;
      final box = (r ~/ 3) * 3 + c ~/ 3;
      if (rowBlanks[r] >= maxBlanksPerUnit ||
          colBlanks[c] >= maxBlanksPerUnit ||
          boxBlanks[box] >= maxBlanksPerUnit) {
        continue;
      }
      final saved = puzzle[r][c];
      puzzle[r][c] = 0;
      if (_countSolutions(puzzle, 2) != 1) {
        puzzle[r][c] = saved;
      } else {
        rowBlanks[r]++;
        colBlanks[c]++;
        boxBlanks[box]++;
      }
    }

    return SimpleSudokuPuzzle(puzzle: puzzle, solution: solution);
  }

  bool _allowed(List<List<int>> g, int r, int c, int v) {
    for (var i = 0; i < _n; i++) {
      if (g[r][i] == v || g[i][c] == v) return false;
    }
    final br = (r ~/ 3) * 3, bc = (c ~/ 3) * 3;
    for (var i = br; i < br + 3; i++) {
      for (var j = bc; j < bc + 3; j++) {
        if (g[i][j] == v) return false;
      }
    }
    return true;
  }

  List<List<int>> _fullGrid() {
    final g = List.generate(_n, (_) => List.filled(_n, 0));
    bool fill(int pos) {
      if (pos == _n * _n) return true;
      final r = pos ~/ _n, c = pos % _n;
      final values = [for (var v = 1; v <= _n; v++) v]..shuffle(_random);
      for (final v in values) {
        if (!_allowed(g, r, c, v)) continue;
        g[r][c] = v;
        if (fill(pos + 1)) return true;
        g[r][c] = 0;
      }
      return false;
    }

    fill(0);
    return g;
  }

  /// Counts solutions, stopping at [cap]. Picks the most constrained empty
  /// cell first, which keeps this fast enough to run on the device.
  int _countSolutions(List<List<int>> source, int cap) {
    final g = [for (final row in source) [...row]];
    var count = 0;

    void solve() {
      if (count >= cap) return;
      var best = 10, br = -1, bc = -1;
      List<int> bestCandidates = const [];
      for (var r = 0; r < _n; r++) {
        for (var c = 0; c < _n; c++) {
          if (g[r][c] != 0) continue;
          final candidates = [
            for (var v = 1; v <= _n; v++)
              if (_allowed(g, r, c, v)) v
          ];
          if (candidates.length < best) {
            best = candidates.length;
            br = r;
            bc = c;
            bestCandidates = candidates;
          }
          if (best == 0) return;
        }
      }
      if (br == -1) {
        count++;
        return;
      }
      for (final v in bestCandidates) {
        g[br][bc] = v;
        solve();
        g[br][bc] = 0;
        if (count >= cap) return;
      }
    }

    solve();
    return count;
  }
}
