import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jeu_geo/models/player.dart';

import '../blocs/player_cubit.dart';
import '../router.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  List<String> gameModes = ['Capitals', 'Flags'];
  int currentPageIndex = 0;

  String _getScore(Player player, String gameMode) {
    return gameMode == 'Capitals' ? player.scoreCapitals.toString() : player.scoreFlags.toString();
  }

  String _getTime(Player player, String gameMode) {
    return gameMode == 'Capitals' ? player.timeCapitals.toString() : player.timeFlags.toString();
  }

  List<Player> filterPlayers(List<Player> players) {
    return players.where((player) => player.scoreCapitals != null ).toList();
  }

  Widget buildLeaderboard(String gameMode) {
    return Column(
      children: [
        Text('$gameMode leaderboard : ', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Expanded(
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: BlocBuilder<PlayerCubit, List<Player>>(
                builder: (context, state) {
                  return Table(
                    border: TableBorder.all(
                      borderRadius: BorderRadius.circular(10),
                      width: 1.5,
                    ),
                    defaultVerticalAlignment: TableCellVerticalAlignment.top,
                    children: <TableRow>[
                      const TableRow(
                        children: [
                          TableCell(child: Center(child: Text('Rank', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)))),
                          TableCell(child: Center(child: Text('Name', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)))),
                          TableCell(child: Center(child: Text('Score', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)))),
                          TableCell(child: Center(child: Text('Time', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)))),
                        ],
                      ),
                      ...state.map((player) {
                          return TableRow(
                            children: [
                              TableCell(child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                    vertical: 4),
                                child: Center(child: state.indexOf(player) == 0
                                    ? const FaIcon(FontAwesomeIcons.trophy, size: 20)
                                    : Text((state.indexOf(player) + 1).toString())),
                              )),
                              TableCell(child: Center(child: Text(player.username ?? 'N/A', style: const TextStyle(fontSize: 20)))),
                              TableCell(child: Center(child: Text(_getScore(player, gameMode), style: const TextStyle(fontSize: 20)))),
                              TableCell(child: Center(child: Text(_getTime(player, gameMode), style: const TextStyle(fontSize: 20)))),
                            ],
                          );
                        }
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ),
        SizedBox(
          height: 40,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRouter.homePage);
            },
            child: const Icon(Icons.home_outlined, size: 30),
          ),
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(right: 50),
          child: Center(child: Text('Leaderboards')),
        ),
      ),
      bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          indicatorColor: Colors.deepPurple,
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
                icon: Icon(Icons.map),
                selectedIcon: Icon(Icons.map_outlined),
                label: 'Capitals'),
            NavigationDestination(
                icon: Icon(Icons.flag),
                selectedIcon: Icon(Icons.flag_circle),
                label: 'Flags')
          ]
      ),
      body: currentPageIndex == 0
          ? buildLeaderboard(gameModes[currentPageIndex])
          : currentPageIndex == 1
          ? buildLeaderboard(gameModes[currentPageIndex])
          : Container(),
    );
  }
}
