import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jeu_geo/router.dart';

import '../blocs/player_cubit.dart';

class GameSetup extends StatefulWidget {
  const GameSetup({
    Key? key
  }) : super(key: key);

  static final List<String> _regions = ['Europe', 'Asia', 'America', 'Africa', 'Oceania', 'World'];


  @override
  State<GameSetup> createState() => _GameSetupState();
}

class _GameSetupState extends State<GameSetup> {
  final TextEditingController _usernameController = TextEditingController();
  PlayerCubit pc = PlayerCubit();

  var id = 1;

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
          child: Center(child: Text('Start playing')),
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your username',
              ),
            ),
          ),
          const Column(
            children: <Widget> [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Text(
                  'Select a region',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ]
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
              child: ListView(
                children: GameSetup._regions.map((region) {
                  return Card(
                    child: ListTile(
                      title: Text(region),
                      onTap: () {
                        String username = _usernameController.text.isNotEmpty
                            ? _usernameController.text
                            : 'Player$id';
                        pc.setUsername(username);
                        PlayerCubit().currentPlayer.username = username;
                        Navigator.of(context).pushNamed(AppRouter.gamePage, arguments: region);
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRouter.homePage);
            },
            child: const Icon(Icons.home_outlined, size: 30))
        ],
      ),
    );
  }
}
