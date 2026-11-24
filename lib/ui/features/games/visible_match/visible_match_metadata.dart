import 'package:flutter/material.dart';
import 'package:puzzle/data/game_metadata.dart';
import 'package:puzzle/utils/design_system.dart';
import 'visible_match_screen.dart';

final visibleMatchMetadata = GameMetadata(
  id: 'visible_match',
  category: 'BOARD',
  icon: Icons.compare_arrows_rounded,
  color: DesignSystem.gamePurple,
  builder: (context) => const VisibleMatchScreen(),
  titleGetter: _title,
  subtitleGetter: _subtitle,
  popularity: Popularity.high,
);

String _title(BuildContext context) => 'Matching Pairs';
String _subtitle(BuildContext context) => 'Both columns face up, nothing hidden';
