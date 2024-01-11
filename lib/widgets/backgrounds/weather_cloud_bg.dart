import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter_weather_bg/utils/image_utils.dart';
import 'package:flutter_weather_bg/utils/weather_type.dart';
import 'package:flutter_weather_bg/widgets/weather_bg.dart';

class WeatherCloudBg extends StatefulWidget {
  final WeatherType weatherType;

  WeatherCloudBg({super.key, required this.weatherType});

  @override
  _WeatherCloudBgState createState() => _WeatherCloudBgState();
}

class _WeatherCloudBgState extends State<WeatherCloudBg> {
  final List<ui.Image> _images = [];
  bool isMounted = false;

  Future<void> fetchImages() async {
    final images = [
      await ImageUtils.getImage('images/cloud.webp'),
      await ImageUtils.getImage('images/sun.webp')
    ];
    _images.addAll(images);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await fetchImages();
      isMounted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isMounted)
      return CustomPaint(
        painter: BgPainter(
          _images,
          widget.weatherType,
          SizeInherited.of(context).size.width / 392.0,
          SizeInherited.of(context).size.width,
        ),
      );
    return Container();
  }
}

class BgPainter extends CustomPainter {
  final List<ui.Image> images;
  final WeatherType weatherType;
  final double widthRatio;
  final double width;

  BgPainter(this.images, this.weatherType, this.widthRatio, this.width);

