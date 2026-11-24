import 'package:flutter/material.dart';
import 'package:puzzle/data/game_metadata.dart';
import 'package:puzzle/utils/design_system.dart';
import 'simple_sudoku_screen.dart';

final simpleSudokuMetadata = GameMetadata(
  id: 'simple_sudoku',
  category: 'BOARD',
  icon: Icons.apps_rounded,
  color: DesignSystem.gameGreen,
  builder: (context) => const SimpleSudokuScreen(),
  titleGetter: _title,
  subtitleGetter: _subtitle,
  popularity: Popularity.high,
);

String _title(BuildContext context) => 'Simple Sudoku';
String _subtitle(BuildContext context) =>
    'A gentle 9x9 with only a few squares to fill';
