import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../config/rewards.dart';

part 'game_session_provider.g.dart';

class GameSession {
  final String? lastGameId;
  final String selectedCategory;
  final String searchQuery;

  GameSession({
    this.lastGameId,
    this.selectedCategory = 'ALL',
    this.searchQuery = '',
  });

  GameSession copyWith({
    String? lastGameId,
    String? selectedCategory,
    String? searchQuery,
  }) {
    return GameSession(
      lastGameId: lastGameId ?? this.lastGameId,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

@Riverpod(keepAlive: true)
class GameSessionNotifier extends _$GameSessionNotifier {
  @override
  GameSession build() {
    return GameSession();
  }

  void setSession({required String gameId, required String category, required String query}) {
    // A game is being opened, so anything banked by a game he walked away
    // from belongs to that game, not this one.
    RewardLog.startGame();
    state = GameSession(
      lastGameId: gameId,
      selectedCategory: category,
      searchQuery: query,
    );
  }
}
