import 'package:flutter/material.dart';

class Tutorial extends StatelessWidget {
  const Tutorial({super.key, required int currentPageIndex, required Null Function(int index) onDestinationSelected});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('tuto'),
      ),
    );
  }
}
