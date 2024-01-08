import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:jeu_geo/blocs/player_cubit.dart';
import 'package:jeu_geo/models/player.dart';
import 'package:latlong2/latlong.dart';

import '../models/country.dart';
import '../repository/country_repository.dart';
import '../router.dart';


class GameMaps extends StatefulWidget {

  const GameMaps({
    Key? key,
  }) : super(key: key);

  @override
  State<GameMaps> createState() => _GameMapsState();
}

class _GameMapsState extends State<GameMaps> {
  List<Country> _countries = [];

  final CountryRepository _countryRepository = CountryRepository();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late Timer _timer;
  int _secondsElapsed = 0;
  int score = 0;
  int timeScore = 100000;
  double latCenterMap = 45.72434685142984;
  double longCenterMap = 21.574331371307363;
  double zoom = 3.0;
  bool isGamePaused = false;
  bool isGameEnded = false;
  int speedScoreDown = 10000;
  var regionSelected;

  void gameEnd() {
    if (timeScore == 0) {
      pauseTimer();
      Future.delayed(Duration.zero, () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Center(child: Text('Time\'s up', style: TextStyle(fontSize: 35, color: Colors.red))),
              actions: <Widget>[
                Center(
                  child: Column(
                    children: <Widget>[
                      const Divider(),
                      TextButton(
                          onPressed: (){
                            /*TODO
                            Méthode pour relancer le jeu
                             */
                            handleRestart();
                          },
                          child: const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 75),
                                child: Text('Replay', style: TextStyle(fontSize: 20)),
                              ),
                              SizedBox(width: 40),
                              Icon(Icons.replay_outlined)
                            ],
                          )
                      ),
                      TextButton(
                          onPressed: (){
                            Navigator.of(context).pushNamed(AppRouter.gameSetupPage);
                          },
                          child: const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 90),
                                child: Text('Exit', style: TextStyle(fontSize: 20)),
                              ),
                              SizedBox(width: 40),
                              Icon(Icons.exit_to_app_outlined)
                            ],
                          )
                      ),
                      TextButton(
                          onPressed: (){
                            Navigator.of(context).pushNamed(AppRouter.leaderboardPage);
                          },
                          child: const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 40),
                                child: Text('Leaderboard', style: TextStyle(fontSize: 20)),
                              ),
                              SizedBox(width: 40),
                              Icon(Icons.leaderboard_rounded)
                            ],
                          )
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        _secondsElapsed++;
        timeScore-=speedScoreDown;
        gameEnd();
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
          timeScore-=speedScoreDown;
          gameEnd();
        });
      });
    }
  }

  void resetTimer() {
    setState(() {
      _secondsElapsed = 0;
      timeScore = 100000;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        _secondsElapsed++;
        timeScore-=speedScoreDown;
        gameEnd();
      });
    });
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
    resetTimer();
    _fetchCountries(regionSelected.toString().toLowerCase());
    Navigator.of(context).pop();
  }
  Future<void> _fetchCountries(String region) async {
    try {
      final List<Country> newCountries =
      await _countryRepository.fetchCountries(region);
      setState(() {
        _countries = newCountries;
      });
    } catch (e) {
      // Display an error message in case of an exception
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error fetching countries.'),
        ),
      );
    }
  }

  Future<void> _popupCountry(Country country) async {
    String capitalName = ''; // Variable to store the entered capital name
    bool isCapitalIncorrect = false; // Flag to track if the capital is incorrect
    bool isCapitalCorrect = false;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Country: ${country.name}'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Enter the capital name:'),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        capitalName = value;
                        isCapitalIncorrect = false; // Reset the flag on input change
                      });
                    },
                  ),
                  if (isCapitalIncorrect)
                    Text(
                      'Incorrect capital!',
                      style: TextStyle(color: Colors.red),
                    ),
                  if (isCapitalCorrect)
                    Text(
                      'Correct capital!',
                      style: TextStyle(color: Colors.green),
                    ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // Check if the entered capital is correct
                    if (capitalName.toLowerCase() ==
                        country.capital.toLowerCase()) {
                      // Capital is correct
                      setState(() {
                        isCapitalCorrect = true;
                      });
                      await Future.delayed(Duration(seconds: 1));
                      Navigator.of(context).pop();
                    } else {
                      // Capital is incorrect
                      setState(() {
                        isCapitalIncorrect = true;
                      });
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            );
          },
        );
      },
    );
    if(isCapitalCorrect){
      setState(() {
        _countries.remove(country);
      });
    }
  }

  @override
  void didChangeDependencies() {
    regionSelected = ModalRoute.of(context)?.settings.arguments;
    _fetchCountries(regionSelected.toString().toLowerCase());
    super.didChangeDependencies();
  }

  List<double> setCenter() {
    List<double> position = [];
    switch (regionSelected.toString().toLowerCase()) {
      case 'europe':
        latCenterMap  = 48.741954625328475;
        longCenterMap = 7.163938133239736;
      case 'asia':
        latCenterMap  = 24.03563274981771;
        longCenterMap = 93.11008154092768;
      case 'america':
        latCenterMap  = 16.469201618497905;
        longCenterMap = -77.45958386961784;
      case 'africa':
        latCenterMap  = 2.4622645746101868;
        longCenterMap = 11.598498915349595;
      case 'oceania':
        latCenterMap  = -15.091558350179024;
        longCenterMap = 149.31395075585948;
      default:
        latCenterMap = 45.72434685142984;
        longCenterMap = 21.574331371307363;
    }
    position.add(latCenterMap);
    position.add(longCenterMap);
    return position;
  }

  @override
  Widget build(BuildContext context) {

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
          MarkerLayerOptions(
            markers: _countries.map(
                  (Country country) {
                return Marker(
                  width: 40.0,
                  height: 40.0,
                  point: country.position,
                  builder: (BuildContext context) {
                    return IconButton(
                      icon: Icon(Icons.location_on),
                      onPressed: () {
                        _popupCountry(country);
                      },
                    );
                  },
                );
              },
            ).toList(),
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
                Navigator.of(context).pushNamed(AppRouter.gameSetupPage);
              },
              trailing: const Icon(Icons.exit_to_app_outlined),
            ),
            ListTile(
              title: const Text('Done', style: TextStyle(fontSize: 20)),
              onTap: () {
                Player player = Player(username: PlayerCubit().currentPlayer.username, score: score, time: _formattedTime(), hasHighscore: false);
                print("Player : ${PlayerCubit().currentPlayer.username} |"
                    " ${PlayerCubit().currentPlayer.score} |"
                    " ${PlayerCubit().currentPlayer.time} |"
                    " ${PlayerCubit().currentPlayer.hasHighscore}");
                //PlayerCubit().currentPlayer.score = score;
                //PlayerCubit().currentPlayer.time = _timer.toString();
              },
            )
          ],
        ),
      )
      : null,
    );
  }
}