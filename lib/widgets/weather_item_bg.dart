import 'package:flutter/material.dart';
import 'package:flutter_weather_bg/flutter_weather_bg.dart';
import 'package:flutter_weather_bg/widgets/backgrounds/weather_cloud_bg.dart';
import 'package:flutter_weather_bg/widgets/backgrounds/weather_color_bg.dart';
import 'package:flutter_weather_bg/widgets/backgrounds/weather_night_star_bg.dart';
import 'package:flutter_weather_bg/widgets/backgrounds/weather_rain_snow_bg.dart';
import 'package:flutter_weather_bg/widgets/backgrounds/weather_thunder_bg.dart';

class WeatherItemBg extends StatelessWidget {
  final WeatherType weatherType;

  const WeatherItemBg({super.key, required this.weatherType});

  @override
  Widget build(BuildContext context) {
    final size = SizeInherited.of(context).size;
    return ClipRect(
      child: Stack(
        children: [
          WeatherColorBg(weatherType: weatherType),
          WeatherCloudBg(weatherType: weatherType),
          if (weatherType.isRainy || weatherType.isSnowy)
            WeatherRainSnowBg(
              weatherType: weatherType,
              viewWidth: size.width,
              viewHeight: size.height,
            ),
          if (weatherType == WeatherType.thunder)
            WeatherThunderBg(weatherType: weatherType),
          if (weatherType == WeatherType.clearNight)
            WeatherNightStarBg(weatherType: weatherType),
        ],
      ),
    );
  }
}
