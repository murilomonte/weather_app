import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/service/weather_service.dart';
import '../models/weather_model.dart';
import 'dart:developer';
import 'package:google_fonts/google_fonts.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // api key
  final _weatherService = WeatherService('APIKEY');
  Weather? _weather;

  // fetch weather
  _fetchWeather() async {
    // get current city
    String cityName = await _weatherService.getCurrentCity();
    // String cityName = "Teresina";

    // get weather for the city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      log('$e');
    }
  }

  // weather animations
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/lottie/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/lottie/cloudy.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/lottie/rain.json';
      case 'thunderstorm':
        return 'assets/lottie/thunder.json';
      case 'clear':
        return 'assets/lottie/sunny.json';
      default:
        return 'assets/lottie/sunny.json';
    }
  }

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
      body: SafeArea(
        minimum: EdgeInsets.all(80), // Padding
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // City Name
              Column(
                children: [
                  Icon(
                    Icons.place,
                    size: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _weather?.cityName ?? "Loading city...",
                      style: GoogleFonts.bebasNeue(
                        fontSize: 25,
                      ),
                    ),
                  ),
                ],
              ),

              // Animation
              Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

              // Temperature
              Column(
                children: [
                  Text(
                    '${_weather?.temperature.round() ?? 'Loading temperature in '}°C',
                    style: GoogleFonts.bebasNeue(
                      fontSize: 50,
                      height: 1
                    ),
                  ),
                  // Weather condition
                  Text(_weather?.mainCondition ?? ""),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
