import 'package:flutter/material.dart';
import 'package:puzzle/data/game_metadata.dart';
import 'package:puzzle/utils/design_system.dart';
import 'choice_game_screen.dart';
import 'song_title_data.dart';

final songTitleMetadata = GameMetadata(
  id: 'song_title',
  category: 'BOARD',
  icon: Icons.music_note_rounded,
  color: DesignSystem.gameRose,
  builder: (context) => const ChoiceGameScreen(
    gameId: 'song_title',
    title: 'Finish the Song',
    subtitle: 'One word is missing. Which one is it?',
    pool: songTitleQuestions,
  ),
  titleGetter: _title,
  subtitleGetter: _subtitle,
  popularity: Popularity.high,
);

String _title(BuildContext context) => 'Finish the Song';
String _subtitle(BuildContext context) => 'One word missing from a song you know';
