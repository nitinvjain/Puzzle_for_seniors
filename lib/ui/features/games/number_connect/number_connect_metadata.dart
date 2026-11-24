import 'package:flutter/material.dart';
import 'package:puzzle/data/game_metadata.dart';
import 'package:puzzle/utils/design_system.dart';
import 'number_connect_screen.dart';

final numberConnectMetadata = GameMetadata(
  id: 'number_connect',
  category: 'BOARD',
  icon: Icons.hub_rounded,
  color: DesignSystem.gamePurple,
  builder: (context) => const NumberConnectScreen(),
  titleGetter: _title,
  subtitleGetter: _subtitle,
  popularity: Popularity.high,
);

String _title(BuildContext context) => 'Number Connect';
String _subtitle(BuildContext context) =>
    'Join matching tiles to build bigger numbers';
