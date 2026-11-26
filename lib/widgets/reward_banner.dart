import 'package:flutter/material.dart';

import '../config/rewards.dart';
import '../utils/design_system.dart';

/// The reward shown when a game is finished.
///
/// Sits in the completion dialog between the heading and the buttons. A gold
/// star that grows into place, a count of games finished underneath, and on a
/// milestone a line saying what he has reached.
///
/// Colours: the gold is [DesignSystem.accentAmber] for the star itself, which
/// is drawn large and needs no text on it, while anything carrying words uses
/// a deep amber dark enough to read against. White or pale text on bright gold
/// is the most common way a "celebration" panel ends up illegible.
class RewardBanner extends StatefulWidget {
  final RewardSnapshot snapshot;

  const RewardBanner({super.key, required this.snapshot});

  @override
  State<RewardBanner> createState() => _RewardBannerState();
}

class _RewardBannerState extends State<RewardBanner>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _pop;

  /// Deep enough to carry white text at about 5.9:1.
  static const Color _deepAmber = Color(0xFF92400E);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 520),
    );
    // Overshoot then settle: the star arrives rather than simply being there,
    // which is the whole point of it.
    _pop = CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final snap = widget.snapshot;
    final today = Rewards.todayLine(snap.gamesToday);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: DesignSystem.spaceMD,
        vertical: DesignSystem.spaceMD,
      ),
      decoration: BoxDecoration(
        color: DesignSystem.accentAmber.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(DesignSystem.radiusMD),
        border: Border.all(
          color: DesignSystem.accentAmber.withValues(alpha: 0.55),
          width: 1.5,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // One star, not a row of them.
          //
          // The row drew one per game finished, capped at five, which meant
          // that from his fifth game onward every completion screen showed an
          // identical five gold stars. A thing that never changes stops being
          // a reward and becomes wallpaper. One star, arriving each time, is
          // the emblem; the numbers underneath carry what actually changed.
          ScaleTransition(
            scale: _pop,
            child: const Icon(
              Icons.star_rounded,
              color: DesignSystem.accentAmber,
              size: 52,
            ),
          ),
          const SizedBox(height: DesignSystem.spaceSM),
          // The loud line: what he just earned.
          if (snap.pointsEarned > 0)
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                Rewards.earnedLine(snap.pointsEarned),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Geist',
                  fontSize: DesignSystem.fontSizeLG,
                  fontWeight: FontWeight.w900,
                  color: _deepAmber,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          const SizedBox(height: 2),
          // Both running totals on one quiet line.
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              Rewards.summaryLine(snap.totalPoints, snap.totalGames),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Geist',
                fontSize: DesignSystem.fontSizeSM,
                fontWeight: FontWeight.w700,
                color: colorScheme.onSurface.withValues(alpha: 0.8),
              ),
            ),
          ),
          if (today != null) ...[
            const SizedBox(height: 2),
            Text(
              today,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Geist',
                fontSize: DesignSystem.fontSizeSM,
                fontWeight: FontWeight.w700,
                color: colorScheme.onSurface.withValues(alpha: 0.65),
              ),
            ),
          ],
          if (snap.milestone != null) ...[
            const SizedBox(height: DesignSystem.spaceSM),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: DesignSystem.spaceSM,
                vertical: DesignSystem.spaceXS,
              ),
              decoration: BoxDecoration(
                color: _deepAmber,
                borderRadius: BorderRadius.circular(DesignSystem.radiusSM),
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  snap.milestone!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Geist',
                    fontSize: DesignSystem.fontSizeMD,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

}
