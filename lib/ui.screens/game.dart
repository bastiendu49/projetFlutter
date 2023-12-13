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
  static final List<String> _regions = ['Europe', 'Asia', 'North America', 'South America', 'Africa', 'Oceania', 'World'];
  late Timer _timer;
  int _secondsElapsed = 0;
  var score = 0;
  double latCenterMap = 45.72434685142984;
  double longCenterMap = 21.574331371307363;
  double zoom = 3.0;

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
    List<double> setCenter() {
      final regionSelected = ModalRoute.of(context)?.settings.arguments;
      List<double> position = [];
      if (regionSelected.toString().compareTo('Europe') == 0) {
        latCenterMap  = 48.741954625328475;
        longCenterMap = 7.163938133239736;
      }
      if (regionSelected.toString().compareTo('Asia') == 0) {
        latCenterMap  = 56.803096204200294;
        longCenterMap = 98.211287109375;
      }
      if (regionSelected.toString().compareTo('North America') == 0) {
        latCenterMap  = 55.393881785590715;
        longCenterMap = -103.17147526363959;
      }
      if (regionSelected.toString().compareTo('South America') == 0) {
        latCenterMap  = -17.51449963254834;
        longCenterMap = -58.16780600170723;
      }
      if (regionSelected.toString().compareTo('Africa') == 0) {
        latCenterMap  = 7.153929558901104;
        longCenterMap = 18.20416514008552;
      }
      if (regionSelected.toString().compareTo('Oceania') == 0) {
        latCenterMap  = -24.729866469462483;
        longCenterMap = 133.43742576022515;
      }
      position.add(latCenterMap);
      position.add(longCenterMap);
      return position;
    }

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
          center: LatLng(setCenter().first, setCenter().last), // Set the initial map center
          zoom: regionSelected.toString().compareTo('World') == 0 ? 1.0 : zoom,
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