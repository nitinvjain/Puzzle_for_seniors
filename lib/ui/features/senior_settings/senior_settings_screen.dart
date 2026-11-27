import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/app_settings.dart';
import '../../../providers/player_name_provider.dart';
import '../../../providers/settings_provider.dart';
import '../../../utils/design_system.dart';
import '../../../utils/haptic_feedback.dart';
import '../../../utils/sound_feedback.dart';
import '../../../widgets/tangible.dart';
import '../../core/juice/game_scaffold.dart';

/// The control knobs.
///
/// Named and filed apart from the upstream SettingsScreen, which lives next
/// door in features/settings and is a different screen entirely -- theme,
/// language, trial mode, keep-screen-awake, and the author's links. That one
/// is still wired to the main shell's third tab; this one is reached from the
/// gear on the home screen and is the only one a senior build ever shows.
///
/// This screen is for NJ, not for his father, and that shapes it. The
/// standing brief says there should be nothing on screen to get lost in, and
/// a settings screen is exactly the sort of thing that rule was written
/// against -- so everything here is a toggle or a choice between three
/// labelled options. There is nothing to type into except a name, nothing
/// that can be deleted, and nothing that leaves the app. The worst his father
/// can do by wandering in is turn the sound off, which is one tap to undo.
class SeniorSettingsScreen extends ConsumerWidget {
  const SeniorSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final settings = ref.watch(settingsProvider);
    final notifier = ref.read(settingsProvider.notifier);
    final name = ref.watch(playerNameProvider);

