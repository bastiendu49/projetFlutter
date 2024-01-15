/*import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../blocs/player_cubit.dart';
import '../models/player.dart';

class LeaderboardWidget extends StatefulWidget {
  const LeaderboardWidget({super.key});

  @override
  State<LeaderboardWidget> createState() => _LeaderboardWidgetState();

  class _LeaderboardWidgetState extends State<LeaderboardWidget> {
    @override
    Widget build(BuildContext context, String gameMode) {
      return Column(
        children: <Widget>[
          Text('$gameMode leaderboard : ', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Expanded(
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: BlocBuilder<PlayerCubit, List<Player>>(
                  //key: UniqueKey(),
                  builder: (context, state) {
                    print('here ${state.length}');
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
                          print(player.username);
                          return TableRow(
                            children: [
                              TableCell(child: Center(child: state.indexOf(player) == 0 ? const FaIcon(FontAwesomeIcons.trophy, size: 20) : Text((state.indexOf(player) + 1).toString()))),
                              TableCell(child: Center(child: Text(player.username ?? 'N/A', style: const TextStyle(fontSize: 20)))),
                              TableCell(child: Center(child: Text(_getScore(player, gameMode), style: const TextStyle(fontSize: 20)))),
                              TableCell(child: Center(child: Text(_getTime(player, gameMode), style: const TextStyle(fontSize: 20)))),
                            ],
                          );
                        },
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      );
    }
    }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

String _getScore(Player player, String gameMode) {
  return gameMode == 'Capitals' ? player.scoreCapitals.toString() ?? 'N/A' : player.scoreFlags.toString() ?? 'N/A';
}

String _getTime(Player player, String gameMode) {
  return gameMode == 'Capitals' ? player.timeCapitals.toString() ?? 'N/A' : player.timeFlags.toString() ?? 'N/A';
}
*/
