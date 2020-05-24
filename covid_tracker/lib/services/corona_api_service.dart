import 'dart:convert';

import 'package:alpha2_countries/alpha2_countries.dart';
import 'package:covid_tracker/models/corono_data.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class CoronavirusService {
  final baseUrl = 'https://coronavirus-tracker-api.herokuapp.com/v2/';

  Future<CoronavirusData> getLatestData() async {
    final response = await http.get(baseUrl + 'latest');

    if (response.statusCode == 200) {
      return CoronavirusData.formatted(
        json: jsonDecode(response.body),
        country: 'Global',
      );
    } else {
      throw Exception('Failed to load latest coronavirus data.');
    }
  }

  Future<CoronavirusData> getLocationDataFromPlacemark(Placemark placemark) async {
    final response = await http.get(baseUrl + 'locations?country_code=${placemark.isoCountryCode}');

    if (response.statusCode == 200) {
      return CoronavirusData.formatted(
        json: jsonDecode(response.body),
        country: placemark.country,
      );
    } else {
      throw Exception('Failed to load local coronavirus data.');
    }
  }

  Future<CoronavirusData> getLocationDataFromCountryCode(String countryCode) async {
    final response = await http.get(baseUrl + 'locations?country_code=$countryCode');

    if (response.statusCode == 200) {
      return CoronavirusData.formatted(
        json: jsonDecode(response.body),
        country: Countries().resolveName(countryCode),
      );
    } else {
      throw Exception('Failed to load coronavirus data from search.');
    }
  }
}
