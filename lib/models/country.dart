

import 'package:latlong2/latlong.dart';

class Country {
  final String name;
  final String? capital;
  final LatLng? position;
  final String? flag;

  factory Country.fromGeoJsonCapital(String name, String capitale, LatLng position) {
    return Country(
      name: name,
      capital: capitale,
      position: position,
      flag: null
    );
  }

  factory Country.fromGeoJsonFlag(String name, String flag) {
    return Country(
        name: name,
        capital: null,
        position: null,
        flag: flag
    );
  }

  const Country({required this.name, this.capital, this.position, this.flag});
}