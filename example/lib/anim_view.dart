import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_weather_bg/flutter_weather_bg.dart';

class AnimViewWidget extends StatefulWidget {
  const AnimViewWidget({super.key});

  @override
  State<AnimViewWidget> createState() => _AnimViewWidgetState();
}

class _AnimViewWidgetState extends State<AnimViewWidget> {
  WeatherType weatherType = WeatherType.sunny;
  late final StreamSubscription<WeatherType> weatherStreamSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      weatherStreamSubscription = Stream<WeatherType>.periodic(
        const Duration(seconds: 3),
        (_) => WeatherType.values[Random().nextInt(WeatherType.values.length)],
      ).listen((weather) {
        setState(() {
          weatherType = weather;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AnimView"),
      ),
      body: Stack(
        children: [
          WeatherBg(weatherType: weatherType),
          Center(
            child: Text(
              weatherType.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    weatherStreamSubscription.cancel();
    super.dispose();
  }
}
