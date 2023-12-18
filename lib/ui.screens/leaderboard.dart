import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jeu_geo/models/player.dart';

import '../blocs/player_cubit.dart';

class LeaderboardPage extends StatefulWidget {
  LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {


  @override
  void initState() {
    super.initState();
    context.read<PlayerCubit>().loadPlayers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(right: 50),
          child: Center(child: Text('Leaderboard')),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: BlocBuilder<PlayerCubit, List<Player>>(
          builder: (context, state) {
            return Table(
              border: TableBorder.all(
                  borderRadius: BorderRadius.circular(10),
                  width: 1.5
              ),
              children: <TableRow>[
                const TableRow(
                  children: [
                    TableCell(child: Center(child: Text('Rank', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)))),
                    TableCell(child: Center(child: Text('Name', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)))),
                    TableCell(child: Center(child: Text('Score', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)))),
                    TableCell(child: Center(child: Text('Time', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)))),
                  ],
                ),
                ...state.map((player) =>
                    TableRow(
                      children: [
                    Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TableCell(child: Center(child: state.indexOf(player) == 0 ? const FaIcon(FontAwesomeIcons.trophy, size: 20) : Text((state.indexOf(player) + 1).toString()))),
                    ),
                    TableCell(child: Center(child: Text(player.username ?? 'N/A', style: const TextStyle(fontSize: 20)))),
                    TableCell(child: Center(child: Text(player.score?.toString() ?? 'N/A', style: const TextStyle(fontSize: 20)))),
                    TableCell(child: Center(child: Text(player.time ?? 'N/A', style: const TextStyle(fontSize: 20)))),

                    ]),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
