import 'package:flutter/material.dart';
import 'package:puzzle/data/game_metadata.dart';
import 'package:puzzle/utils/design_system.dart';
import 'choice_game_screen.dart';
import 'generated_questions.dart';

final whichCameFirstMetadata = GameMetadata(
  id: 'which_came_first',
  category: 'BOARD',
  icon: Icons.history_rounded,
  color: DesignSystem.gameTeal,
  builder: (context) => const ChoiceGameScreen(
    gameId: 'which_came_first',
    title: 'Which Came First',
    subtitle: 'Four things. Which happened earliest?',
    generate: buildWhichCameFirst,
  ),
  titleGetter: _title,
  subtitleGetter: _subtitle,
  popularity: Popularity.high,
);

String _title(BuildContext context) => 'Which Came First';
String _subtitle(BuildContext context) => 'Four things, one of them earliest';
