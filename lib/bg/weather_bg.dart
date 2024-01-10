import 'package:flutter/material.dart';
import 'package:flutter_weather_bg/bg/weather_cloud_bg.dart';
import 'package:flutter_weather_bg/bg/weather_color_bg.dart';
import 'package:flutter_weather_bg/bg/weather_night_star_bg.dart';
import 'package:flutter_weather_bg/bg/weather_rain_snow_bg.dart';
import 'package:flutter_weather_bg/bg/weather_thunder_bg.dart';
import 'package:flutter_weather_bg/utils/weather_type.dart';

class WeatherBg extends StatefulWidget {
  final WeatherType weatherType;
  final double width;
  final double height;

  WeatherBg({
    super.key,
    required this.weatherType,
    required this.width,
    required this.height,
  });

  @override
  _WeatherBgState createState() => _WeatherBgState();
}

class _WeatherBgState extends State<WeatherBg>
    with SingleTickerProviderStateMixin {
  late WeatherType _oldWeatherType;
  bool needChange = false;
  CrossFadeState state = CrossFadeState.showSecond;

  @override
  void initState() {
    super.initState();
    _oldWeatherType = widget.weatherType;
  }

  @override
  void didUpdateWidget(WeatherBg oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.weatherType != oldWidget.weatherType) {
      _oldWeatherType = oldWidget.weatherType;
      needChange = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final oldWeather = WeatherItemBg(
      weatherType: _oldWeatherType,
      width: widget.width,
      height: widget.height,
    );
    final currentWeather = WeatherItemBg(
      weatherType: widget.weatherType,
      width: widget.width,
      height: widget.height,
    );

    var firstWidget = currentWeather;
    var secondWidget = currentWeather;
    if (needChange) {
      if (state == CrossFadeState.showSecond) {
        state = CrossFadeState.showFirst;
        firstWidget = currentWeather;
        secondWidget = oldWeather;
      } else {
        state = CrossFadeState.showSecond;
        secondWidget = currentWeather;
        firstWidget = oldWeather;
      }
    }
    needChange = false;
    return SizeInherited(
      child: AnimatedCrossFade(
        firstChild: firstWidget,
        secondChild: secondWidget,
        duration: Duration(milliseconds: 300),
        crossFadeState: state,
      ),
      size: Size(widget.width, widget.height),
    );
  }
}

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

  Widget _buildNightStarBg() {
    if (weatherType == WeatherType.sunnyNight) {
      return WeatherNightStarBg(
        weatherType: weatherType,
      );
    }
    return Container();
  }

  Widget _buildThunderBg() {
    if (weatherType == WeatherType.thunder) {
      return WeatherThunderBg(
        weatherType: weatherType,
      );
    }
    return Container();
  }

  Widget _buildRainSnowBg() {
    if (WeatherUtil.isSnowRain(weatherType)) {
      return WeatherRainSnowBg(
        weatherType: weatherType,
        viewWidth: width,
        viewHeight: height,
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: ClipRect(
        child: Stack(
          children: [
            WeatherColorBg(
              weatherType: weatherType,
              height: null,
            ),
            WeatherCloudBg(
              weatherType: weatherType,
            ),
            _buildRainSnowBg(),
            _buildThunderBg(),
            _buildNightStarBg(),
          ],
        ),
      ),
    );
  }
}

class SizeInherited extends InheritedWidget {
  final Size size;

  const SizeInherited({
    super.key,
    required super.child,
    required this.size,
  });

  static SizeInherited of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SizeInherited>()!;
  }

  @override
  bool updateShouldNotify(SizeInherited old) {
    return old.size != size;
  }
}
