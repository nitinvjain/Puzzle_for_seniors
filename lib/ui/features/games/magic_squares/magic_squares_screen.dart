import 'package:puzzle/l10n/app_localizations.dart';
import 'package:puzzle/utils/l10n_game_helpers.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../providers/picked_value_provider.dart';
import '../../../../../providers/user_providers.dart';
import '../../../../../utils/haptic_feedback.dart';
import '../../../core/juice/game_scaffold.dart';
import '../../../../widgets/game_completion_dialog.dart';
import '../../../../widgets/grid_drop_area.dart';
import '../../../../widgets/tangible.dart';
import '../../../../utils/design_system.dart';
import 'magic_squares_provider.dart';

class MagicSquaresScreen extends ConsumerStatefulWidget {
  const MagicSquaresScreen({super.key});

  @override
  ConsumerState<MagicSquaresScreen> createState() => _MagicSquaresScreenState();
}

class _MagicSquaresScreenState extends ConsumerState<MagicSquaresScreen> {
  /// The square itself, on its own light blue mat inside a drawn edge.
  ///
  /// NJ asked for the magic square to be marked off clearly, and the reason
  /// is that nothing on this screen said where the puzzle stopped and the
  /// controls began -- nine buttons above, ten buttons below, all the same
  /// colour. The mat answers that before anything is read.
  ///
  /// The same two blues and the same outline as Word Search, deliberately:
  /// measured there (ink 15.7:1 on the mat, the outline 3.8:1 against it),
  /// and a second shade of blue invented here would only make the app look
  /// like two apps.
  /// Measured by the drop area to work out which cell a drop lands in.
  final GlobalKey _gridKey = GlobalKey();

