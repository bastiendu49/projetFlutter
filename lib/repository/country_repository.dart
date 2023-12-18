import 'dart:convert';

import 'package:http/http.dart';
import 'package:jeu_geo/models/country.dart';
import 'package:latlong2/latlong.dart';

class CountryRepository {

  Future<List<Country>> fetchCountries(String query) async {
    final Response response;
    //final Response response = await get(Uri.parse('https://restcountries.com/v3.1/region/europe?fields=name,capital,capitalInfo'));
    if(query == "world"){
      response = await get(Uri.parse('https://restcountries.com/v3.1/all?fields=name,capital,capitalInfo'));
    }
    else {
      response = await get(Uri.parse(
          'https://restcountries.com/v3.1/region/$query?fields=name,capital,capitalInfo'));
    }
    //europe, asia, oceania, america, africa, https://restcountries.com/v3.1/all
    if (response.statusCode == 200) {
      final List<Country> countries = []; // Liste que la méthode va renvoyer

      // Transformation du JSON (String) en List<dynamic>
      final List<dynamic> jsonList = jsonDecode(response.body);
      for (final dynamic countryJson in jsonList) {
        if (countryJson.containsKey("name") &&
            countryJson.containsKey("capital") &&
            countryJson['capital'].length > 0 &&
            countryJson.containsKey("capitalInfo") &&
            countryJson["capitalInfo"].containsKey("latlng") &&
            countryJson["capitalInfo"]["latlng"] is List &&
            countryJson["capitalInfo"]["latlng"].length == 2) {
          final String names = countryJson['name']['common'];
          final String capitales = countryJson['capital'][0];
          final List<dynamic> positions = countryJson['capitalInfo']['latlng'];
          LatLng positionsLatLng = LatLng(positions[0] ?? 0.0, positions[1] ?? 0.0);
          final Country country = Country.fromGeoJson(names, capitales, positionsLatLng);
          countries.add(country);
        }
      }
      return countries;
    } else {
      throw Exception('Failed to load countries');
    }
  }


}