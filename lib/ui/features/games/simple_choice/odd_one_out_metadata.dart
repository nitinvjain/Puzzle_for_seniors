import 'package:flutter/material.dart';
import 'package:puzzle/data/game_metadata.dart';
import 'package:puzzle/utils/design_system.dart';
import 'choice_game_screen.dart';
import 'generated_questions.dart';

final oddOneOutMetadata = GameMetadata(
  id: 'odd_one_out',
  category: 'BOARD',
  icon: Icons.filter_3_rounded,
  color: DesignSystem.gameGreen,
  builder: (context) => const ChoiceGameScreen(
    gameId: 'odd_one_out',
    title: 'Odd One Out',
    subtitle: 'Which one does not belong?',
    generate: buildOddOneOut,
  ),
  titleGetter: _title,
  subtitleGetter: _subtitle,
  popularity: Popularity.high,
);

String _title(BuildContext context) => 'Odd One Out';
String _subtitle(BuildContext context) => 'Three of a kind, and one that is not';