  static const Color _skyBoard = Color(0xFFE4F2FD);
  static const Color _skyGiven = Color(0xFFCFE6F8);
  static const Color _skyLine = Color(0xFF4A7FA8);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(magicSquaresNotifierProvider.notifier).initGame();
    });
  }

  void _showCompletionDialog(bool isVictory) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => GameCompletionDialog(
        title: isVictory ? l10n.winPerfect : l10n.gameOver,
        message: isVictory 
            ? l10n.snackbarAlignedPerfectly 
            : l10n.snackbarIncorrectSum,
        isVictory: isVictory,
        onHome: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
        onPlayAgain: () {
          Navigator.of(context).pop();
          ref.read(magicSquaresNotifierProvider.notifier).initGame();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(magicSquaresNotifierProvider);
    final notifier = ref.read(magicSquaresNotifierProvider.notifier);

    ref.listen(magicSquaresNotifierProvider, (previous, next) async {
      if (next.isGameOver && !(previous?.isGameOver ?? false)) {
        if (next.isGameWon) {
          HapticFeedbackUtil.victory();
          await ref.read(gameStreakNotifierProvider.notifier).completeGame('magic_squares');
        } else {
          HapticFeedbackUtil.vibrate();
        }
        if (!context.mounted) return;
        _showCompletionDialog(next.isGameWon);
      }
    });

    if (state.isLoading) {
      return GameScaffold(
        title: l10n.magicSquaresTitle.toUpperCase(),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return GameScaffold(
      title: L10nGameHelpers.getGameTitle(context, 'magic_squares'),
      subtitle: l10n.magicSquaresSubtitle(state.targetSum),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Wrapping the whole body, not just the square, so a tile let go
          // a little off the edge still finds its cell.
          return GridDropArea(
            rows: 3,
            columns: 3,
            gridKey: _gridKey,
            canAccept: (r, c) => !state.fixed[r][c],
            onPlace: (r, c, value) => _applyTo(notifier, r, c, value),
            builder: (context, hoverR, hoverC) => Column(
            children: [
              const Spacer(),
              // The square was capped at half the height because the old
              // pad needed the other half. Ten small keys need far less, so
              // the square takes the difference.
              _buildGrid(state, notifier, constraints.maxHeight * 0.58,
                  hoverR, hoverC),
              const Spacer(),
              _buildNumpad(state, notifier),
              const SizedBox(height: DesignSystem.spaceLG),
            ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildGrid(MagicSquaresState state, MagicSquaresNotifier notifier,
      double maxHeight, int? hoverR, int? hoverC) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: DesignSystem.spaceLG),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight),
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
              color: _skyBoard,
              borderRadius: BorderRadius.circular(DesignSystem.radiusLG),
              border: Border.all(color: _skyLine, width: 3.0),
            ),
            padding: const EdgeInsets.all(DesignSystem.spaceXS),
            child: Column(
            key: _gridKey,
            children: List.generate(3, (r) {
              return Expanded(
                child: Row(
                  children: List.generate(3, (c) {
                    final isSelected = state.selectedRow == r && state.selectedCol == c;
                    final isFixed = state.fixed[r][c];
                    final value = state.grid[r][c];
                    
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(DesignSystem.spaceSM),
                        child: Builder(
                          builder: (context) {
                            final lit = isSelected ||
                                (hoverR == r && hoverC == c);
                            return TangibleButton(
                          onTap: () => _tapCell(notifier, r, c),
                          color: lit
                              ? DesignSystem.accentAmber.withValues(alpha: 0.5)
                              : (isFixed ? _skyGiven : Colors.white),
                          shadowColor: lit
                              ? DesignSystem.primaryShadow
                              : Theme.of(context).colorScheme.outline,
                          depth: lit ? 2.0 : 4.0,
                          child: Center(
                            child: FittedBox(
                              child: Text(
                                value?.toString() ?? '',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w900,
                                  color: isFixed ? Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7) : DesignSystem.primary,
                                ),
                              ),
                            ),
                          ),
                        );
                          },
                        ),
                      ),
                    );
                  }),
                ),
              );
            }),
          ),
          ),
        ),
      ),
    );
  }

  /// The numbers to choose from.
  ///
  /// Rebuilt small. It was three rows of stretched buttons plus a
  /// full-width red bar -- more than half the screen for ten controls, and
  /// it dwarfed the square it served. Now ten fixed keys that wrap, which
  /// leaves the square the room it should have had.
  ///
  /// Each key is pick-and-place, the same as Cross Math and the sudokus:
  /// choose a number and touch the cell it goes in, or drag it there. The
  /// older order -- touch the cell, then the number -- still works.
  Widget _buildNumpad(MagicSquaresState state, MagicSquaresNotifier notifier) {
    final picked = ref.watch(pickedValueProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DesignSystem.spaceMD),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: DesignSystem.spaceSM,
        runSpacing: DesignSystem.spaceSM,
        children: [
          for (var v = 1; v <= 9; v++) _buildNumButton(v, notifier, picked),
          _buildNumButton(0, notifier, picked),
        ],
      ),
    );
  }

  /// One key. [val] 0 is the eraser, which empties the chosen cell.
  Widget _buildNumButton(int val, MagicSquaresNotifier notifier, int? picked) {
    final chosen = picked == val;
    final key = SizedBox(
      width: _keySize,
      height: _keySize,
      child: TangibleButton(
        onTap: () => _tapPadKey(notifier, val),
        color: chosen
            ? DesignSystem.primary
            : (val == 0
                ? DesignSystem.error
                : Theme.of(context).colorScheme.surface),
        shadowColor: Theme.of(context).colorScheme.outline,
        padding: EdgeInsets.zero,
        child: Center(
          child: val == 0
              ? const Icon(Icons.backspace_rounded,
                  size: 22, color: Colors.white)
              : Text(
                  '$val',
                  style: TextStyle(
                    color: chosen
                        ? Colors.white
                        : Theme.of(context).colorScheme.onSurface,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                ),
        ),
      ),
    );

    return Draggable<int>(
      data: val,
      dragAnchorStrategy: pointerDragAnchorStrategy,
      feedback: _dragFeedback(val),
      onDragStarted: () {
        HapticFeedbackUtil.selectionClick();
        ref.read(pickedValueProvider.notifier).pick(val);
      },
      childWhenDragging: Opacity(opacity: 0.35, child: key),
      child: key,
    );
  }

  /// Small enough that ten of them do not crowd out the square, large
  /// enough to stay a comfortable target for an older hand.
  static const double _keySize = 54.0;

  void _tapPadKey(MagicSquaresNotifier notifier, int val) {
    HapticFeedbackUtil.lightImpact();
    final state = ref.read(magicSquaresNotifierProvider);
    final r = state.selectedRow;
    final c = state.selectedCol;
    ref.read(pickedValueProvider.notifier).toggle(val);
    // A cell was already waiting: fill it, rather than ask for a second
    // touch on something he has already chosen.
    if (ref.read(pickedValueProvider) != null && r != null && c != null) {
      _applyTo(notifier, r, c, val);
    }
  }

  void _tapCell(MagicSquaresNotifier notifier, int r, int c) {
    final picked = ref.read(pickedValueProvider);
    if (picked != null) {
      _applyTo(notifier, r, c, picked);
      return;
    }
    HapticFeedbackUtil.selectionClick();
    notifier.selectCell(r, c);
  }

  /// Put [val] in the cell at [r],[c]; 0 empties it.
  ///
  /// Both notifier methods act on whichever cell is selected, so the cell is
  /// selected first -- which also means a fixed cell is refused by
  /// selectCell and nothing can be written over the numbers given.
  void _applyTo(MagicSquaresNotifier notifier, int r, int c, int val) {
    notifier.selectCell(r, c);
    if (val == 0) {
      notifier.onClear();
    } else {
      notifier.onNumberPressed(val);
    }
  }

  /// The tile that follows the finger, lifted clear of the hand carrying it.
  static Widget _dragFeedback(int val) {
    return Transform.translate(
      offset: const Offset(-32, -52),
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: val == 0 ? DesignSystem.error : DesignSystem.primary,
            borderRadius: BorderRadius.circular(DesignSystem.radiusSM),
            border: Border.all(color: Colors.white, width: 2.0),
          ),
          child: Center(
            child: val == 0
                ? const Icon(Icons.backspace_rounded,
                    size: 28, color: Colors.white)
                : Text(
                    '$val',
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
}
