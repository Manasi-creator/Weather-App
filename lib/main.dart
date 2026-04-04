import 'package:flutter/material.dart';
import 'package:weather_app/weather_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext contect) {
    return MaterialApp(
      debugShowCheckedModeBanner : false,
      theme : ThemeData.dark(useMaterial3 : true),
      home : const WeatherScreen(),
    );
  }
}
