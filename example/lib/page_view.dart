import 'package:flutter/material.dart';
import 'package:flutter_weather_bg/flutter_weather_bg.dart';

class PageViewWidget extends StatelessWidget {
  const PageViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: [
              WeatherBg(
                weatherType: WeatherType.values[index],
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              Center(
                child: Text(
                  WeatherType.values[index].toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          );
        },
        itemCount: WeatherType.values.length,
      ),
    );
  }
}
