import 'package:flutter/material.dart';
import 'package:puzzle/data/game_metadata.dart';
import 'package:puzzle/utils/design_system.dart';
import 'choice_game_screen.dart';
import 'formula_data.dart';

final formulaMetadata = GameMetadata(
  id: 'formula',
  category: 'BOARD',
  icon: Icons.functions_rounded,
  color: DesignSystem.gameIndigo,
  builder: (context) => const ChoiceGameScreen(
    gameId: 'formula',
    title: 'Finish the Formula',
    subtitle: 'The ones he taught for thirty years',
    pool: formulaQuestions,
  ),
  titleGetter: _title,
  subtitleGetter: _subtitle,
  popularity: Popularity.high,
);

String _title(BuildContext context) => 'Finish the Formula';
String _subtitle(BuildContext context) => 'The ones he taught for thirty years';
