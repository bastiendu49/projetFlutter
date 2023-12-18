import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accueil'),
      ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            Navigator.of(context).pushNamed('/game') ;
          },
        ),
      bottomNavigationBar: NavigationBar(
        destinations: const <Widget>[
          NavigationDestination(
              icon: Icon(Icons.home),
              label: 'Home'),
          NavigationDestination(
              icon: Icon(Icons.play_arrow),
              label: 'Play'),
          NavigationDestination(
              icon: Icon(Icons.leaderboard),
              selectedIcon: Icon(Icons.leaderboard_outlined),
              label: 'Leaderboard')
        ],
      ),
    );
  }
}
