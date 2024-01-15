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

  List<Player> playersCapitals = [];
  List<Player> playersFlags = [];


  Future<void> loadPlayers(String gameMode) async {
    if (gameMode == 'Capitals') {
      playersCapitals = [
        Player(username: 'Etienne', scoreCapitals: 56850, timeCapitals: '03:48', hasHighscoreCapitals: true),
        Player(username: 'Bastien', scoreCapitals: 52750, timeCapitals: '04:17', hasHighscoreCapitals: false)
      ];

      playersCapitals.sort((a, b) {
        if (a.scoreCapitals != null && b.scoreCapitals != null) {
          return b.scoreCapitals!.compareTo(a.scoreCapitals!);
        } else {
          return 0;
        }
      });
      emit(playersCapitals);

    } else {
      playersFlags = [
        Player(username: 'Etienne', scoreFlags: 9500, timeFlags: '05:43', hasHighscoreFlags: false),
        Player(username: 'Bastien', scoreFlags: 9800, timeFlags: '04:51', hasHighscoreFlags: true)
      ];

      playersFlags.sort((a, b) {
        if (a.scoreFlags != null && b.scoreFlags != null) {
          return b.scoreFlags!.compareTo(a.scoreFlags!);
        } else {
          return 0;
        }
      });

      emit(playersFlags);
    }



  }
/*
  Future<void> loadPlayersFlags() async {
    List<Player> players = [
      Player(username: 'Etienne', scoreFlags: 9500, timeFlags: '05:43', hasHighscoreFlags: false),
      Player(username: 'Bastien', scoreFlags: 9800, timeFlags: '04:51', hasHighscoreFlags: true)
    ];

    players.sort((a, b) {
      if (a.scoreFlags != null && b.scoreFlags != null) {
        return b.scoreFlags!.compareTo(a.scoreFlags!);
      } else {
        return 0;
      }
    });

    emit(players);
  }
  */

  void addPlayerCapitals(Player player) {
    print('Adding player to capitals leaderboard: $player');
    List<Player> updatedPlayers = [...state, player];

    updatedPlayers.sort((a, b) {
      if (a.scoreCapitals != null && b.scoreCapitals != null) {
        return b.scoreCapitals!.compareTo(a.scoreCapitals!);
      } else {
        return 0;
      }
    });

    emit(updatedPlayers);
    print(updatedPlayers.length);
  }

  void addPlayerFlags(Player player) {
    List<Player> updatedPlayers = [...state, player];

    updatedPlayers.sort((a, b) {
      if (a.scoreFlags != null && b.scoreFlags != null) {
        return b.scoreFlags!.compareTo(a.scoreFlags!);
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
