import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather_app/additional_info_item.dart';
import 'package:weather_app/hourly_forecast_item.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      final apiKey = dotenv.env['API_KEY'];
      if (apiKey == null || apiKey.isEmpty) {
        throw 'API key not found. Set API_KEY in your .env file.';
      }

      String cityName = 'London';
      final res = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName,uk&APPID=$apiKey',
        ),
      );

      final data = jsonDecode(res.body);

      // if (data['cod'] != '200') {
      //   throw 'An unexpected error occurred';
      // }

      return data;

      //data['list'][0]['main']['temp'];
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext contect) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.refresh)),
        ],
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final data = snapshot.data;

          final currentTemp = data?['list'][0]['main']['temp'];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 40,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                '$currentTemp K',
                                style: const TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(Icons.cloud, size: 100),
                              Text('Rain', style: TextStyle(fontSize: 26)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                //weather forecast cards
                const SizedBox(height: 30),
                const Text(
                  'Weather Forecast',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      HourlyForecastItem(time: '09:00', temperature: '301.17'),
                      HourlyForecastItem(time: '12:00', temperature: '300.08'),
                      HourlyForecastItem(time: '15:00', temperature: '301.78'),
                      HourlyForecastItem(time: '18:00', temperature: '300.42'),
                      HourlyForecastItem(time: '21:00', temperature: '302.09'),
                      HourlyForecastItem(time: '24:00', temperature: '301.49'),
                      HourlyForecastItem(time: '03:00', temperature: '301.67'),
                      HourlyForecastItem(time: '06:00', temperature: '301.82'),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                //additional information cards
                const Text(
                  'Additional Information',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AdditionalInfoItem(
                      icon: Icons.water_drop,
                      label: 'Humidity',
                      value: '91',
                    ),
                    AdditionalInfoItem(
                      icon: Icons.air,
                      label: 'Wind Speed',
                      value: '7',
                    ),
                    AdditionalInfoItem(
                      icon: Icons.speed,
                      label: 'Pressure',
                      value: '1000',
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
