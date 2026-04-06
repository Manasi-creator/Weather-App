import 'package:flutter/material.dart';

class HourlyForecastItem extends StatelessWidget {
  final String time;
  final String temperature;
  final IconData icon;
  const HourlyForecastItem({
    super.key,
    required this.time,
    required this.temperature,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 40,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Text(
              time,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Icon(icon, size: 30),
            const SizedBox(height: 10),
            Text(temperature, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
