import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_weather_bg/utils/image_utils.dart';
import 'package:flutter_weather_bg/utils/weather_type.dart';
import 'dart:ui' as ui;

import 'package:flutter_weather_bg/widgets/painters/thunder_painter.dart';
import 'package:flutter_weather_bg/widgets/weather_bg.dart';

class WeatherThunderBg extends StatefulWidget {
  final WeatherType weatherType;

  WeatherThunderBg({super.key, required this.weatherType});

  @override
  State<WeatherThunderBg> createState() => _WeatherCloudBgState();
}

class _WeatherCloudBgState extends State<WeatherThunderBg>
    with SingleTickerProviderStateMixin {
  final List<ui.Image> _images = [];
  final List<ThunderParams> _thunderParams = [];
  late final AnimationController _controller;
  bool isMounted = false;

  @override
  void initState() {
    super.initState();
    initAnim();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await fetchImages();
      initThunderParams();
    });
  }

  Future<void> fetchImages() async {
    final images = [
      await ImageUtils.getImage('images/lightning0.webp'),
      await ImageUtils.getImage('images/lightning1.webp'),
      await ImageUtils.getImage('images/lightning2.webp'),
      await ImageUtils.getImage('images/lightning3.webp'),
      await ImageUtils.getImage('images/lightning4.webp'),
    ];
    _images.addAll(images);
    setState(() {});
  }

  void initAnim() {
    _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reset();
          Future.delayed(Duration(milliseconds: 50)).then((value) {
            //initThunderParams();
            _controller.forward();
          });
        }
      });

    final tweenSequence = TweenSequence([
      TweenSequenceItem(
        tween: Tween(
          begin: 0.0,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 1.0,
          end: 0.0,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 3,
      ),
    ]);

    final animations = [
      tweenSequence.animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.3, curve: Curves.ease),
      )),
      tweenSequence.animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(0.2, 0.5, curve: Curves.ease),
      )),
      tweenSequence.animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(0.6, 0.9, curve: Curves.ease),
      ))
    ];

    animations[0].addListener(() {
      if (_thunderParams.isNotEmpty) {
        setState(() {
          _thunderParams[0].alpha = animations[0].value;
        });
      }
    });
    animations[1].addListener(() {
      if (_thunderParams.isNotEmpty) {
        setState(() {
          _thunderParams[1].alpha = animations[1].value;
        });
      }
    });
    animations[2].addListener(() {
      if (_thunderParams.isNotEmpty) {
        setState(() {
          _thunderParams[2].alpha = animations[2].value;
        });
      }
    });
  }

  void initThunderParams() {
    _thunderParams.clear();
    var size = SizeInherited.of(context).size;
    var width = size.width;
    var height = size.height;
    var widthRatio = size.width / 392.0;
    for (var i = 0; i < 3; i++) {
      var param = ThunderParams(
          _images[Random().nextInt(_images.length)], width, height, widthRatio);
      param.reset();
      _thunderParams.add(param);
    }
    _controller.forward();
    isMounted = true;
  }

  @override
  Widget build(BuildContext context) {
    if (isMounted) return CustomPaint(painter: ThunderPainter(_thunderParams));
    return SizedBox.shrink();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
