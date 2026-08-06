
import 'package:flutter/material.dart';

class WeatherImagePlaceholder extends StatelessWidget {
  final double width;
  final IconData icon;

  const WeatherImagePlaceholder({super.key, 
    required this.width,
    this.icon = Icons.wb_cloudy_rounded,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [Colors.grey.shade200, Colors.grey.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(child: Icon(icon, size: 36, color: Colors.grey.shade400)),
    );
  }
}
