import 'package:flutter/material.dart';
import 'package:puzzle/data/game_metadata.dart';
import 'package:puzzle/utils/design_system.dart';
import 'choice_game_screen.dart';
import 'galti_data.dart';

final galtiMetadata = GameMetadata(
  id: 'galti',
  category: 'BOARD',
  icon: Icons.rule_rounded,
  color: DesignSystem.gameRose,
  builder: (context) => const ChoiceGameScreen(
    gameId: 'galti',
    title: 'Find the Mistake',
    subtitle: 'One line is wrong. Which?',
    pool: galtiQuestions,
  ),
  titleGetter: _title,
  subtitleGetter: _subtitle,
  popularity: Popularity.high,
);

String _title(BuildContext context) => 'Find the Mistake';
String _subtitle(BuildContext context) => 'One line is wrong. Which?';
