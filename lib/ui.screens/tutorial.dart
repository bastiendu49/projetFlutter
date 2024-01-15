import 'dart:io';

import 'package:flutter/material.dart';

class Tutorial extends StatelessWidget {
  Tutorial({super.key, required int currentPageIndex, required Null Function(int index) onDestinationSelected});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(right: 50),
          child: Center(child: Text('Tutorial')),
        ),
        leading: const Icon(Icons.help_outline_outlined),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: <Widget> [
            Center(child: Text('Step 1 : Select a game mode ', style: TextStyle(fontSize: 20))),
            Divider(),
            SizedBox(height: 200,
              child: Column(
                children: <Widget>[
                  Expanded(child: SizedBox()),
                  Text('Select the game mode you want to play with.')
                ],
              ),
            ),
            Divider(),
            Center(child: Text('Step 2 : Enter a username ', style: TextStyle(fontSize: 20))),
            Divider(),
            SizedBox(height: 100, child: Image(image: AssetImage('assets/pictures/username.png'))),
            Divider(),
            Center(child: Text('Step 3 : Select a region ', style: TextStyle(fontSize: 20))),
            Divider(),
            SizedBox(height: 300,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 280, child: Image(image: AssetImage('assets/pictures/regions_list.png'))),
                  Text('Tap on the region you want to play in.')
                ],
              ),
            ),
            Divider(),
            Center(child: Text('Capitals Game : How to play ? ', style: TextStyle(fontSize: 20))),
            Divider(),
            SizedBox(height: 2000,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 400, child: Image(image: AssetImage('assets/pictures/maps.jpg'))),
                  Text('Tap on one of the markers.'),
                  SizedBox(height: 50),
                  SizedBox(height: 400, child: Image(image: AssetImage('assets/pictures/guess.jpg')),),
                  Text('Enter the capital of the country selected.'),
                  Expanded(child: SizedBox()),
                  Text('Once all capitals are found the game ends.'),
                  SizedBox(height: 200),
                  Text('Score calcul :\n< 3 mins : 100 pts\n> 3mins : - 3 pts /sec.'),
                ],
              ),
            ),
            Divider(),
            Center(child: Text('Step 4 : Beat the highscore ', style: TextStyle(fontSize: 20))),
            Divider(),
            SizedBox(height: 200, child: Image(image: AssetImage('assets/pictures/leaderboard.jpg'))),
            Text('Watch the best scores in the leader board view')
          ],
        ),
      ),
    );
  }
}
