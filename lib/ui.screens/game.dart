import 'dart:async';

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:jeu_geo/repository/country_repository.dart';
import 'package:flutter_map/flutter_map.dart';

import '../models/country.dart';

class Game extends StatefulWidget {

  const Game({Key? key}): super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  List<Country> _countries = [];

  final AddressRepository _addressRepository = AddressRepository();
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _fetchCountries();
  }

  Future<void> _fetchCountries() async {
    try {
      final List<Country> newCountries =
      await _addressRepository.fetchCountries('');
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
                  onPressed: () {
                    // Check if the entered capital is correct
                    if (capitalName.toLowerCase() ==
                        country.capital.toLowerCase()) {
                      // Capital is correct
                      isCapitalCorrect = true;
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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Rechercher un pays'),
        ),
        body: FlutterMap(
                  options: MapOptions(
                    center: LatLng(47.4784, -0.5632), // Set the initial map center
                    zoom: 4.0,
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
    );
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}
