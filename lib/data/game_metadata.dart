import 'package:flutter/material.dart';

enum Popularity { high, default_, low }

class GameMetadata {
  final String id;
  final String category;
  final IconData icon;

  /// A mark of the game's own, drawn instead of [icon] where one is given.
  /// Takes the size the icon would have been drawn at, so the same builder
  /// serves the small badge in the list and the large watermark on the card.
  /// [icon] is still required, as the fallback and for anything that wants a
  /// plain glyph.
  final Widget Function(BuildContext context, double size)? logoBuilder;
  final Color color;
  final WidgetBuilder builder;
  final String Function(BuildContext) titleGetter;
  final String Function(BuildContext) subtitleGetter;
  final Popularity popularity;

  const GameMetadata({
    required this.id,
    required this.category,
    required this.icon,
    this.logoBuilder,
    required this.color,
    required this.builder,
    required this.titleGetter,
    required this.subtitleGetter,
    this.popularity = Popularity.default_,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'category': category,
        'icon': icon,
        'logoBuilder': logoBuilder,
        'color': color,
        'builder': builder,
        'titleGetter': titleGetter,
        'subtitleGetter': subtitleGetter,
        'popularity': popularity,
      };
}
