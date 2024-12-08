import 'package:flutter/material.dart';
import 'package:weather_app/service/weather_service.dart';
import '../models/weather_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // api key
  final _weatherService = WeatherService('716f415c0a68a2ab4a0f4d6b3f133ac0');
  Weather? _weather;

  // fetch weather
  _fetchWeather() async {
    // get current city
    String cityName = await _weatherService.getCurrentCity();
    // String cityName = "Teresina";

    // get weather for the city
    try {
      final weather = await _weatherService.getWeather(cityName);
      print(weather);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print('ERROOOO: $e');
    }
  }

  // weather animations 

  // init state
  @override
  void initState() {
    super.initState();

    // fetch the weather on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // City Name
            Text(_weather?.cityName ?? "Loading city..."),
        
            // Temperature
            Text('${_weather?.temperature.round() ?? 'Loading temperature in '}°C'),
          ],
        ),
      ),
    );
  }
}