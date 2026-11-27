import 'dart:math';

class WordSearchWord {
  final String word;
  final List<Point<int>> positions;
  bool isFound;

  WordSearchWord({
    required this.word,
    required this.positions,
    this.isFound = false,
  });
}

class WordSearchBoard {
  final int size;
  final List<List<String>> grid;
  final List<WordSearchWord> words;

  WordSearchBoard({
    required this.size,
    required this.grid,
    required this.words,
  });
}

/// What to build. Carried as one object because the board is generated on a
/// background isolate through [compute], which hands across a single argument.
class WordSearchRequest {
  final List<String> candidates;
  final int boardSize;
  final int maxWords;

  const WordSearchRequest({
    required this.candidates,
    required this.boardSize,
    required this.maxWords,
  });
}

class WordSearchEngine {
  /// The everyday board.
  static const int boardSize = 10;
  static const int defaultWordCount = 8;

  /// The longer board, every other round.
  static const int largeBoardSize = 12;
  static const int largeWordCount = 10;

  static final Random _random = Random();

  /// The old entry point, kept so anything still calling it gets the
  /// everyday board.
  static WordSearchBoard generateBoard(List<String> candidates) => generate(
        WordSearchRequest(
          candidates: candidates,
          boardSize: boardSize,
          maxWords: defaultWordCount,
        ),
      );

  static WordSearchBoard generate(WordSearchRequest request) {
    final int size = request.boardSize;
    List<List<String>> grid = List.generate(size, (_) => List.filled(size, ''));
    List<WordSearchWord> placedWords = [];

    for (String word in request.candidates) {
      if (placedWords.length >= request.maxWords) break;
      _tryPlaceWord(grid, word, placedWords, size);
    }

    // Fill remaining empty cells with random letters
    const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    for (int y = 0; y < size; y++) {
      for (int x = 0; x < size; x++) {
        if (grid[y][x] == '') {
          grid[y][x] = letters[_random.nextInt(letters.length)];
        }
      }
    }

    return WordSearchBoard(size: size, grid: grid, words: placedWords);
  }

  static bool _tryPlaceWord(List<List<String>> grid, String word,
      List<WordSearchWord> placedWords, int boardSize) {
    // Directions: [dx, dy]
    final directions = [
      [1, 0],   // Horizontal
      [0, 1],   // Vertical
      [1, 1],   // Diagonal down-right
      [1, -1],  // Diagonal up-right
    ];
    directions.shuffle(_random);

    // Try all possible start positions using 1D index to avoid Point object allocation
    List<int> starts = List.generate(boardSize * boardSize, (i) => i);
    starts.shuffle(_random);

    for (var dir in directions) {
      int dx = dir[0];
      int dy = dir[1];

      for (var startIndex in starts) {
        int startX = startIndex % boardSize;
        int startY = startIndex ~/ boardSize;
        
        if (_canPlace(grid, word, startX, startY, dx, dy, boardSize)) {
          List<Point<int>> positions = [];
          for (int i = 0; i < word.length; i++) {
            int x = startX + (i * dx);
            int y = startY + (i * dy);
            grid[y][x] = word[i];
            positions.add(Point(x, y));
          }
          placedWords.add(WordSearchWord(word: word, positions: positions));
          return true;
        }
      }
    }
    return false;
  }

  static bool _canPlace(List<List<String>> grid, String word, int startX,
      int startY, int dx, int dy, int boardSize) {
    int endX = startX + (word.length - 1) * dx;
    int endY = startY + (word.length - 1) * dy;

    if (endX < 0 || endX >= boardSize || endY < 0 || endY >= boardSize) return false;

    for (int i = 0; i < word.length; i++) {
      int x = startX + (i * dx);
      int y = startY + (i * dy);
      if (grid[y][x] != '' && grid[y][x] != word[i]) return false;
    }
    return true;
  }
}

