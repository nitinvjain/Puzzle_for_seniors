import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/senior_mode.dart';
import '../../../../data/game_metadata.dart';
import '../../../../data/game_registry.dart';
import '../../../../providers/user_providers.dart';
import '../../../../utils/design_system.dart';
import 'game_tile.dart';

/// Today's date, and four games chosen for it.
///
/// There are 317 games in this build. That is a good library and a bad
/// menu: a list that long is not a choice, it is a scroll, and deciding
/// what to play from it is planning -- the faculty vascular dementia takes
/// early. Four tiles is a choice. The rest of the catalogue is still below,
/// for whoever wants it.
///
/// The day comes first, and larger than the date, because knowing what day
/// it is matters more than the number and is the thing that goes first. It
/// is also the reason this sits at the top rather than in a corner: an app
/// he opens most days can quietly do the work of a calendar on the wall.
///
/// The four games are fixed for the whole day and change at midnight. Fixed
/// matters: if they shuffled on every visit, coming back to the one he was
/// enjoying would mean hunting for it.
class TodaysGames extends ConsumerStatefulWidget {
  const TodaysGames({super.key});

  @override
  ConsumerState<TodaysGames> createState() => _TodaysGamesState();
}

class _TodaysGamesState extends ConsumerState<TodaysGames> {
  Timer? _rollover;
  late DateTime _today = _dateOnly(DateTime.now());

  @override
  void initState() {
    super.initState();
    _scheduleRollover();
  }

  @override
  void dispose() {
    _rollover?.cancel();
    super.dispose();
  }

  /// Turn the page at midnight.
  ///
  /// The tablet sits on charge and is rarely closed, so without this the
  /// date would read Tuesday until something else happened to rebuild it --
  /// which is worse than showing no date at all.
  void _scheduleRollover() {
    _rollover?.cancel();
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day + 1);
    _rollover = Timer(midnight.difference(now) + const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() => _today = _dateOnly(DateTime.now()));
      _scheduleRollover();
    });
  }

  static DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final hidden = <String>{
      ...SeniorMode.hiddenGameIds,
      ...ref.watch(
          userDataNotifierProvider.select((d) => d.hiddenGameIds ?? const [])),
    };
    final games = pickForDay(_today, hidden);

    return Padding(
      padding: const EdgeInsets.fromLTRB(DesignSystem.spaceLG,
          DesignSystem.spaceSM, DesignSystem.spaceLG, DesignSystem.spaceMD),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            dayName(_today),
            textAlign: TextAlign.center,
            style: TextStyle(
              // fontSize2XL, not an invented XXL: the scale runs
              // SM, MD, LG, XL, 2XL, 3XL, Hero.
              fontSize: DesignSystem.fontSize2XL,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.0,
              color: scheme.onSurface,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            dateLine(_today),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: DesignSystem.fontSizeLG,
              fontWeight: FontWeight.w700,
              color: scheme.onSurface.withValues(alpha: 0.75),
            ),
          ),
          if (games.isNotEmpty) ...[
            const SizedBox(height: DesignSystem.spaceLG),
            Text(
              'TODAY\'S GAMES',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: DesignSystem.fontSizeSM,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.6,
                color: scheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
            const SizedBox(height: DesignSystem.spaceMD),
            LayoutBuilder(builder: (context, box) {
              // Two across on a tablet, one on a phone -- the same shapes the
              // catalogue below uses, so these read as the same kind of thing
              // and not as a different sort of button.
              final columns = box.maxWidth > 600 ? 2 : 1;
              final rows = <Widget>[];
              for (var i = 0; i < games.length; i += columns) {
                final slice = games.skip(i).take(columns).toList();
                rows.add(Padding(
                  padding:
                      const EdgeInsets.only(bottom: DesignSystem.spaceMD),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var j = 0; j < columns; j++) ...[
                        if (j > 0) const SizedBox(width: DesignSystem.spaceMD),
                        Expanded(
                          child: j < slice.length
                              ? GameTileWrapper(
                                  key: ValueKey('today-${slice[j].id}'),
                                  game: slice[j],
                                  selectedCategory: 'All',
                                  searchQuery: '',
                                )
                              : const SizedBox.shrink(),
                        ),
                      ],
                    ],
                  ),
                ));
              }
              return Column(children: rows);
            }),
          ],
        ],
      ),
    );
  }

  // --- the date, in words -------------------------------------------------

  /// Written out here rather than taken from intl's DateFormat.
  ///
  /// DateFormat needs its locale data initialised before it will produce
  /// anything but English, and throws if it has not been -- a crash on the
  /// home screen, in a build whose every other word is already English.
  static const List<String> _days = [
    'Monday', 'Tuesday', 'Wednesday', 'Thursday',
    'Friday', 'Saturday', 'Sunday',
  ];

  static const List<String> _months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December',
  ];

  static String dayName(DateTime d) => _days[d.weekday - 1];

  /// 27 November 2026.
  static String dateLine(DateTime d) =>
      '${d.day} ${_months[d.month - 1]} ${d.year}';

  // --- choosing the four --------------------------------------------------

  /// One board game, then three more from three different other categories.
  ///
  /// A board game every day because those are the ones he plays; the other
  /// three rotate through the remaining categories so the day brings
  /// something he would not have gone looking for.
  static const List<String> _otherCategories = [
    'MATH', 'MEMORY', 'ATTENTION', 'WORD', 'LOGIC', 'SPATIAL',
  ];

  static List<GameMetadata> pickForDay(DateTime day, Set<String> hidden) {
    final n = _dayNumber(day);
    final picked = <GameMetadata>[];
    final taken = <String>{};

    void take(String category, int salt) {
      final game = _fromCategory(category, n, salt, hidden, taken);
      if (game == null) return;
      picked.add(game);
      taken.add(game.id);
    }

    take('BOARD', 0);
    for (var i = 0; i < 3; i++) {
      take(_otherCategories[(n + i) % _otherCategories.length], i + 1);
    }
    return picked;
  }

  static int _dayNumber(DateTime d) =>
      DateTime(d.year, d.month, d.day).difference(DateTime(2000, 1, 1)).inDays;

  /// Rotate through a category rather than picking at random.
  ///
  /// Random would repeat a game within the week often enough to notice. This
  /// works all the way through a category before anything comes round again,
  /// and reshuffles for the next pass so the passes are not identical.
  static GameMetadata? _fromCategory(
      String category, int day, int salt, Set<String> hidden, Set<String> taken) {
    final games = allGamesMetadata
        .where((g) =>
            g.category == category &&
            !hidden.contains(g.id) &&
            !taken.contains(g.id))
        .toList()
      ..sort((a, b) => a.id.compareTo(b.id));
    if (games.isEmpty) return null;
    final count = games.length;
    final pass = day ~/ count;
    final order = [...games]
      ..shuffle(Random(_stableHash(category) ^ (pass * 7919) ^ salt));
    return order[day % count];
  }

  /// A hash that will not change under me.
  ///
  /// String.hashCode is deterministic within a run but carries no promise
  /// across Dart versions, and a changed hash would silently reshuffle every
  /// category on some future upgrade.
  static int _stableHash(String s) {
    var h = 2166136261;
    for (final unit in s.codeUnits) {
      h = (h ^ unit) * 16777619;
      h &= 0x3FFFFFFF;
    }
    return h;
  }
}
