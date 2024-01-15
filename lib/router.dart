import 'package:jeu_geo/blocs/player_cubit.dart';
import 'package:jeu_geo/ui.screens/game.dart';
import 'package:jeu_geo/ui.screens/game_setup.dart';
import 'package:jeu_geo/ui.screens/home.dart';
import 'package:jeu_geo/ui.screens/leaderboard.dart';

class AppRouter {
  static const String homePage = '/home';
  static const String gameSetupPage = '/gameSetup';
  static const String gameCapitalPage = '/game';
  static const String leaderboardPage = '/leaderboard';
  static const String gameFlagPage = '/gameFlag';

  static final routes = {
    homePage: (context) => const Home(),
    gameSetupPage: (context) => GameSetup(),
    gameCapitalPage: (context) => const GameMaps(playerCubit: PlayerCubit(),),
    leaderboardPage: (context) => LeaderboardPage(),
    gameFlagPage: (context) => const GameFlag(),
  };
}