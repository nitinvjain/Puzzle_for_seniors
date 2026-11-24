import 'package:flutter/material.dart';
import 'package:puzzle/data/game_metadata.dart';
import 'package:puzzle/utils/design_system.dart';
import 'choice_game_screen.dart';
import 'kahavat_data.dart';

final kahavatMetadata = GameMetadata(
  id: 'kahavat',
  category: 'BOARD',
  icon: Icons.format_quote_rounded,
  color: DesignSystem.gameAmber,
  builder: (context) => const ChoiceGameScreen(
    gameId: 'kahavat',
    title: 'Finish the Kahavat',
    subtitle: 'How does the saying end?',
    pool: kahavatQuestions,
  ),
  titleGetter: _title,
  subtitleGetter: _subtitle,
  popularity: Popularity.high,
);

String _title(BuildContext context) => 'Finish the Kahavat';
String _subtitle(BuildContext context) => 'The old sayings, one word short';
