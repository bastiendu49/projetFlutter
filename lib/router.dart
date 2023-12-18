import 'package:jeu_geo/ui.screens/game.dart';
import 'package:jeu_geo/ui.screens/game_setup.dart';
import 'package:jeu_geo/ui.screens/home.dart';
import 'package:jeu_geo/ui.screens/leaderboard.dart';

class AppRouter {
  static const String homePage = '/home';
  static const String gameSetupPage = '/gameSetup';
  static const String gamePage = '/game';
  static const String leaderboardPage = '/leaderboard';

  static final routes = {
    homePage: (context) => const Home(),
    gameSetupPage: (context) => GameSetup(),
    gamePage: (context) => const GameMaps(),
    leaderboardPage: (context) => LeaderboardPage(),
  };
}