    return GameScaffold(
      title: 'SETTINGS',
      subtitle: 'Sound, size and name',
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(DesignSystem.spaceMD),
          children: [
            _heading('WHO IS PLAYING', scheme),
            _row(
              scheme: scheme,
              label: 'Name',
              trailing: Text(
                name ?? 'Not set',
                style: TextStyle(
                  fontSize: DesignSystem.fontSizeMD,
                  fontWeight: FontWeight.w800,
                  color: name == null
                      ? scheme.onSurface.withValues(alpha: 0.5)
                      : scheme.onSurface,
                ),
              ),
              onTap: () => _editName(context, ref, name),
            ),

            _heading('SOUND', scheme),
            _switchRow(
              scheme: scheme,
              label: 'Sounds',
              hint: 'A note when a piece is placed, a chime at the end',
              value: settings.sound,
              // Awaited before the demonstration note, not fired alongside
              // it: the sound utilities read the stored value straight from
              // the box, so a note played before the write lands would be
              // judged against the old setting and swallowed.
              onChanged: (v) async {
                await notifier.setSound(v);
                if (v) SoundFeedbackUtil.tap();
              },
            ),
            _switchRow(
              scheme: scheme,
              label: 'Vibration',
              hint: 'A small buzz on each tap',
              value: settings.vibration,
              onChanged: (v) async {
                await notifier.setVibration(v);
                if (v) HapticFeedbackUtil.lightImpact();
              },
            ),
            _row(
              scheme: scheme,
              label: 'Test the sound',
              trailing: Icon(Icons.volume_up_rounded,
                  size: 30, color: scheme.onSurface),
              onTap: () => _testSound(context),
            ),

            _heading('TEXT SIZE', scheme),
            _textSizeRow(context, scheme, settings.textScale, notifier),

            _heading('HOME SCREEN', scheme),
            _switchRow(
              scheme: scheme,
              label: 'Show points',
              hint: 'The running total under the greeting',
              value: settings.showPoints,
              onChanged: notifier.setShowPoints,
            ),

            const SizedBox(height: DesignSystem.spaceLG),
          ],
        ),
      ),
    );
  }

  // --- pieces ---------------------------------------------------------------

  Widget _heading(String text, ColorScheme scheme) => Padding(
        padding: const EdgeInsets.only(
          top: DesignSystem.spaceLG,
          bottom: DesignSystem.spaceSM,
          left: DesignSystem.spaceXS,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: DesignSystem.fontSizeSM,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.4,
            color: scheme.onSurface.withValues(alpha: 0.65),
          ),
        ),
      );

  Widget _row({
    required ColorScheme scheme,
    required String label,
    required Widget trailing,
    String? hint,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: DesignSystem.spaceSM),
      child: TangibleButton(
        color: scheme.surface,
        radius: DesignSystem.radiusMD,
        borderWidth: 2.0,
        borderColor: scheme.onSurface.withValues(alpha: 0.35),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: DesignSystem.spaceMD,
            vertical: DesignSystem.spaceMD,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: DesignSystem.fontSizeMD,
                        fontWeight: FontWeight.w800,
                        color: scheme.onSurface,
                      ),
                    ),
                    if (hint != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        hint,
                        style: TextStyle(
                          fontSize: DesignSystem.fontSizeXS,
                          fontWeight: FontWeight.w600,
                          color: scheme.onSurface.withValues(alpha: 0.65),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: DesignSystem.spaceSM),
              trailing,
            ],
          ),
        ),
      ),
    );
  }

  Widget _switchRow({
    required ColorScheme scheme,
    required String label,
    required String hint,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return _row(
      scheme: scheme,
      label: label,
      hint: hint,
      // Bigger than the Material default, which is a small target for an
      // older hand; the whole row is tappable as well.
      trailing: Transform.scale(
        scale: 1.4,
        // Coloured through WidgetStateProperty rather than activeColor or
        // activeThumbColor: those two have swapped places across recent
        // Flutter releases, and there is no Switch anywhere else in this app
        // to tell me which spelling this SDK takes. The property form has
        // been stable throughout.
        child: Switch(
          value: value,
          onChanged: onChanged,
          thumbColor: WidgetStateProperty.resolveWith<Color?>(
            (states) =>
                states.contains(WidgetState.selected) ? Colors.white : null,
          ),
          trackColor: WidgetStateProperty.resolveWith<Color?>(
            (states) => states.contains(WidgetState.selected)
                ? DesignSystem.successDeep
                : null,
          ),
        ),
      ),
      onTap: () => onChanged(!value),
    );
  }

  Widget _textSizeRow(BuildContext context, ColorScheme scheme, double current,
      SettingsNotifier notifier) {
    const options = <String, double>{
      'Normal': AppSettings.textNormal,
      'Large': AppSettings.textLarge,
      'Largest': AppSettings.textLargest,
    };
    return Row(
      children: [
        for (final entry in options.entries) ...[
          Expanded(
            child: TangibleButton(
              // Floating point from a Hive round trip will not compare equal
              // reliably, so the match is on nearness, not equality.
              color: (current - entry.value).abs() < 0.01
                  ? DesignSystem.successDeep
                  : scheme.surface,
              radius: DesignSystem.radiusMD,
              borderWidth: 2.0,
              borderColor: (current - entry.value).abs() < 0.01
                  ? null
                  : scheme.onSurface.withValues(alpha: 0.35),
              onTap: () => notifier.setTextScale(entry.value),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: DesignSystem.spaceMD),
                child: Center(
                  child: Text(
                    entry.key,
                    style: TextStyle(
                      fontSize: DesignSystem.fontSizeSM,
                      fontWeight: FontWeight.w800,
                      color: (current - entry.value).abs() < 0.01
                          ? Colors.white
                          : scheme.onSurface,
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (entry.key != 'Largest')
            const SizedBox(width: DesignSystem.spaceSM),
        ],
      ],
    );
  }

  // --- actions --------------------------------------------------------------

  /// Play the chime and say what the phone makes of it.
  ///
  /// Moved here from a speaker button in the home app bar, which was always a
  /// diagnostic wearing a button's clothes. Two things go wrong with sound on
  /// a phone that is not yours to hold and they look identical from a
  /// distance: the app may not be making a noise, or the phone may be muted.
  /// This tells them apart in one tap.
  Future<void> _testSound(BuildContext context) async {
    SoundFeedbackUtil.playTest();
    final report = await SoundFeedbackUtil.describe();
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 10),
        content: Text(
          'Sound test: $report',
          style: const TextStyle(fontSize: 15, height: 1.3),
        ),
      ),
    );
  }

  Future<void> _editName(
      BuildContext context, WidgetRef ref, String? current) async {
    final controller = TextEditingController(text: current ?? '');
    final result = await showDialog<String?>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Who is playing?'),
        content: TextField(
          controller: controller,
          autofocus: true,
          textCapitalization: TextCapitalization.words,
          maxLength: PlayerNameNotifier.maxLength,
          style: const TextStyle(
              fontSize: DesignSystem.fontSizeLG, fontWeight: FontWeight.w700),
          decoration: const InputDecoration(hintText: 'Name'),
          onSubmitted: (v) => Navigator.of(dialogContext).pop(v),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(controller.text),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    if (result != null) {
      await ref.read(playerNameProvider.notifier).setName(result);
    }
    controller.dispose();
  }
}
