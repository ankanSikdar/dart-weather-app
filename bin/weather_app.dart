import 'dart:io';

import 'package:weather_app/weather_api.dart';

void main(List<String> arguments) async {
  if (arguments.length != 1) {
    stdout.write('Usage: dart weather_app <city_name>');
    exit(1);
  }

  final api = WeatherApi();

  try {
    final weather = await api.getWeather(arguments[0]);
    print(weather);
  } on WeatherApiException catch (e) {
    print(e.error);
  } on SocketException catch (_) {
    print('ERROR: Check Your Internet Connection!');
  } on Exception catch (e) {
    print(e);
  }
}