  final _paint = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    switch (weatherType) {
      case WeatherType.sunny:
        drawSunny(canvas, size);
        break;
      case WeatherType.cloudy:
        drawCloudy(canvas, size);
        break;
      case WeatherType.cloudyNight:
        drawCloudyNight(canvas, size);
        break;
      case WeatherType.overcast:
        drawOvercast(canvas, size);
        break;
      case WeatherType.lightRain:
        drawLightRainy(canvas, size);
        break;
      case WeatherType.middleRain:
        drawMiddleRainy(canvas, size);
        break;
      case WeatherType.heavyRain:
      case WeatherType.thunder:
        drawHeavyRainy(canvas, size);
        break;
      case WeatherType.hazy:
        drawHazy(canvas, size);
        break;
      case WeatherType.foggy:
        drawFoggy(canvas, size);
        break;
      case WeatherType.lightSnow:
        drawLightSnow(canvas, size);
        break;
      case WeatherType.middleSnow:
        drawMiddleSnow(canvas, size);
        break;
      case WeatherType.heavySnow:
        drawHeavySnow(canvas, size);
        break;
      case WeatherType.dusty:
        drawDusty(canvas, size);
        break;
      default:
        break;
    }
  }

  void drawSunny(Canvas canvas, Size size) {
    final image = images[0];
    final image1 = images[1];
    _paint.maskFilter = MaskFilter.blur(BlurStyle.normal, 40);
    canvas.save();
    final sunScale = 1.2 * widthRatio;
    canvas.scale(sunScale, sunScale);
    var offset = Offset(width.toDouble() - image1.width.toDouble() * sunScale,
        -image1.width.toDouble() / 2);
    canvas.drawImage(image1, offset, _paint);
    canvas.restore();

    canvas.save();
    final scale = 0.6 * widthRatio;
    ui.Offset offset1 = ui.Offset(-100, -100);
    canvas.scale(scale);
    canvas.drawImage(image, offset1, _paint);
    canvas.restore();
  }

  void drawCloudy(Canvas canvas, Size size) {
    ui.Image image = images[0];
    canvas.save();
    const identity = ColorFilter.matrix(<double>[
      1,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
      0,
      0,
      0,
      0,
      0.9,
      0,
    ]);
    _paint.colorFilter = identity;
    final scale = 0.8 * widthRatio;
    ui.Offset offset1 = ui.Offset(0, -200);
    ui.Offset offset2 = ui.Offset(-image.width / 2, -130);
    ui.Offset offset3 = ui.Offset(100, 0);
    canvas.scale(scale);
    canvas.drawImage(image, offset1, _paint);
    canvas.drawImage(image, offset2, _paint);
    canvas.drawImage(image, offset3, _paint);
    canvas.restore();
  }

  void drawCloudyNight(Canvas canvas, Size size) {
    ui.Image image = images[0];
    canvas.save();
    const identity = ColorFilter.matrix(<double>[
      0.32,
      0,
      0,
      0,
      0,
      0,
      0.39,
      0,
      0,
      0,
      0,
      0,
      0.52,
      0,
      0,
      0,
      0,
      0,
      0.9,
      0,
    ]);
    _paint.colorFilter = identity;
    final scale = 0.8 * widthRatio;
    ui.Offset offset1 = ui.Offset(0, -200);
    ui.Offset offset2 = ui.Offset(-image.width / 2, -130);
    ui.Offset offset3 = ui.Offset(100, 0);
    canvas.scale(scale, scale);
    canvas.drawImage(image, offset1, _paint);
    canvas.drawImage(image, offset2, _paint);
    canvas.drawImage(image, offset3, _paint);
    canvas.restore();
  }

  void drawOvercast(Canvas canvas, Size size) {
    ui.Image image = images[0];
    canvas.save();
    const identity = ColorFilter.matrix(<double>[
      1,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
      0,
      0,
      0,
      0,
      0.7,
      0,
    ]);
    _paint.colorFilter = identity;
    final scale = 0.8 * widthRatio;
    ui.Offset offset1 = ui.Offset(0, -200);
    ui.Offset offset2 = ui.Offset(-image.width / 2, -130);
    ui.Offset offset3 = ui.Offset(100, 0);
    canvas.scale(scale, scale);
    canvas.drawImage(image, offset1, _paint);
    canvas.drawImage(image, offset2, _paint);
    canvas.drawImage(image, offset3, _paint);
    canvas.restore();
  }

  void drawLightRainy(Canvas canvas, Size size) {
    ui.Image image = images[0];
    canvas.save();
    const identity = ColorFilter.matrix(<double>[
      0.45,
      0,
      0,
      0,
      0,
      0,
      0.52,
      0,
      0,
      0,
      0,
      0,
      0.6,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ]);
    _paint.colorFilter = identity;
    final scale = 0.8 * widthRatio;
    ui.Offset offset1 = ui.Offset(-380, -150);
    ui.Offset offset2 = ui.Offset(0, -60);
    ui.Offset offset3 = ui.Offset(0, 60);
    canvas.scale(scale);
    canvas.drawImage(image, offset1, _paint);
    canvas.drawImage(image, offset2, _paint);
    canvas.drawImage(image, offset3, _paint);
    canvas.restore();
  }

  void drawHazy(Canvas canvas, Size size) {
    ui.Image image = images[0];
    canvas.save();
    const identity = ColorFilter.matrix(<double>[
      0.67,
      0,
      0,
      0,
      0,
      0,
      0.67,
      0,
      0,
      0,
      0,
      0,
      0.67,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ]);
    _paint.colorFilter = identity;
    final scale = 2.0 * widthRatio;
    ui.Offset offset1 = ui.Offset(-image.width.toDouble() * 0.5, -200);
    canvas.scale(scale, scale);
    canvas.drawImage(image, offset1, _paint);
    canvas.restore();
  }

  void drawFoggy(Canvas canvas, Size size) {
    ui.Image image = images[0];
    canvas.save();
    const identity = ColorFilter.matrix(<double>[
      0.75,
      0,
      0,
      0,
      0,
      0,
      0.77,
      0,
      0,
      0,
      0,
      0,
      0.82,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ]);
    _paint.colorFilter = identity;
    final scale = 2.0 * widthRatio;
    ui.Offset offset1 = ui.Offset(-image.width.toDouble() * 0.5, -200);
    canvas.scale(scale, scale);
    canvas.drawImage(image, offset1, _paint);
    canvas.restore();
  }

  void drawDusty(Canvas canvas, Size size) {
    ui.Image image = images[0];
    canvas.save();
    const identity = ColorFilter.matrix(<double>[
      0.62,
      0,
      0,
      0,
      0,
      0,
      0.55,
      0,
      0,
      0,
      0,
      0,
      0.45,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ]);
    _paint.colorFilter = identity;
    final scale = 2.0 * widthRatio;
    ui.Offset offset1 = ui.Offset(-image.width.toDouble() * 0.5, -200);
    canvas.scale(scale, scale);
    canvas.drawImage(image, offset1, _paint);
    canvas.restore();
  }

  void drawHeavyRainy(Canvas canvas, Size size) {
    ui.Image image = images[0];
    canvas.save();
    const identity = ColorFilter.matrix(<double>[
      0.19,
      0,
      0,
      0,
      0,
      0,
      0.2,
      0,
      0,
      0,
      0,
      0,
      0.22,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ]);
    _paint.colorFilter = identity;
    final scale = 0.8 * widthRatio;
    ui.Offset offset1 = ui.Offset(-380, -150);
    ui.Offset offset2 = ui.Offset(0, -60);
    ui.Offset offset3 = ui.Offset(0, 60);
    canvas.scale(scale, scale);
    canvas.drawImage(image, offset1, _paint);
    canvas.drawImage(image, offset2, _paint);
    canvas.drawImage(image, offset3, _paint);
    canvas.restore();
  }

  void drawMiddleRainy(Canvas canvas, Size size) {
    ui.Image image = images[0];
    canvas.save();
    const identity = ColorFilter.matrix(<double>[
      0.16,
      0,
      0,
      0,
      0,
      0,
      0.22,
      0,
      0,
      0,
      0,
      0,
      0.31,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ]);
    _paint.colorFilter = identity;
    final scale = 0.8 * widthRatio;
    ui.Offset offset1 = ui.Offset(-380, -150);
    ui.Offset offset2 = ui.Offset(0, -60);
    ui.Offset offset3 = ui.Offset(0, 60);
    canvas.scale(scale, scale);
    canvas.drawImage(image, offset1, _paint);
    canvas.drawImage(image, offset2, _paint);
    canvas.drawImage(image, offset3, _paint);
    canvas.restore();
  }

  void drawLightSnow(Canvas canvas, Size size) {
    ui.Image image = images[0];
    canvas.save();
    const identity = ColorFilter.matrix(<double>[
      0.67,
      0,
      0,
      0,
      0,
      0,
      0.75,
      0,
      0,
      0,
      0,
      0,
      0.87,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ]);
    _paint.colorFilter = identity;
    final scale = 0.8 * widthRatio;
    ui.Offset offset1 = ui.Offset(-380, -100);
    ui.Offset offset2 = ui.Offset(0, -170);
    canvas.scale(scale, scale);
    canvas.drawImage(image, offset1, _paint);
    canvas.drawImage(image, offset2, _paint);
    canvas.restore();
  }

  void drawMiddleSnow(Canvas canvas, Size size) {
    ui.Image image = images[0];
    canvas.save();
    const identity = ColorFilter.matrix(<double>[
      0.7,
      0,
      0,
      0,
      0,
      0,
      0.77,
      0,
      0,
      0,
      0,
      0,
      0.87,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ]);
    _paint.colorFilter = identity;
    final scale = 0.8 * widthRatio;
    ui.Offset offset1 = ui.Offset(-380, -100);
    ui.Offset offset2 = ui.Offset(0, -170);
    canvas.scale(scale, scale);
    canvas.drawImage(image, offset1, _paint);
    canvas.drawImage(image, offset2, _paint);
    canvas.restore();
  }

  void drawHeavySnow(Canvas canvas, Size size) {
    ui.Image image = images[0];
    canvas.save();
    const identity = ColorFilter.matrix(<double>[
      0.74,
      0,
      0,
      0,
      0,
      0,
      0.74,
      0,
      0,
      0,
      0,
      0,
      0.81,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ]);
    _paint.colorFilter = identity;
    final scale = 0.8 * widthRatio;
    ui.Offset offset1 = ui.Offset(-380, -100);
    ui.Offset offset2 = ui.Offset(0, -170);
    canvas.scale(scale, scale);
    canvas.drawImage(image, offset1, _paint);
    canvas.drawImage(image, offset2, _paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
