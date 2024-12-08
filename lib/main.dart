import 'package:flutter/material.dart';
import 'pages/weather_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.grey[50],
        brightness: Brightness.light
      ),
      darkTheme: ThemeData(
        primaryColor: Colors.grey[900],
        brightness: Brightness.dark
      ),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: WeatherPage(),
    );
  }
}