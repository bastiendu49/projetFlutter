import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';


class GameMaps extends StatefulWidget {

  const GameMaps({
    Key? key,
  }) : super(key: key);

  @override
  State<GameMaps> createState() => _GameMapsState();
}

class _GameMapsState extends State<GameMaps> {
  static final List<String> _regions = ['Europe', 'Asia', 'North America', 'Mid & South America', 'Africa', 'Oceania', 'World'];
  late Timer _timer;
  int _secondsElapsed = 0;
  var score = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        _secondsElapsed++;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void pauseTimer() {
    if (_timer.isActive) {
      _timer.cancel();
    }
  }


  String _formattedTime() {
    Duration duration = Duration(seconds: _secondsElapsed);
    return '${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }
  @override
  Widget build(BuildContext context) {
    final regionSelected = ModalRoute.of(context)?.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text('Score : $score'),
                ),
                const SizedBox(width: 60),
                const Icon(Icons.timer_outlined),
                Text(' : ${_formattedTime()}'),
              ],
            )
        ) ,
        leading: IconButton(
          onPressed: () {  },
          icon: const Icon(Icons.menu_outlined)),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(47.4784, -0.5632), // Set the initial map center
          zoom: 11.0,
        ),
        layers: [
          TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
              keepBuffer: 20,
              tileProvider: NetworkTileProvider()
          ),
        ],
      ),
    );
  }
}