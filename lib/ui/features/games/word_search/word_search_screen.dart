import "package:puzzle/l10n/app_localizations.dart";
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'word_search_engine.dart';
import 'word_search_provider.dart';
import '../../../../../providers/user_providers.dart';
import '../../../../../utils/design_system.dart';
import '../../../../../utils/haptic_feedback.dart';
import '../../../../widgets/game_completion_dialog.dart';
import '../../../../widgets/tangible.dart';
import '../../../core/juice/game_scaffold.dart';

/// Word search, laid out for someone who needs to see it from arm's length.
///
/// Three things drive the design:
///
///   * the list of words to find sits ABOVE the grid, because that is the
///     order the task is done in -- read the word, then go looking for it;
///
///   * every word owns a colour, and that one colour is used in both places:
///     it fills the word's chip in the list and it paints the word's pill in
///     the grid. Finding GREAT and seeing the same orange appear in both
///     places says "that one, there" without a word of explanation;
///
///   * nothing is small. The chips auto-shrink only as far as they must to
///     fit, the grid letters scale with the cell, and the whole board takes
///     whatever height is left over instead of floating in the middle of an
///     empty screen.
class WordSearchScreen extends ConsumerStatefulWidget {
  const WordSearchScreen({super.key});

  @override
  ConsumerState<WordSearchScreen> createState() => _WordSearchScreenState();
}

class _WordSearchScreenState extends ConsumerState<WordSearchScreen> {
  /// One colour per word, in board order.
  ///
  /// Every one of these carries white text at better than 5:1, so the letters
  /// stay readable on the pill in either theme, and the eight hues stay apart
  /// from one another. They are deliberately deep rather than bright: a pale
  /// highlight with dark letters on it is the combination that disappears
  /// first on a phone held at arm's length in daylight.
  static const List<Color> _wordColours = [
    Color(0xFFBE185D), // berry
    Color(0xFF1D4ED8), // blue
    Color(0xFF047857), // green
    Color(0xFFC2410C), // orange
    Color(0xFF7C3AED), // violet
    Color(0xFF0E7490), // cyan
    Color(0xFFB91C1C), // crimson
    Color(0xFFA21CAF), // magenta
  ];

