import 'package:flutter/material.dart';
import 'package:puzzle/data/game_metadata.dart';
import 'package:puzzle/utils/design_system.dart';
import 'choice_game_screen.dart';
import 'generated_questions.dart';

final tablesMetadata = GameMetadata(
  id: 'tables_drill',
  category: 'BOARD',
  icon: Icons.close_rounded,
  color: DesignSystem.gameBlue,
  builder: (context) => const ChoiceGameScreen(
    gameId: 'tables_drill',
    title: 'Tables',
    subtitle: 'What is the answer?',
    generate: buildTables,
  ),
  titleGetter: _title,
  subtitleGetter: _subtitle,
  popularity: Popularity.high,
);

String _title(BuildContext context) => 'Tables';
String _subtitle(BuildContext context) => 'Straight multiplication, nothing else';
