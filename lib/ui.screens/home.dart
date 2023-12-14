import 'package:flutter/material.dart';
import 'package:jeu_geo/ui.screens/game_lead.dart';
import 'package:jeu_geo/ui.screens/tutorial.dart';

import 'game_mode.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              icon: Icon(Icons.help),
              selectedIcon: Icon(Icons.help_outline_outlined),
              label: 'Help'),
          NavigationDestination(
              icon: Icon(Icons.play_arrow),
              selectedIcon: Icon(Icons.play_arrow_outlined),
              label: 'Play')
        ]
      ),
      body: currentPageIndex == 0
          ? Tutorial(
        currentPageIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          // Handle selection if needed
        },
      )
          : currentPageIndex == 1
          ? GameLeadPage(
        currentPageIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          // Handle selection if needed
        },
      )
          : Container()
    );
  }
}