  static Color _colourFor(int index) =>
      _wordColours[index % _wordColours.length];

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(wordSearchNotifierProvider.notifier).initGame());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final state = ref.watch(wordSearchNotifierProvider);
    final notifier = ref.read(wordSearchNotifierProvider.notifier);

    ref.listen(wordSearchNotifierProvider, (previous, next) {
      if (next.isSolved && !(previous?.isSolved ?? false)) {
        HapticFeedbackUtil.victory();
        _showVictoryDialog(context, ref);
      }
    });

    return GameScaffold(
      title: l10n.wordSearchTitle.toUpperCase(),
      subtitle: l10n.wordSearchSubtitle,
      actions: [
        TangibleButton(
          color: colorScheme.surface,
          shadowColor: colorScheme.outline,
          onTap: () {
            HapticFeedbackUtil.mediumImpact();
            notifier.initGame();
          },
          padding: const EdgeInsets.all(12),
          child: Icon(Icons.refresh_rounded, size: 24, color: colorScheme.onSurface),
        ),
      ],
      body: state.board == null
          ? const Center(child: CircularProgressIndicator(color: DesignSystem.primary))
          : Padding(
              padding: const EdgeInsets.fromLTRB(
                DesignSystem.spaceMD,
                DesignSystem.spaceSM,
                DesignSystem.spaceMD,
                DesignSystem.spaceMD,
              ),
              child: Column(
                children: [
                  _buildWordPanel(state),
                  const SizedBox(height: DesignSystem.spaceMD),
                  // The board takes everything that is left rather than
                  // sitting in the middle of the screen with empty space
                  // above and below it.
                  Expanded(child: Center(child: _buildGrid(state, notifier))),
                ],
              ),
            ),
    );
  }

  // ---------------------------------------------------------------- the list

  Widget _buildWordPanel(WordSearchState state) {
    final colorScheme = Theme.of(context).colorScheme;
    final words = state.board!.words;
    final foundCount = words.where((w) => w.isFound).length;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(DesignSystem.spaceMD),
      decoration: BoxDecoration(
        // A wash of the ink colour rather than surfaceContainerHighest: this
        // ColorScheme never sets that role, so Material would supply its own
        // purple-tinted default and the panel would not match the app.
        color: colorScheme.onSurface.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(DesignSystem.radiusLG),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.5),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'WORDS TO FIND',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                  color: colorScheme.onSurface.withValues(alpha: 0.75),
                  fontSize: DesignSystem.fontSizeXS,
                ),
              ),
              // Where he has got to, not how well he did. There is no clock
              // and nothing to beat -- this only answers "how many left?".
              Text(
                '$foundCount of ${words.length}',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: foundCount == words.length
                      ? DesignSystem.successDeep
                      : colorScheme.onSurface.withValues(alpha: 0.75),
                  fontSize: DesignSystem.fontSizeXS,
                ),
              ),
            ],
          ),
          const SizedBox(height: DesignSystem.spaceSM),
          // Two to a row, every chip the same width, so the words line up in
          // columns instead of staggering about as a Wrap would leave them.
          //
          // Two rather than three: at three across, an eight-letter word has
          // only about 80 logical pixels of room and has to be set at around
          // 14pt, while the grid gains barely any height in exchange. Two
          // columns roughly halves the words' type size problem and costs
          // nothing worth having.
          LayoutBuilder(builder: (context, inner) {
            final int rows = (words.length + _columns - 1) ~/ _columns;
            final double fontSize = _chipFontSize(words, inner.maxWidth);
            return Column(
              children: [
                for (int row = 0; row < rows; row++)
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: row == rows - 1 ? 0 : DesignSystem.spaceXS,
                    ),
                    child: Row(
                      children: [
                        for (int col = 0; col < _columns; col++) ...[
                          if (col > 0) const SizedBox(width: DesignSystem.spaceXS),
                          Expanded(
                            child: row * _columns + col < words.length
                                ? _wordChip(
                                    words[row * _columns + col],
                                    row * _columns + col,
                                    fontSize,
                                  )
                                : const SizedBox.shrink(),
                          ),
                        ],
                      ],
                    ),
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }

  /// How many words sit side by side in the list.
  static const int _columns = 2;

  /// Distance from the edge of the board's outer box to the first cell:
  /// TangibleContainer's 1.5px border plus the 3px padding inside it.
  static const double _boardInset = 4.5;

  static const double _chipHPadding = DesignSystem.spaceXS;
  static const double _chipBorder = 1.5;

  /// One type size for every chip, chosen so the longest word in this board
  /// fits without being shrunk.
  ///
  /// Letting each chip shrink its own text independently -- which is what a
  /// bare FittedBox does -- sets LIBERTY small and MAHAL large in the same
  /// row, and the list stops looking like a list. Sizing them all to the
  /// longest word keeps the type even.
  ///
  /// 0.78 em per character is the widest the app's font runs: measured across
  /// the word list, M- and W-heavy words such as MACHU reach 0.79 while
  /// narrow ones like EIFFEL sit near 0.55. Erring high means the text is
  /// occasionally a shade smaller than it had to be, never clipped, and the
  /// FittedBox below still catches anything this estimate misses.
  static double _chipFontSize(List<WordSearchWord> words, double panelWidth) {
    if (words.isEmpty) return DesignSystem.fontSizeLG;
    final double chipWidth =
        (panelWidth - DesignSystem.spaceXS * (_columns - 1)) / _columns;
    final double textBudget = chipWidth - (_chipHPadding + _chipBorder) * 2;
    int longest = 0;
    for (final w in words) {
      if (w.word.length > longest) longest = w.word.length;
    }
    if (longest == 0) return DesignSystem.fontSizeLG;
    return (textBudget / (longest * 0.78)).clamp(14.0, DesignSystem.fontSizeLG);
  }

  Widget _wordChip(WordSearchWord word, int index, double fontSize) {
    final colorScheme = Theme.of(context).colorScheme;
    final bool isFound = word.isFound;
    final Color colour = _colourFor(index);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      padding: const EdgeInsets.symmetric(
        horizontal: _chipHPadding,
        vertical: DesignSystem.spaceXS,
      ),
      decoration: BoxDecoration(
        // Found: filled solid in the word's own colour. Not found: plain, so
        // the eye goes straight to what is still outstanding.
        color: isFound ? colour : Colors.transparent,
        borderRadius: BorderRadius.circular(DesignSystem.radiusSM),
        border: Border.all(
          color: isFound ? colour : colorScheme.outline.withValues(alpha: 0.6),
          width: _chipBorder,
        ),
      ),
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            word.word.toUpperCase(),
            maxLines: 1,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.5,
              color: isFound ? Colors.white : colorScheme.onSurface,
              // Struck through as well as filled, so the "done" signal does
              // not rest on seeing a colour.
              decoration: isFound ? TextDecoration.lineThrough : null,
              decorationColor: Colors.white,
              decorationThickness: 2.5,
            ),
          ),
        ),
      ),
    );
  }

  // --------------------------------------------------------------- the board

  Widget _buildGrid(WordSearchState state, WordSearchNotifier notifier) {
    final board = state.board!;
    final colorScheme = Theme.of(context).colorScheme;

    // Which cells belong to a word already found, and in which colour. Used
    // to turn those letters white so they stay legible on the pill.
    final Map<Point<int>, Color> foundCells = {};
    for (int i = 0; i < board.words.length; i++) {
      if (!board.words[i].isFound) continue;
      for (final p in board.words[i].positions) {
        foundCells[p] = _colourFor(i);
      }
    }
    final Set<Point<int>> selected = state.selection.toSet();

    return LayoutBuilder(builder: (context, constraints) {
      final double gridSize = min(constraints.maxWidth, constraints.maxHeight);
      // The lettered area starts _boardInset in from the edge of the outer
      // box (TangibleContainer draws a 1.5px border and we pad by 3), so the
      // cells are that much smaller and sit that much in. Both the pill
      // painting and the drag hit-test have to agree with it, or the
      // highlight drifts away from the letters and a finger near a cell
      // boundary picks the wrong one.
      final double cellSize = (gridSize - _boardInset * 2) / board.size;

      return SizedBox(
        width: gridSize,
        height: gridSize,
        child: GestureDetector(
          onPanStart: (details) {
            HapticFeedbackUtil.gameInteraction();
            _handlePanUpdate(details.localPosition, cellSize, board.size, notifier, true);
          },
          onPanUpdate: (details) =>
              _handlePanUpdate(details.localPosition, cellSize, board.size, notifier, false),
          onPanEnd: (_) {
            HapticFeedbackUtil.selectionClick();
            notifier.endSelection();
          },
          child: TangibleContainer(
            color: colorScheme.onSurface,
            shadowColor: colorScheme.onSurface.withValues(alpha: 0.7),
            radius: DesignSystem.radiusMD,
            depth: 4.0,
            padding: const EdgeInsets.all(3.0),
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(DesignSystem.radiusMD - 4),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(DesignSystem.radiusMD - 4),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    color: colorScheme.surface,
                    child: Stack(
                      children: [
                        _buildFoundLines(state, cellSize),
                        _buildSelectionLine(state, cellSize),
                        GridView.builder(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: board.size,
                          ),
                          itemCount: board.size * board.size,
                          itemBuilder: (context, index) {
                            final int x = index % board.size;
                            final int y = index ~/ board.size;
                            final Point<int> here = Point(x, y);
                            final bool onPill =
                                foundCells.containsKey(here) || selected.contains(here);
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.all(1.5),
                                child: FittedBox(
                                  child: Text(
                                    board.grid[y][x].toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                      // White on a filled pill, normal ink
                                      // everywhere else.
                                      color: onPill
                                          ? Colors.white
                                          : colorScheme.onSurface,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  void _handlePanUpdate(Offset localPos, double cellSize, int size, WordSearchNotifier notifier, bool isStart) {
    // localPos is measured from the outer box, the cells start _boardInset in.
    int x = ((localPos.dx - _boardInset) / cellSize).floor();
    int y = ((localPos.dy - _boardInset) / cellSize).floor();

    if (x >= 0 && x < size && y >= 0 && y < size) {
      if (isStart) {
        notifier.startSelection(x, y);
      } else {
        notifier.updateSelection(x, y);
      }
    }
  }

  Widget _buildFoundLines(WordSearchState state, double cellSize) {
    final words = state.board!.words;
    return Stack(
      children: [
        for (int i = 0; i < words.length; i++)
          if (words[i].isFound)
            _buildLine(words[i].positions, cellSize, _colourFor(i)),
      ],
    );
  }

  Widget _buildSelectionLine(WordSearchState state, double cellSize) {
    if (state.selection.isEmpty) return const SizedBox.shrink();
    return _buildLine(
      state.selection,
      cellSize,
      DesignSystem.primary.withValues(alpha: 0.75),
    );
  }

  Widget _buildLine(List<Point<int>> positions, double cellSize, Color color) {
    if (positions.isEmpty) return const SizedBox.shrink();

    final start = positions.first;
    final end = positions.last;

    return CustomPaint(
      painter: LinePainter(
        start: Offset((start.x + 0.5) * cellSize, (start.y + 0.5) * cellSize),
        end: Offset((end.x + 0.5) * cellSize, (end.y + 0.5) * cellSize),
        color: color,
        strokeWidth: cellSize * 0.86,
      ),
    );
  }

  void _showVictoryDialog(BuildContext context, WidgetRef ref) async {
    await ref.read(gameStreakNotifierProvider.notifier).completeGame('word_search');

    if (!context.mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => GameCompletionDialog(
        onHome: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
        onPlayAgain: () {
          ref.read(wordSearchNotifierProvider.notifier).initGame();
          Navigator.of(context).pop();
        },
        message: AppLocalizations.of(context)!.wordSearchMessage,
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  final Offset start;
  final Offset end;
  final Color color;
  final double strokeWidth;

  LinePainter({required this.start, required this.end, required this.color, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;
    canvas.drawLine(start, end, paint);
  }

  @override
  bool shouldRepaint(covariant LinePainter oldDelegate) =>
      oldDelegate.start != start || oldDelegate.end != end || oldDelegate.color != color;
}
