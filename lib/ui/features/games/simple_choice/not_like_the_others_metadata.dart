import 'package:flutter/material.dart';
import 'package:puzzle/data/game_metadata.dart';
import 'package:puzzle/utils/design_system.dart';
import 'choice_game_screen.dart';
import 'generated_questions.dart';

// Named apart from the app's existing ATTENTION-category Odd One Out, which
// already owns both the id 'odd_one_out' and the name oddOneOutMetadata.
// Sharing either would not just fail to compile: a shared id would have meant
// one game's help text and finished-round record standing in for the other's.
// Two entries in the list with nearly the same name would also be its own
// small cruelty here.
final notLikeTheOthersMetadata = GameMetadata(
  id: 'not_like_the_others',
  category: 'BOARD',
  icon: Icons.filter_3_rounded,
  color: DesignSystem.gameGreen,
  builder: (context) => const ChoiceGameScreen(
    gameId: 'not_like_the_others',
    title: 'Not Like The Others',
    subtitle: 'Which one does not belong?',
    generate: buildOddOneOut,
  ),
  titleGetter: _title,
  subtitleGetter: _subtitle,
  popularity: Popularity.high,
);

String _title(BuildContext context) => 'Not Like The Others';
String _subtitle(BuildContext context) => 'Three of a kind, and one that is not';
