import 'package:jeu_geo/ui.screens/game.dart';
import 'package:jeu_geo/ui.screens/game_mode.dart';
import 'package:jeu_geo/ui.screens/home.dart';
import 'package:jeu_geo/ui.screens/leaderboard.dart';

class AppRouter {
  static const String homePage = '/home';
  static const String gameModePage = '/gameMode';
  static const String gamePage = '/game';
  static const String leaderboardPage = '/leaderboard';

  static final routes = {
    homePage: (context) => const Home(),
    gameModePage: (context) => GameMode(),
    gamePage: (context) => const GameMaps(),
    leaderboardPage: (context) => const LeaderboardPage(),
  };
}