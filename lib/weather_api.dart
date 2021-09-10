import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:weather_app/weather.dart';

class WeatherApiException implements Exception {
  final String error;

  WeatherApiException(this.error);
}

class WeatherApi {
  Future<int> _getLocationId(String city) async {
    final url = 'https://www.metaweather.com/api/location/search/?query=$city';

    stdout.write('Getting city details...\n');

    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw WeatherApiException('ERROR: Something went wrong!');
    }
    final json = jsonDecode(response.body) as List;
    if (json.isEmpty) {
      throw WeatherApiException('ERROR: Incorrect City Name');
    }
    return json[0]['woeid'];
  }

  Future<Weather> _getWeatherData(int woeid) async {
    final url = 'https://www.metaweather.com/api/location/$woeid';

    stdout.write('Getting weather details...\n');
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw WeatherApiException('ERROR: Something went wrong!');
    }
    return Weather.fromJson(response.body);
  }

  Future<Weather> getWeather(String city) async {
    final woeid = await _getLocationId(city);
    final weather = await _getWeatherData(woeid);
    return weather;
  }
}
