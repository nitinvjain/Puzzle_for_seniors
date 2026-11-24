import 'package:flutter/material.dart';
import 'package:puzzle/data/game_metadata.dart';
import 'package:puzzle/utils/design_system.dart';
import 'quiz_ladder_screen.dart';

final quizLadderMetadata = GameMetadata(
  id: 'quiz_ladder',
  category: 'BOARD',
  icon: Icons.emoji_events_rounded,
  color: DesignSystem.gameAmber,
  builder: (context) => const QuizLadderScreen(),
  titleGetter: _title,
  subtitleGetter: _subtitle,
  popularity: Popularity.high,
);

String _title(BuildContext context) => 'Quiz Ladder';
String _subtitle(BuildContext context) =>
    'Fifteen questions, climbing for the top prize';
