import 'package:flutter/material.dart';
import 'package:puzzle/data/game_metadata.dart';
import 'package:puzzle/utils/design_system.dart';
import 'choice_game_screen.dart';
import 'naap_tol_data.dart';

final naapTolMetadata = GameMetadata(
  id: 'naap_tol',
  category: 'BOARD',
  icon: Icons.straighten_rounded,
  color: DesignSystem.gameTeal,
  builder: (context) => const ChoiceGameScreen(
    gameId: 'naap_tol',
    title: 'Naap-Tol',
    subtitle: 'Seer, maund, anna, furlong',
    pool: naapTolQuestions,
  ),
  titleGetter: _title,
  subtitleGetter: _subtitle,
  popularity: Popularity.high,
);

String _title(BuildContext context) => 'Naap-Tol';
String _subtitle(BuildContext context) => 'Seer, maund, anna, furlong';
