import 'dart:convert';

class Weather {
  final String city;
  final double temp;
  final double maxTemp;
  final double minTemp;
  final String weatherState;

  Weather({
    required this.city,
    required this.temp,
    required this.maxTemp,
    required this.minTemp,
    required this.weatherState,
  });

  factory Weather.fromMap(Map<String, dynamic> map) {
    final data = map['consolidated_weather'][0];

    return Weather(
      city: map['title'],
      temp: data['the_temp'] as double,
      maxTemp: data['max_temp'] as double,
      minTemp: data['min_temp'] as double,
      weatherState: data['weather_state_name'],
    );
  }

  factory Weather.fromJson(String source) =>
      Weather.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Currently its $weatherState at $city\nCurrent Temp: ${temp.toStringAsFixed(2)} C\nMin Temp: ${minTemp.toStringAsFixed(2)} C\nMax Temp: ${maxTemp.toStringAsFixed(2)} C';
  }
}
