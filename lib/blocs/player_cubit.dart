import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jeu_geo/models/player.dart';

class PlayerCubit extends Cubit<List<Player>> {

  PlayerCubit() : super([]);

  Player? _currentPlayer;

  Player get currentPlayer => _currentPlayer ?? Player();

  void setCurrentPlayer(Player player) {
    _currentPlayer = player;
  }

  String? _currentUsername;

  String get currentUsername => _currentUsername ?? '';

  void setUsername(String username) {
    _currentUsername = username;
  }


  Future<void> loadPlayers() async {
    // Chargement initial des joueurs
    List<Player> players = [
      Player(username: 'Etienne', score: 56850, time: '03:48', hasHighscore: true),
      Player(username: 'Bastien', score: 52750, time: '04:17', hasHighscore: false)
    ];

    players.sort((a, b) {
      if (a.score != null && b.score != null) {
        return b.score!.compareTo(a.score!);
      } else {
        return 0;
      }
    });

    emit(players);
  }

  void addPlayer(Player player) {
    List<Player> updatedPlayers = [...state, player];

    updatedPlayers.sort((a, b) {
      if (a.score != null && b.score != null) {
        return b.score!.compareTo(a.score!);
      } else {
        return 0;
      }
    });

    emit(updatedPlayers);
  }

  /*
  void updateUsername(String newUsername) {
    currentUsername = newUsername;
    currentPlayer = currentPlayer.copyWith(username: newUsername);
  }

  void updateScoreAndTime(int newScore, String newTime) {
    currentPlayer = currentPlayer.copyWith(score: newScore, time: newTime);
  }
  */

  /*
  void setHighscore() {
    if (state.isEmpty) {
      return;
    }



    for (int i = 0; i < state.length; i++) {
      state[i] = state[i].copyWith(hasHighscore: i == 0);
    }

    emit(List<Player>.from(state));
  }
  */
}
