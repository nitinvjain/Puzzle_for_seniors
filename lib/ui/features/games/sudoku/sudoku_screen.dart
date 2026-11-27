import "package:puzzle/l10n/app_localizations.dart";
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'sudoku_provider.dart';
import 'sudoku_engine.dart';
import '../../../../../providers/picked_value_provider.dart';
import '../../../../../providers/user_providers.dart';
import '../../../../../utils/design_system.dart';
import '../../../../../utils/haptic_feedback.dart';
import '../../../../widgets/game_completion_dialog.dart';
import '../../../../widgets/tangible.dart';
import '../../../core/juice/game_scaffold.dart';

class SudokuScreen extends ConsumerStatefulWidget {
  const SudokuScreen({super.key});

  @override
  ConsumerState<SudokuScreen> createState() => _SudokuScreenState();
}

class _SudokuScreenState extends ConsumerState<SudokuScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final state = ref.watch(sudokuNotifierProvider);
    final notifier = ref.read(sudokuNotifierProvider.notifier);

    ref.listen(sudokuNotifierProvider, (previous, next) async {
      if (next.hasValue && next.value!.isSolved && !(previous?.value?.isSolved ?? false)) {
        HapticFeedbackUtil.victory();
        await ref.read(gameStreakNotifierProvider.notifier).completeGame('sudoku');
        if (!context.mounted) return;
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => GameCompletionDialog(
            title: l10n.wellDone.toUpperCase(),
            message: l10n.completed,
            onHome: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            onPlayAgain: () {
              ref.read(sudokuNotifierProvider.notifier).initGame();
              Navigator.of(context).pop();
            },
          ),
        );
      }
    });

    return GameScaffold(
      title: l10n.sudokuTitle.toUpperCase(),
      subtitle: l10n.sudokuSubtitle,
      actions: [
        TangibleButton(
          color: colorScheme.surface,
          shadowColor: colorScheme.outline,
          onTap: () {
            HapticFeedbackUtil.mediumImpact();
            notifier.initGame();
          },
          padding: const EdgeInsets.all(12),
          child: Icon(
            Icons.refresh_rounded,
            color: colorScheme.onSurface,
            size: 20,
          ),
        ),
      ],
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text(AppLocalizations.of(context)!.sudokuText((err).toString()))),
        data: (sudokuState) => LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                const Spacer(),
                _buildGrid(sudokuState, notifier, constraints.maxHeight * 0.5),
                const Spacer(),
                _buildNumberPad(sudokuState, notifier),
                const SizedBox(height: DesignSystem.spaceLG),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildGrid(SudokuState state, SudokuNotifier notifier, double maxHeight) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DesignSystem.spaceLG),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight),
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).colorScheme.onSurface, width: 2.0),
              borderRadius: BorderRadius.circular(DesignSystem.radiusSM),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(DesignSystem.radiusSM - 2),
              child: Column(
                children: List.generate(9, (r) {
                  return Expanded(
                    child: Row(
                      children: List.generate(9, (c) {
                        return Expanded(
                          child: SudokuCell(row: r, col: c),
                        );
                      }),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Touching a key on the pad.
  ///
  /// Both orders work, as they do in Cross Math: pick the value and then
  /// touch squares, or touch a square and then pick the value. [value] 0 is
  /// the eraser.
  void _tapPadKey(SudokuState state, SudokuNotifier notifier, int value) {
    HapticFeedbackUtil.lightImpact();
    final selR = state.selectedRow;
    final selC = state.selectedCol;
    ref.read(pickedValueProvider.notifier).toggle(value);
    final picked = ref.read(pickedValueProvider);
    // A square was already waiting, so fill it rather than make him touch
    // it a second time.
    if (picked != null && selR != null && selC != null) {
      _applyTo(state, notifier, selR, selC, value);
    }
  }

  /// Put [value] into the square at [r],[c]. 0 clears it.
  ///
  /// setNumber works on whatever square is selected and toggles, so the
  /// square is selected first and the eraser passes the digit already
  /// there, which is how the pad's backspace key has always cleared a cell.
  void _applyTo(SudokuState state, SudokuNotifier notifier, int r, int c, int value) {
    notifier.selectCell(r, c);
    if (value == 0) {
      final current = state.currentBoard[r][c];
      if (current != 0) notifier.setNumber(current);
      return;
    }
    notifier.setNumber(value);
  }

  /// The tile that follows the finger while a value is being carried.
  ///
  /// Lifted up and left so the value is not hidden under the hand carrying
  /// it, the same way Cross Math does it.
  static Widget _dragFeedback(int value) {
    return Transform.translate(
      offset: const Offset(-32, -52),
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: DesignSystem.primary,
            borderRadius: BorderRadius.circular(DesignSystem.radiusSM),
            border: Border.all(color: Colors.white, width: 2.0),
          ),
          child: Center(
            child: value == 0
                ? const Icon(Icons.backspace_rounded,
                    size: 28, color: Colors.white)
                : Text(
                    '$value',
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildNumberPad(SudokuState state, SudokuNotifier notifier) {
    // Which value is being carried, so the pad can show it. Without
    // this there is nothing on screen to say what a touch will put down,
    // and a technique you cannot see the state of is not one you can
    // learn.
    final picked = ref.watch(pickedValueProvider);
    final counts = {for (int i = 1; i <= 9; i++) i: 0};
    for (var row in state.currentBoard) {
      for (var val in row) {
        if (val != 0) counts[val] = (counts[val] ?? 0) + 1;
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DesignSystem.spaceLG),
      child: Wrap(
        spacing: DesignSystem.spaceSM,
        runSpacing: DesignSystem.spaceSM,
        alignment: WrapAlignment.center,
        children: [
          ...List.generate(9, (i) {
            final num = i + 1;
            final isCompleted = (counts[num] ?? 0) >= 9;

            return Draggable<int>(
              data: num,
              dragAnchorStrategy: pointerDragAnchorStrategy,
              feedback: _dragFeedback(num),
              onDragStarted: () {
                HapticFeedbackUtil.selectionClick();
                ref.read(pickedValueProvider.notifier).pick(num);
              },
              child: SizedBox(
              width: 44,
              height: 44,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  TangibleButton(
                    color: picked == num
                        ? DesignSystem.primary
                        : (isCompleted
                            ? DesignSystem.success
                            : Theme.of(context).colorScheme.surface),
                    shadowColor: isCompleted ? const Color(0xFF047857) : Theme.of(context).colorScheme.outline,
                    onTap: () => _tapPadKey(state, notifier, num),
                    padding: EdgeInsets.zero,
                    child: Center(
                      child: FittedBox(
                        child: Text(
                          num.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                            color: (isCompleted || picked == num)
                                ? Colors.white
                                : DesignSystem.primary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (counts[num]! > 0)
                    Positioned(
                      right: -2,
                      top: -2,
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: isCompleted ? DesignSystem.success : DesignSystem.primary,
                          shape: BoxShape.circle,
                          border: Border.all(color: Theme.of(context).colorScheme.surface, width: 1.5),
                        ),
                        constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                        child: Text(
                          (9 - counts[num]!).clamp(0, 9).toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              ),
            );
          }),
          Draggable<int>(
            data: 0,
            dragAnchorStrategy: pointerDragAnchorStrategy,
            feedback: _dragFeedback(0),
            onDragStarted: () {
              HapticFeedbackUtil.selectionClick();
              ref.read(pickedValueProvider.notifier).pick(0);
            },
            child: SizedBox(
            width: 44,
            height: 44,
            child: TangibleButton(
              color: picked == 0
                  ? DesignSystem.primary
                  : Theme.of(context).colorScheme.surface,
              shadowColor: Theme.of(context).colorScheme.outline,
              onTap: () => _tapPadKey(state, notifier, 0),
              padding: EdgeInsets.zero,
              child: Center(
                child: Icon(
                  Icons.backspace_rounded,
                  size: 16,
                  color: picked == 0
                      ? Colors.white
                      : Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.7),
                ),
              ),
            ),
          ),
          ),
        ],
      ),
    );
  }
}

class SudokuCell extends ConsumerWidget {
  final int row;
  final int col;

  const SudokuCell({
    super.key,
    required this.row,
    required this.col,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(sudokuNotifierProvider.notifier);

    // Selectively watch only the data this cell needs
    final value = ref.watch(sudokuNotifierProvider.select((s) => s.value?.currentBoard[row][col] ?? 0));
    final isInitial = ref.watch(sudokuNotifierProvider.select((s) => s.value?.initialBoard[row][col] != 0));
    final isSelected = ref.watch(sudokuNotifierProvider.select((s) => s.value?.selectedRow == row && s.value?.selectedCol == col));

    final selR = ref.watch(sudokuNotifierProvider.select((s) => s.value?.selectedRow));
    final selC = ref.watch(sudokuNotifierProvider.select((s) => s.value?.selectedCol));
    final selectedValue = ref.watch(sudokuNotifierProvider.select((s) =>
        (s.value?.selectedRow != null && s.value?.selectedCol != null)
            ? s.value!.currentBoard[s.value!.selectedRow!][s.value!.selectedCol!]
            : 0));

    // Highlights
    final bool isSameDigit = selectedValue != 0 && value == selectedValue;
    final bool isRelatedArea = selR == row ||
        selC == col ||
        (selR != null && selC != null && (row ~/ 3 == selR ~/ 3 && col ~/ 3 == selC ~/ 3));

    // Conflict detection
    final board = ref.read(sudokuNotifierProvider).value?.currentBoard;
    bool hasConflict = false;
    if (value != 0 && !isInitial && board != null) {
      hasConflict = !SudokuEngine.isValid(board, row, col, value);
    }

    // Thick borders for 3x3 boxes
    final bool borderRight = (col + 1) % 3 == 0 && col < 8;
    final bool borderBottom = (row + 1) % 3 == 0 && row < 8;

    // Cross Math's technique, here too. If a value has been picked up, a
    // touch puts it down in this square; if nothing has, the touch selects
    // the square and the value comes second, which is how it always worked.
    void place(int picked) {
      if (isInitial) return;
      notifier.selectCell(row, col);
      if (picked == 0) {
        // setNumber toggles, so clearing means passing back what is there.
        if (value != 0) notifier.setNumber(value);
        return;
      }
      notifier.setNumber(picked);
    }

    return DragTarget<int>(
      onWillAcceptWithDetails: (_) => !isInitial,
      onAcceptWithDetails: (details) => place(details.data),
      builder: (context, candidate, _) => GestureDetector(
      onTap: () {
        HapticFeedbackUtil.selectionClick();
        final picked = ref.read(pickedValueProvider);
        if (picked != null && !isInitial) {
          place(picked);
          return;
        }
        notifier.selectCell(row, col);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color: isSelected
              ? DesignSystem.primary.withValues(alpha: 0.2)
              : isSameDigit
                  ? DesignSystem.accentAmber.withValues(alpha: 0.2)
                  : isRelatedArea
                      ? Theme.of(context).colorScheme.outline.withValues(alpha: 0.5).withValues(alpha: 0.3)
                      : Theme.of(context).colorScheme.surface,
          border: Border(
            right: BorderSide(color: Theme.of(context).colorScheme.onSurface, width: borderRight ? 2.0 : 0.5),
            bottom: BorderSide(color: Theme.of(context).colorScheme.onSurface, width: borderBottom ? 2.0 : 0.5),
          ),
        ),
        child: Center(
          child: FittedBox(
            child: Text(
              value == 0 ? '' : value.toString(),
              style: TextStyle(
                fontSize: 20,
                fontWeight: isInitial ? FontWeight.w900 : FontWeight.w700,
                color: hasConflict
                    ? DesignSystem.error
                    : isSelected
                        ? DesignSystem.primary
                        : isSameDigit
                            ? DesignSystem.accentAmber
                            : isInitial
                                ? Theme.of(context).colorScheme.onSurface
                                : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          ),
        ),
      ),
      ),
    );
  }
}
