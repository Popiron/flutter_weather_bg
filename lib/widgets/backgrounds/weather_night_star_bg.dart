import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_weather_bg/flutter_weather_bg.dart';
import 'package:flutter_weather_bg/widgets/painters/star_painter.dart';

class WeatherNightStarBg extends StatefulWidget {
  final WeatherType weatherType;

  WeatherNightStarBg({super.key, required this.weatherType});

  @override
  _WeatherNightStarBgState createState() => _WeatherNightStarBgState();
}

class _WeatherNightStarBgState extends State<WeatherNightStarBg>
    with SingleTickerProviderStateMixin {
  final List<StarParam> _starParams = [];
  final List<MeteorParam> _meteorParams = [];
  late final AnimationController _controller;

  late final double width;
  late final double height;
  late final double widthRatio;
  bool isMounted = false;

  @override
  void initState() {
    super.initState();
    initAnim();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchData();
      setState(() {
        isMounted = true;
      });
    });
  }

  void initAnim() {
    _controller = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    )..addListener(() {
        if (mounted) setState(() {});
      });
  }

  void fetchData() {
    Size size = SizeInherited.of(context).size;
    width = size.width;
    height = size.height;
    widthRatio = width / 392.0;
    initStarParams();
    _controller.repeat();
  }

  void initStarParams() {
    for (int i = 0; i < 100; i++) {
      var index = Random().nextInt(2);
      StarParam _starParam = StarParam(index);
      _starParam.init(width, height, widthRatio);
      _starParams.add(_starParam);
    }
    for (int i = 0; i < 4; i++) {
      MeteorParam param = MeteorParam();
      param.init(width, height, widthRatio);
      _meteorParams.add(param);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isMounted)
      return CustomPaint(
        painter: StarPainter(
          _starParams,
          _meteorParams,
          width,
          height,
          widthRatio,
        ),
      );

    return SizedBox.shrink();
  }
}
