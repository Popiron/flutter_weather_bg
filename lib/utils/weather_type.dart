import 'package:flutter/cupertino.dart';

enum WeatherType {
  heavyRain,
  heavySnow,
  middleSnow,
  thunder,
  lightRain,
  lightSnow,
  clearNight,
  sunny,
  cloudy,
  cloudyNight,
  middleRain,
  overcast,
  hazy,
  foggy,
  dusty;

  bool get isRainy =>
      this == WeatherType.lightRain ||
      this == WeatherType.middleRain ||
      this == WeatherType.heavyRain ||
      this == WeatherType.thunder;

  bool get isSnowy =>
      this == WeatherType.lightSnow ||
      this == WeatherType.middleSnow ||
      this == WeatherType.heavySnow;

  List<Color> get colors {
    switch (this) {
      case WeatherType.sunny:
        return [Color(0xFF0071D1), Color(0xFF6DA6E4)];
      case WeatherType.clearNight:
        return [Color(0xFF061E74), Color(0xFF275E9A)];
      case WeatherType.cloudy:
        return [Color(0xFF5C82C1), Color(0xFF95B1DB)];
      case WeatherType.cloudyNight:
        return [Color(0xFF2C3A60), Color(0xFF4B6685)];
      case WeatherType.overcast:
        return [Color(0xFF8FA3C0), Color(0xFF8C9FB1)];
      case WeatherType.lightRain:
        return [Color(0xFF556782), Color(0xFF7c8b99)];
      case WeatherType.middleRain:
        return [Color(0xFF3A4B65), Color(0xFF495764)];
      case WeatherType.heavyRain:
      case WeatherType.thunder:
        return [Color(0xFF3B434E), Color(0xFF565D66)];
      case WeatherType.hazy:
        return [Color(0xFF989898), Color(0xFF4B4B4B)];
      case WeatherType.foggy:
        return [Color(0xFFA6B3C2), Color(0xFF737F88)];
      case WeatherType.lightSnow:
        return [Color(0xFF6989BA), Color(0xFF9DB0CE)];
      case WeatherType.middleSnow:
        return [Color(0xFF8595AD), Color(0xFF95A4BF)];
      case WeatherType.heavySnow:
        return [Color(0xFF98A2BC), Color(0xFFA7ADBF)];
      case WeatherType.dusty:
        return [Color(0xFFB99D79), Color(0xFF6C5635)];
      default:
        return [Color(0xFF0071D1), Color(0xFF6DA6E4)];
    }
  }
}
