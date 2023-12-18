

import 'package:latlong2/latlong.dart';

class Country {
  final String name;
  final String capital;
  final LatLng position;

  factory Country.fromGeoJson(String name, String capitale, LatLng position) {
    return Country(
      name: name,
      capital: capitale,
      position: position
    );
  }

  const Country({required this.name, required this.capital, required this.position});
}