import 'package:flutter/material.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext contect) {
    return Scaffold(
      appBar : AppBar(
        title : const Text('Weather App', 
          style : TextStyle(
            fontWeight : FontWeight.bold,
            fontSize : 30,
          )),
        centerTitle : true,
        actions : [
          IconButton(
            onPressed : () {},
            icon : const Icon(Icon.refresh),
          ),
        ],
      ),
    );
  }
}
