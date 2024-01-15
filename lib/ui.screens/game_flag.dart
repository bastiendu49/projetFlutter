import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:jeu_geo/blocs/player_cubit.dart';
import 'package:jeu_geo/models/player.dart';
import 'package:latlong2/latlong.dart';

import '../models/country.dart';
import '../repository/country_repository.dart';
import '../router.dart';


class GameFlag extends StatefulWidget {

  const GameFlag({
    Key? key,
  }) : super(key: key);

  @override
  State<GameFlag> createState() => _GameFlagState();
}

class _GameFlagState extends State<GameFlag> {
  List<Country> _countries = [];

  final CountryRepository _countryRepository = CountryRepository();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late Timer _timer;
  int _secondsElapsed = 0;
  int score = 0;
  int timeScore = 100000;
  double latCenterMap = 45.72434685142984;
  double longCenterMap = 21.574331371307363;
  double zoom = 3.2;
  bool isGamePaused = false;
  bool isGameEnded = false;
  int speedScoreDown = 83;
  int rightAnswerPoints = 100;
  var regionSelected;
  String countryName = ''; // Variable to store the entered capital name
  bool isCountryIncorrect = false;
  bool isCountryCorrect = false;

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
                            /*
                            Méthode pour relancer le jeu
                             */
                            //handleRestart();
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

  @override
  void didChangeDependencies() {
    regionSelected = ModalRoute.of(context)?.settings.arguments;
    _fetchFlags(regionSelected.toString().toLowerCase());
    super.didChangeDependencies();
  }

  void handleRestart() {
    resetTimer();
    _fetchFlags(regionSelected.toString().toLowerCase());
    Navigator.of(context).pop();
  }

  Future<void> _fetchFlags(String region) async {
    try {
      final List<Country> newCountries =
      await _countryRepository.fetchFlags(region);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      ListView.separated(
        itemCount: _countries.length,
        itemBuilder: (BuildContext context, int index) {
          final GlobalKey<FormState> _formKey = GlobalKey();
          final Country country = _countries[index];
          return Form(
              key: _formKey,
              child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Image.network(country.flag!, width: 100, height: 100),
                    ),
                    Expanded(child:
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                          onChanged: (value) {
                            /*setState(() {
                              countryName = value;
                              isCountryIncorrect = false;
                              isCountryCorrect = false;
                            });*/
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter a country name';
                            }
                            if (isCountryIncorrect) {
                              return 'Correct';
                            }
                            if (isCountryCorrect){
                              return 'Incorrect';
                            }
                            return null;
                          }
                      ),
                    ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ElevatedButton(
                          onPressed: () {
                            if (countryName.toLowerCase() ==
                                country.name.toLowerCase()
                            && _formKey.currentState!.validate()) {
                              // Capital is correct
                              score += rightAnswerPoints;
                              setState(() {
                                isCountryCorrect = true;
                              });
                            } else if (_formKey.currentState!.validate()) {
                              // Capital is incorrect
                              setState(() {
                                isCountryIncorrect = true;
                              });
                            }
                          },
                          child: Text('Submit')),
                    )
                  ]
              )
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(height: 10);
        },
      ),
      /*drawer: isGamePaused ? Drawer(
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
                /*
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
                PlayerCubit pc = context.read<PlayerCubit>();
                Player player = Player(
                  username: pc.currentUsername,
                  score: score + timeScore,
                  time: _formattedTime(),
                  hasHighscore: false,
                );
                // pc.setCurrentPlayer(player);
                print(pc.currentPlayer.username);
                pc.addPlayer(player);
                print("Player : ${player.username} |"
                    " ${player.score} |"
                    " ${player.time} |"
                    " ${player.hasHighscore}");
              },
            )
          ],
        ),
      )
          : null,*/
    );
  }
}