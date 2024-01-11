import 'package:flutter/material.dart';
import 'package:flutter_weather_bg/utils/weather_type.dart';
import 'package:flutter_weather_bg/widgets/backgrounds/weather_cloud_bg.dart';
import 'package:flutter_weather_bg/widgets/backgrounds/weather_color_bg.dart';
import 'package:flutter_weather_bg/widgets/backgrounds/weather_night_star_bg.dart';
import 'package:flutter_weather_bg/widgets/backgrounds/weather_rain_snow_bg.dart';
import 'package:flutter_weather_bg/widgets/backgrounds/weather_thunder_bg.dart';

class WeatherItemBg extends StatelessWidget {
  final WeatherType weatherType;
  final width;
  final height;

  WeatherItemBg({
    super.key,
    required this.weatherType,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: ClipRect(
        child: Stack(
          children: [
            WeatherColorBg(weatherType: weatherType),
            WeatherCloudBg(weatherType: weatherType),
            if (weatherType.isRainy || weatherType.isSnowy)
              WeatherRainSnowBg(
                weatherType: weatherType,
                viewWidth: width,
                viewHeight: height,
              ),
            if (weatherType == WeatherType.thunder)
              WeatherThunderBg(weatherType: weatherType),
            if (weatherType == WeatherType.clearNight)
              WeatherNightStarBg(weatherType: weatherType),
          ],
        ),
      ),
    );
  }
}
