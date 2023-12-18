import 'dart:io';

import 'package:flutter/material.dart';

class Tutorial extends StatelessWidget {
  Tutorial({super.key, required int currentPageIndex, required Null Function(int index) onDestinationSelected});

  String usernameFilePath = '../pictures/username_input.jpg';

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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget> [
            Center(child: Text('Step 1 : Enter a username ', style: TextStyle(fontSize: 20))),
            Divider(),
            SizedBox(height: 200, child: Image.file(new File(usernameFilePath)),),
            Divider(),
            Center(child: Text('Step 2 : Select a region ', style: TextStyle(fontSize: 20))),
            Divider(),
            SizedBox(height: 200,
              child: Column(
                children: <Widget>[
                  Expanded(child: SizedBox()),
                  Text('Tap on the region you want to play in.')
                ],
              ),
            ),
            Divider(),
            Center(child: Text('Step 3 : Select a game mode ', style: TextStyle(fontSize: 20))),
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
            Center(child: Text('Step 4 : How to play ? ', style: TextStyle(fontSize: 20))),
            Divider(),
            SizedBox(height: 1000,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 200),
                  Text('Tap on one of the markers.'),
                  SizedBox(height: 200),
                  Text('Enter the capital of the country selected.'),
                  Expanded(child: SizedBox()),
                  Text('Once all capitals are found the game ends.'),
                  SizedBox(height: 200),
                  Text('Score calcul :\n< 3 mins : 100 pts\n> 3mins : - 3 pts /sec.')
                ],
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
