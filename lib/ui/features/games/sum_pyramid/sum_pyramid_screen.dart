import 'dart:math' as math;

import 'package:puzzle/config/senior_mode.dart';
import 'package:puzzle/l10n/app_localizations.dart';
import 'package:puzzle/utils/l10n_game_helpers.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../utils/design_system.dart';
import '../../../../utils/haptic_feedback.dart';
import '../../../../widgets/game_completion_dialog.dart';
import '../../../../widgets/tangible.dart';
import '../../../core/juice/game_scaffold.dart';
import 'sum_pyramid_provider.dart';

class SumPyramidScreen extends ConsumerStatefulWidget {
  const SumPyramidScreen({super.key});

  @override
  ConsumerState<SumPyramidScreen> createState() => _SumPyramidScreenState();
}

class _SumPyramidScreenState extends ConsumerState<SumPyramidScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(sumPyramidNotifierProvider.notifier).initGame();
    });
  }

  void _handleKeypadTap(String val) {
    HapticFeedbackUtil.lightImpact();
    final notifier = ref.read(sumPyramidNotifierProvider.notifier);
    if (val == '⌫') {
      notifier.deleteDigit();
    } else if (val == 'C') {
      notifier.clearBlock();
    } else if (val == '✓') {
      final success = notifier.submitAnswers();
      if (success) {
        HapticFeedbackUtil.victory();
      } else {
        HapticFeedbackUtil.error();
      }
    } else {
      notifier.enterDigit(val);
    }
  }

  Widget _buildBlock(int index, double blockSize, ColorScheme colorScheme, SumPyramidState state) {
    final level = state.currentLevel!;
    final isHidden = level.isHidden[index];
    final isSelected = state.selectedBlockIndex == index;
    final isWrong = state.wrongBlocks.contains(index);

    String text = '';
    if (isHidden) {
      text = state.userValues[index];
    } else {
      text = '${level.correctValues[index]}';
    }

    Color blockColor;
    Color shadowColor;
    double depth;
    TextStyle textStyle;

    if (isHidden) {
      if (isSelected) {
        blockColor = colorScheme.primary;
        shadowColor = colorScheme.primary.withValues(alpha: 0.5);
        depth = 2.0;
        textStyle = TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: blockSize * 0.35,
          color: Colors.white,
        );
      } else if (isWrong) {
        blockColor = colorScheme.error.withValues(alpha: 0.1);
        shadowColor = colorScheme.error;
        depth = 4.0;
        textStyle = TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: blockSize * 0.35,
          color: colorScheme.error,
        );
      } else {
        blockColor = colorScheme.surface;
        shadowColor = colorScheme.outline;
        depth = 5.0;
        textStyle = TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: blockSize * 0.35,
          color: text.isEmpty ? colorScheme.onSurface.withValues(alpha: 0.3) : colorScheme.onSurface,
        );
      }
    } else {
      // Fixed/permanent block
      blockColor = colorScheme.outline.withValues(alpha: 0.15);
      shadowColor = colorScheme.outline.withValues(alpha: 0.3);
      depth = 0.0; // flat
      textStyle = TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: blockSize * 0.32,
        color: colorScheme.onSurface.withValues(alpha: 0.7),
      );
    }

    return Container(
      margin: const EdgeInsets.all(DesignSystem.spaceXS),
      width: blockSize,
      height: blockSize,
      // The stock blocks relied on a soft drop shadow alone, which does not
      // separate them clearly enough; an explicit outline does.
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(DesignSystem.radiusXS),
        border: Border.all(
          color: colorScheme.onSurface.withValues(alpha: 0.45),
          width: 2.0,
        ),
      ),
      child: TangibleButton(
        depth: depth,
        color: blockColor,
        shadowColor: shadowColor,
        radius: DesignSystem.radiusXS,
        padding: EdgeInsets.zero,
        onTap: isHidden
            ? () {
                HapticFeedbackUtil.selectionClick();
                ref.read(sumPyramidNotifierProvider.notifier).selectBlock(index);
              }
            : null,
        child: Center(
          child: Text(
            text.isEmpty ? '?' : text,
            style: textStyle,
          ),
        ),
      ),
    );
  }

  /// How tall a gap between two tiers is, as a fraction of a block.
  ///
  /// Slightly deeper than the single arrow needed, because the two slanted
  /// ones have to reach outwards as well as up and a squat pair would read as
  /// a flat V rather than the sides of a pyramid. The pyramid sits in a
  /// scroll view, so the extra depth costs nothing it cannot absorb.
  static const double _arrowTierFactor = 0.36;

  /// Half the angle at the top of the triangle the two arrows describe.
  ///
  /// NJ asked for the two sides of an acute isosceles triangle, and for an
  /// isosceles triangle that is a single condition: with an apex of A the
  /// base angles are each (180 - A) / 2, so every angle is under 90 exactly
  /// when the apex is. At 80 degrees the base angles are 50 and the triangle
  /// is comfortably acute, with the feet still far enough apart to sit over
  /// the two blocks they point away from.
  static const double _apexHalfAngleRadians = 40.0 * math.pi / 180.0;

  /// The gap between two tiers of the pyramid: under each block of the upper
  /// tier, two arrows slanting up and inwards from the pair below it, so the
  /// rule of the game -- this one is those two added together -- is drawn
  /// rather than explained. [count] is the number of blocks in the upper
  /// tier.
  ///
  /// It was one vertical arrow, which said "up" without saying what fed what.
  Widget _buildArrowTier(int count, double blockSize, ColorScheme colorScheme) {
    final pitch = blockSize + DesignSystem.spaceXS * 2;
    final height = blockSize * _arrowTierFactor;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (_) => SizedBox(
          width: pitch,
          height: height,
          child: CustomPaint(
            painter: _FeedArrowsPainter(
              // Solid, where it used to be the primary colour at 75% alpha.
              // That blend measured 2.88:1 against the board, under the 3:1
              // a piece of UI line work needs; at full strength it is 4.3:1.
              color: colorScheme.primary,
              stroke: (blockSize * 0.055).clamp(2.0, 5.0),
              halfBase: height * math.tan(_apexHalfAngleRadians),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildKeypadButton(String label, ColorScheme colorScheme, {double widthFactor = 1.0}) {
    Color? color = colorScheme.surface;
    Color? shadowColor = colorScheme.outline;
    TextStyle style = TextStyle(
      fontWeight: FontWeight.w900,
      fontSize: 20,
      color: colorScheme.onSurface,
    );

    if (label == '✓') {
      color = DesignSystem.accentEmerald;
      shadowColor = DesignSystem.accentEmerald.withValues(alpha: 0.7);
      style = const TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: 20,
        color: Colors.white,
      );
    } else if (label == '⌫' || label == 'C') {
      color = colorScheme.outline.withValues(alpha: 0.5);
      shadowColor = colorScheme.outline;
      style = TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: 16,
        color: colorScheme.onSurface,
      );
    }

    return Expanded(
      flex: (widthFactor * 10).round(),
      child: Padding(
        padding: const EdgeInsets.all(DesignSystem.spaceXS),
        child: TangibleButton(
          depth: 4.0,
          color: color,
          shadowColor: shadowColor,
          radius: DesignSystem.radiusXS,
          padding: EdgeInsets.zero,
          onTap: () => _handleKeypadTap(label),
          child: Center(
            child: Text(
              label,
              style: style,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(sumPyramidNotifierProvider);
    final colorScheme = Theme.of(context).colorScheme;

    ref.listen(sumPyramidNotifierProvider, (previous, next) {
      if (next.isGameOver && !(previous?.isGameOver ?? false)) {
        HapticFeedbackUtil.victory();
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => GameCompletionDialog(
            title: L10nGameHelpers.getGameTitle(context, 'sum_pyramid'),
            message: AppLocalizations.of(context)!.sumPyramidMessage((next.score).toString()),
            onHome: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            onPlayAgain: () {
              ref.read(sumPyramidNotifierProvider.notifier).reset();
              Navigator.of(context).pop();
            },
          ),
        );
      }
    });

    if (state.isLoading || state.currentLevel == null) {
      return GameScaffold(
        title: L10nGameHelpers.getGameTitle(context, 'sum_pyramid'),
        subtitle: L10nGameHelpers.getGameTitle(context, 'sum_pyramid'),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return GameScaffold(
      title: L10nGameHelpers.getGameTitle(context, 'sum_pyramid'),
      subtitle: L10nGameHelpers.getGameTitle(context, 'sum_pyramid'),
      onReset: () {
        HapticFeedbackUtil.mediumImpact();
        ref.read(sumPyramidNotifierProvider.notifier).reset();
      },
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isSmallScreen = constraints.maxHeight < 550;

          // Compute size of blocks in the pyramid
          // The base has 4 blocks. Width of 4 blocks + margins should fit within constraints width
          final double availableWidth = constraints.maxWidth - (DesignSystem.spaceMD * 2);
          final double maxBlockSize = SeniorMode.enabled
              ? (availableWidth / 4.6).clamp(SeniorMode.minGridCell, 104.0)
              : (availableWidth / 5.2).clamp(42.0, 75.0);

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: DesignSystem.spaceMD, vertical: DesignSystem.spaceSM),
            child: Column(
              children: [
                // Top status bar. The clock half is hidden separately by
                // SeniorMode.disableTimers; the row itself only disappears when
                // scores are off too.
                if (!SeniorMode.disableScoring)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TangibleContainer(
                        depth: 4.0,
                        padding: const EdgeInsets.symmetric(
                          vertical: DesignSystem.spaceSM,
                          horizontal: DesignSystem.spaceMD,
                        ),
                        color: colorScheme.surface,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.stars_rounded, color: DesignSystem.accentAmber, size: 20),
                            const SizedBox(width: DesignSystem.spaceXS),
                            SeniorMode.disableScoring ? const SizedBox.shrink() : Text(
                              'SCORE: ${state.score}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 13,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: DesignSystem.spaceMD),
                    SeniorMode.disableTimers ? const SizedBox.shrink() : Expanded(
                      child: TangibleContainer(
                        depth: 4.0,
                        padding: const EdgeInsets.symmetric(
                          vertical: DesignSystem.spaceSM,
                          horizontal: DesignSystem.spaceMD,
                        ),
                        color: state.timeLeft <= 10
                            ? colorScheme.error.withValues(alpha: 0.1)
                            : colorScheme.surface,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.timer_rounded,
                              color: state.timeLeft <= 10 ? colorScheme.error : colorScheme.primary,
                              size: 20,
                            ),
                            const SizedBox(width: DesignSystem.spaceXS),
                            Text(
                              '${state.timeLeft}s',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 13,
                                color: state.timeLeft <= 10 ? colorScheme.error : null,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: isSmallScreen ? DesignSystem.spaceSM : DesignSystem.spaceMD),

                // Pyramid Area
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Row 3 (Apex)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildBlock(9, maxBlockSize, colorScheme, state),
                            ],
                          ),
                          _buildArrowTier(1, maxBlockSize, colorScheme),
                          // Row 2
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildBlock(7, maxBlockSize, colorScheme, state),
                              _buildBlock(8, maxBlockSize, colorScheme, state),
                            ],
                          ),
                          _buildArrowTier(2, maxBlockSize, colorScheme),
                          // Row 1
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildBlock(4, maxBlockSize, colorScheme, state),
                              _buildBlock(5, maxBlockSize, colorScheme, state),
                              _buildBlock(6, maxBlockSize, colorScheme, state),
                            ],
                          ),
                          _buildArrowTier(3, maxBlockSize, colorScheme),
                          // Row 0 (Base)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildBlock(0, maxBlockSize, colorScheme, state),
                              _buildBlock(1, maxBlockSize, colorScheme, state),
                              _buildBlock(2, maxBlockSize, colorScheme, state),
                              _buildBlock(3, maxBlockSize, colorScheme, state),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: isSmallScreen ? DesignSystem.spaceSM : DesignSystem.spaceMD),

                // Numeric Keypad
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 450),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Keypad row 1: 1, 2, 3, C
                      SizedBox(
                        height: 52,
                        child: Row(
                          children: [
                            _buildKeypadButton('1', colorScheme),
                            _buildKeypadButton('2', colorScheme),
                            _buildKeypadButton('3', colorScheme),
                            _buildKeypadButton('C', colorScheme),
                          ],
                        ),
                      ),
                      // Keypad row 2: 4, 5, 6, ⌫
                      SizedBox(
                        height: 52,
                        child: Row(
                          children: [
                            _buildKeypadButton('4', colorScheme),
                            _buildKeypadButton('5', colorScheme),
                            _buildKeypadButton('6', colorScheme),
                            _buildKeypadButton('⌫', colorScheme),
                          ],
                        ),
                      ),
                      // Keypad row 3: 7, 8, 9, ✓
                      SizedBox(
                        height: 52,
                        child: Row(
                          children: [
                            _buildKeypadButton('7', colorScheme),
                            _buildKeypadButton('8', colorScheme),
                            _buildKeypadButton('9', colorScheme),
                            _buildKeypadButton('✓', colorScheme),
                          ],
                        ),
                      ),
                      // Keypad row 4: 0
                      SizedBox(
                        height: 52,
                        child: Row(
                          children: [
                            _buildKeypadButton('0', colorScheme, widthFactor: 3.0),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: DesignSystem.spaceXS),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// The two arrows in one gap of the pyramid.
///
/// Drawn rather than assembled from Icon widgets because the geometry has to
/// be exact: the two strokes are the equal sides of one isosceles triangle
/// whose apex sits under the block they point at, and a pair of rotated
/// arrow glyphs would only approximate that.
///
/// The canvas is one pitch wide, so its left and right edges fall on the
/// centres of the two blocks below. The feet sit [halfBase] either side of
/// the middle, which is inside those edges -- the arrows start over the inner
/// part of each block and lean in, rather than starting at its centre.
class _FeedArrowsPainter extends CustomPainter {
  final Color color;
  final double stroke;
  final double halfBase;

  const _FeedArrowsPainter({
    required this.color,
    required this.stroke,
    required this.halfBase,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final line = Paint()
      ..color = color
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final head = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final centre = size.width / 2;
    // The two tips stop just short of the apex rather than meeting at it, so
    // the heads sit shoulder to shoulder instead of overlapping into a blob.
    final apexGap = stroke * 1.1;

    for (final side in const [-1.0, 1.0]) {
      final foot = Offset(centre + side * halfBase, size.height);
      final tip = Offset(centre + side * apexGap, 0);
      canvas.drawLine(foot, tip, line);
      _drawHead(canvas, head, foot, tip);
    }
  }

  void _drawHead(Canvas canvas, Paint paint, Offset from, Offset tip) {
    final along = tip - from;
    final length = along.distance;
    if (length < 1.0) return;
    final direction = along / length;
    final across = Offset(-direction.dy, direction.dx);
    final back = tip - direction * (stroke * 2.6);
    final wing = across * (stroke * 1.5);
    canvas.drawPath(
      Path()
        ..moveTo(tip.dx, tip.dy)
        ..lineTo(back.dx + wing.dx, back.dy + wing.dy)
        ..lineTo(back.dx - wing.dx, back.dy - wing.dy)
        ..close(),
      paint,
    );
  }

  @override
  bool shouldRepaint(_FeedArrowsPainter old) =>
      old.color != color || old.stroke != stroke || old.halfBase != halfBase;
}
