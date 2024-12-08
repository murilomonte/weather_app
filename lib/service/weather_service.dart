import 'dart:convert';
// ignore: unused_import
import 'dart:developer';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const baseURL = "https://api.openweathermap.org/data/2.5/weather";
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String cityName) async {
    final response = await http
        .get(Uri.parse('$baseURL?q=$cityName&appid=$apiKey&units=metric'));

    // log(response.body);

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data.');
    }
  }

  Future<String> getCurrentCity() async {
    // Get persmission from user
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    // Fetch the current location
    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    Position position =
        await Geolocator.getCurrentPosition(locationSettings: locationSettings);
    // Convert the location info a list of placemark objects
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    // log('${position.longitude}, ${position.latitude}');

    // Extract the city name from the first placemark
    String? city = placemarks[0].locality;

    // log("$placemarks");

    // log("$city");
    if (city == ''){
      city = placemarks[0].subAdministrativeArea;
    }

    return city ?? "";
  }
}
