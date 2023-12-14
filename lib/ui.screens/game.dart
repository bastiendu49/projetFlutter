import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../router.dart';


class GameMaps extends StatefulWidget {

  const GameMaps({
    Key? key,
  }) : super(key: key);

  @override
  State<GameMaps> createState() => _GameMapsState();
}

class _GameMapsState extends State<GameMaps> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static final List<String> _regions = ['Europe', 'Asia', 'North America', 'South America', 'Africa', 'Oceania', 'World'];
  late Timer _timer;
  int _secondsElapsed = 0;
  int score = 0;
  double latCenterMap = 45.72434685142984;
  double longCenterMap = 21.574331371307363;
  double zoom = 3.0;
  bool isGamePaused = false;

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
      isGamePaused = true;
      _timer.cancel();
    }
  }

  void resumeTimer() {
    if (!_timer.isActive) {
      isGamePaused = false;
      _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
        setState(() {
          _secondsElapsed++;
        });
      });
    }
  }

  void resetTimer() {
    setState(() {
      _secondsElapsed = 0;
    });
    if (_timer.isActive) {
      _timer.cancel();
      _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
        setState(() {
          _secondsElapsed++;
        });
      });
    }
  }



  String _formattedTime() {
    Duration duration = Duration(seconds: _secondsElapsed);
    return '${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  void handlePauseMenu() {
    setState(() {
      isGamePaused = true;
    });
    _scaffoldKey.currentState?.openDrawer();
    pauseTimer();
  }

  void handleRestart() {
    pauseTimer();
  }

  @override
  Widget build(BuildContext context) {
    final regionSelected = ModalRoute.of(context)?.settings.arguments;
    List<double> setCenter() {
      final regionSelected = ModalRoute.of(context)?.settings.arguments;
      List<double> position = [];
      switch (regionSelected.toString()) {
        case 'Europe':
          latCenterMap  = 48.741954625328475;
          longCenterMap = 7.163938133239736;
        case 'Asia':
          latCenterMap  = 56.803096204200294;
          longCenterMap = 98.211287109375;
        case 'North America':
          latCenterMap  = 55.393881785590715;
          longCenterMap = -103.17147526363959;
        case 'South America':
          latCenterMap  = -17.51449963254834;
          longCenterMap = -58.16780600170723;
        case 'Africa':
          latCenterMap  = 7.153929558901104;
          longCenterMap = 18.20416514008552;
        case 'Oceania':
          latCenterMap  = -24.729866469462483;
          longCenterMap = 133.43742576022515;
        default:
          latCenterMap = 45.72434685142984;
          longCenterMap = 21.574331371307363;
      }
      position.add(latCenterMap);
      position.add(longCenterMap);
      return position;
    }

    return Scaffold(
      key: _scaffoldKey,
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
          onPressed: handlePauseMenu,
          icon: const Icon(Icons.menu_outlined)),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(setCenter().first, setCenter().last),
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
      drawer: isGamePaused ? Drawer(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.only(left: 90),
              child: Row(
                children: [
                  Icon(Icons.pause_outlined, size: 30,),
                  SizedBox(width: 10),
                  Text('Pause',
                        style: TextStyle(
                            fontSize: 30
                        ),
                  ),
                ],
              ),
            ),
            /*
            TextButton(
                onPressed: (){},
                child: ElevatedButton(
                  onPressed: () { },
                  child: const Text('Restart'),
                )
            ),*/
            const Divider(),
            ListTile(
              title: const Text('Resume',
                style: TextStyle(
                    fontSize: 20
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                isGamePaused = false;
                resumeTimer();
              },
              trailing: const Icon(Icons.play_arrow_outlined),
            ),
            ListTile(
              title: const Text('Restart',
                style: TextStyle(
                    fontSize: 20
                ),
              ),
              onTap: () {
                /*TODO
                Fonction permettant de relancer le jeu (génération de nouvelle capitale, redémarrage du timer)
                 */
                handleRestart();
              },
              trailing: const Icon(Icons.restart_alt_outlined),
            ),
            ListTile(
              title: const Text('Quit',
                style: TextStyle(
                    fontSize: 20
                ),
              ),
              onTap: () {
                Navigator.of(context).pushNamed(AppRouter.gameModePage);
              },
              trailing: const Icon(Icons.exit_to_app_outlined),
            ),
          ],
        ),
      )
      : null,
    );
  }
}