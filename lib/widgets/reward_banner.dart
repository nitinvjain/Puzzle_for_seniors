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
          // The stars. The newly earned one is the last in the row and is the
          // one that animates.
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < Rewards.starsToDraw(snap.totalGames); i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: _star(
                      animate: snap.earnedStar &&
                          i == Rewards.starsToDraw(snap.totalGames) - 1,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: DesignSystem.spaceSM),
          // The loud line: what he just earned. This is the part that lands,
          // so it is the biggest thing in the panel after the star itself.
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
          // The running totals, quiet.
          Text(
            Rewards.pointsLine(snap.totalPoints),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Geist',
              fontSize: DesignSystem.fontSizeMD,
              fontWeight: FontWeight.w800,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            Rewards.totalLine(snap.totalGames),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Geist',
              fontSize: DesignSystem.fontSizeSM,
              fontWeight: FontWeight.w700,
              color: colorScheme.onSurface.withValues(alpha: 0.8),
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
                color: colorScheme.onSurface.withValues(alpha: 0.8),
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

  Widget _star({required bool animate}) {
    const icon = Icon(
      Icons.star_rounded,
      color: DesignSystem.accentAmber,
      size: 40,
    );
    if (!animate) return icon;
    return ScaleTransition(scale: _pop, child: icon);
  }
}
