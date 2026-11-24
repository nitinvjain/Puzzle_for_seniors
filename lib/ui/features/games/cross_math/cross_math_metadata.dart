import 'package:flutter/material.dart';
import 'package:puzzle/data/game_metadata.dart';
import 'package:puzzle/utils/design_system.dart';
import 'cross_math_screen.dart';

/// Titles are literal rather than localised: adding keys would mean
/// regenerating app_localizations.dart, and this fork's two added games are
/// English-only by design.
final crossMathMetadata = GameMetadata(
  id: 'cross_math',
  category: 'BOARD',
  icon: Icons.grid_on_rounded,
  color: DesignSystem.gameBlue,
  builder: (context) => const CrossMathScreen(),
  titleGetter: _title,
  subtitleGetter: _subtitle,
  popularity: Popularity.high,
);

String _title(BuildContext context) => 'Cross Math';
String _subtitle(BuildContext context) =>
    'Place the numbers so every equation is true';
