import 'package:flutter/material.dart';
import 'package:jeu_geo/router.dart';

class GameLeadPage extends StatelessWidget {
  const GameLeadPage({super.key, required int currentPageIndex, required Null Function(int index) onDestinationSelected});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Select an option')),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 100),
              SizedBox(
                child: Column(
                  children: <Widget>[
                    const Icon(Icons.map_outlined, size: 80),
                    TextButton(
                        onPressed: (){
                          Navigator.of(context).pushNamed(AppRouter.gameSetupPage);
                        },
                        child: const Text('Play', style: TextStyle(fontSize: 30))
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 400,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 150),
                    const Icon(Icons.leaderboard_rounded, size: 80),
                    TextButton(
                        onPressed: (){
                          Navigator.of(context).pushNamed(AppRouter.leaderboardPage);
                        },
                        child: const Text('Leaderboard', style: TextStyle(fontSize: 30))
                    )
                  ],
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
