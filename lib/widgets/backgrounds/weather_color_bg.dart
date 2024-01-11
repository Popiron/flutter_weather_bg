import 'package:flutter/material.dart';
import 'package:flutter_weather_bg/utils/weather_type.dart';

class WeatherColorBg extends StatelessWidget {
  final WeatherType weatherType;

  WeatherColorBg({super.key, required this.weatherType});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: WeatherUtil.getColor(weatherType),
          stops: [0, 1],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}
