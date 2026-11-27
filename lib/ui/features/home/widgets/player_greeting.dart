import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/rewards.dart';
import '../../../../providers/settings_provider.dart';
import '../../../../providers/player_name_provider.dart';
import '../../../../providers/user_providers.dart';
import '../../../../utils/design_system.dart';
import '../../../../utils/haptic_feedback.dart';
import '../../../../widgets/tangible.dart';

/// The line at the top of the home screen: who is playing, and how they are
/// getting on.
///
/// Seeing his own name on the screen is worth more than it looks. Orientation
/// goes early, and a device that greets him by name reads as his rather than
/// as a machine he has been handed.
///
/// Tapping it opens the box to set or change the name -- almost certainly
/// something his son does once, so it is deliberately quiet rather than a
/// prompt that nags.
class PlayerGreeting extends ConsumerWidget {
  const PlayerGreeting({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final name = ref.watch(playerNameProvider);
    final points = ref.watch(userDataNotifierProvider.select((d) => d.xp));
    final showPoints = ref.watch(settingsProvider.select((s) => s.showPoints));

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        DesignSystem.spaceMD,
        DesignSystem.spaceXS,
        DesignSystem.spaceMD,
        DesignSystem.spaceSM,
      ),
      child: TangibleButton(
        color: colorScheme.surface,
        onTap: () {
          HapticFeedbackUtil.selectionClick();
          _editName(context, ref, name);
        },
        padding: const EdgeInsets.symmetric(
          horizontal: DesignSystem.spaceMD,
          vertical: DesignSystem.spaceMD,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    name == null ? 'Tap here to add your name' : 'Namaste, $name',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Geist',
                      fontSize: DesignSystem.fontSizeLG,
                      fontWeight: FontWeight.w900,
                      color: name == null
                          ? colorScheme.onSurface.withValues(alpha: 0.75)
                          : colorScheme.onSurface,
                    ),
                  ),
                  if (showPoints && points > 0) ...[
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          size: 20,
                          color: DesignSystem.accentAmber,
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            Rewards.pointsLine(points),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'Geist',
                              fontSize: DesignSystem.fontSizeSM,
                              fontWeight: FontWeight.w700,
                              color: colorScheme.onSurface.withValues(alpha: 0.8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: DesignSystem.spaceSM),
            Icon(
              Icons.edit_rounded,
              size: 24,
              color: colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _editName(
      BuildContext context, WidgetRef ref, String? current) async {
    final controller = TextEditingController(text: current ?? '');
    final result = await showDialog<String?>(
      context: context,
      builder: (dialogContext) {
        final scheme = Theme.of(dialogContext).colorScheme;
        return AlertDialog(
          backgroundColor: scheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DesignSystem.radiusLG),
          ),
          title: const Text(
            'Who is playing?',
            style: TextStyle(
              fontFamily: 'Geist',
              fontSize: DesignSystem.fontSizeLG,
              fontWeight: FontWeight.w900,
            ),
          ),
          content: TextField(
            controller: controller,
            autofocus: true,
            maxLength: PlayerNameNotifier.maxLength,
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.done,
            onSubmitted: (value) => Navigator.of(dialogContext).pop(value),
            style: const TextStyle(
              fontFamily: 'Geist',
              fontSize: DesignSystem.fontSizeLG,
              fontWeight: FontWeight.w800,
            ),
            decoration: InputDecoration(
              hintText: 'Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(DesignSystem.radiusMD),
              ),
            ),
          ),
          actionsPadding: const EdgeInsets.fromLTRB(
            DesignSystem.spaceMD,
            0,
            DesignSystem.spaceMD,
            DesignSystem.spaceMD,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(
                'CANCEL',
                style: TextStyle(
                  fontFamily: 'Geist',
                  fontSize: DesignSystem.fontSizeMD,
                  fontWeight: FontWeight.w800,
                  color: scheme.onSurface.withValues(alpha: 0.8),
                ),
              ),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.of(dialogContext).pop(controller.text),
              style: TextButton.styleFrom(
                backgroundColor: DesignSystem.successDeep,
                padding: const EdgeInsets.symmetric(
                  horizontal: DesignSystem.spaceMD,
                  vertical: DesignSystem.spaceSM,
                ),
              ),
              child: const Text(
                'SAVE',
                style: TextStyle(
                  fontFamily: 'Geist',
                  fontSize: DesignSystem.fontSizeMD,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );

    controller.dispose();
    // Cancel returns null and leaves the name alone; Save returns the text,
    // and an empty one clears it.
    if (result != null) {
      await ref.read(playerNameProvider.notifier).setName(result);
    }
  }
}
