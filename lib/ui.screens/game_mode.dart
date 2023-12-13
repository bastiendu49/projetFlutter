import 'package:flutter/material.dart';
import 'package:jeu_geo/router.dart';

class GameMode extends StatelessWidget {
  GameMode({
    Key? key,
    required this.currentPageIndex,
    required this.onDestinationSelected,
  }) : super(key: key);

  static final List<String> _regions = ['Europe', 'Asia', 'North America', 'Mid & South America', 'Africa', 'Oceania', 'World'];
  final int currentPageIndex;
  final Null Function(int index) onDestinationSelected;

  final TextEditingController _usernameController = TextEditingController();

  var isAuthenticated = false;

  var id = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Start playing'),
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
                children: _regions.map((region) {
                  return Card(
                    child: ListTile(
                      title: Text(region),
                      onTap: () {
                        if (_usernameController.text.isEmpty) {
                          _usernameController.text = 'Player$id';
                        }
                        Navigator.of(context).pushNamed(AppRouter.gamePage, arguments: region);
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
