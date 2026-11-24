import 'package:flutter/material.dart';
import 'package:puzzle/data/game_metadata.dart';
import 'package:puzzle/utils/design_system.dart';
import 'kbc_india_logo.dart';
import 'quiz_ladder_screen.dart';

// The id stays 'quiz_ladder' on purpose. It is not shown anywhere: it is the
// key his completed-games record and the help text are stored under, so
// renaming it would lose the history and silently drop the how-to-play panel.
// Only the title the player reads has changed.
final quizLadderMetadata = GameMetadata(
  id: 'quiz_ladder',
  category: 'BOARD',
  icon: Icons.emoji_events_rounded,
  logoBuilder: kbcIndiaLogo,
  color: DesignSystem.gameAmber,
  builder: (context) => const QuizLadderScreen(),
  titleGetter: _title,
  subtitleGetter: _subtitle,
  popularity: Popularity.high,
);

String _title(BuildContext context) => 'KBC India';
String _subtitle(BuildContext context) =>
    'Fifteen questions, climbing for the top prize';
