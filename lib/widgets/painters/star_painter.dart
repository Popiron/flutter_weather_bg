import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class StarPainter extends CustomPainter {
  final _paint = Paint();
  final _meteorPaint = Paint();
  final List<StarParam> _starParams;

  final width;
  final height;
  final widthRatio;

  final List<MeteorParam> _meteorParams;

  final double _meteorWidth = 200;

  final double _meteorHeight = 2;

  final Radius _radius = Radius.circular(10);

  StarPainter(
    this._starParams,
    this._meteorParams,
    this.width,
    this.height,
    this.widthRatio,
  ) {
    _paint.maskFilter = MaskFilter.blur(BlurStyle.normal, 1);
    _paint.color = Colors.white;
    _paint.style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (_starParams.isNotEmpty) {
      for (var param in _starParams) {
        drawStar(param, canvas);
      }
    }
    if (_meteorParams.isNotEmpty) {
      for (var param in _meteorParams) {
        drawMeteor(param, canvas);
      }
    }
  }

  void drawMeteor(MeteorParam param, Canvas canvas) {
    canvas.save();
    var gradient = ui.Gradient.linear(
      const Offset(0, 0),
      Offset(_meteorWidth, 0),
      <Color>[const Color(0xFFFFFFFF), const Color(0x00FFFFFF)],
    );
    _meteorPaint.shader = gradient;
    canvas.rotate(pi * param.radians);
    canvas.scale(widthRatio);
    canvas.translate(
        param.translateX, tan(pi * 0.1) * _meteorWidth + param.translateY);
    canvas.drawRRect(
        RRect.fromLTRBAndCorners(0, 0, _meteorWidth, _meteorHeight,
            topLeft: _radius,
            topRight: _radius,
            bottomRight: _radius,
            bottomLeft: _radius),
        _meteorPaint);
    param.move();
    canvas.restore();
  }

  void drawStar(StarParam param, Canvas canvas) {
    canvas.save();
    var identity = ColorFilter.matrix(<double>[
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
      param.alpha,
      0,
    ]);
    _paint.colorFilter = identity;
    canvas.scale(param.scale);
    canvas.drawCircle(Offset(param.x, param.y), 3, _paint);
    canvas.restore();
    param.move();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class MeteorParam {
  late double translateX;
  late double translateY;
  late double radians;

  late double width, height, widthRatio;

  void init(width, height, widthRatio) {
    this.width = width;
    this.height = height;
    this.widthRatio = widthRatio;
    reset();
  }

  void reset() {
    translateX = width + Random().nextDouble() * 20.0 * width;
    radians = -Random().nextDouble() * 0.07 - 0.05;
    translateY = Random().nextDouble() * 0.5 * height * widthRatio;
  }

  void move() {
    translateX -= 20;
    if (translateX <= -1.0 * width / widthRatio) {
      reset();
    }
  }
}

class StarParam {
  late double x;

  late double y;

  late double alpha = 0.0;

  late double scale;

  late bool reverse = false;

  int index;

  late double width;

  late double height;

  late double widthRatio;

  StarParam(this.index);

  void reset() {
    alpha = 0;
    double baseScale = index == 0 ? 0.7 : 0.5;
    scale = (Random().nextDouble() * 0.1 + baseScale) * widthRatio;
    x = Random().nextDouble() * 1 * width / scale;
    y = Random().nextDouble() * max(0.3 * height, 150);
    reverse = false;
  }

  void init(width, height, widthRatio) {
    this.width = width;
    this.height = height;
    this.widthRatio = widthRatio;
    alpha = Random().nextDouble();
    double baseScale = index == 0 ? 0.7 : 0.5;
    scale = (Random().nextDouble() * 0.1 + baseScale) * widthRatio;
    x = Random().nextDouble() * 1 * width / scale;
    y = Random().nextDouble() * max(0.3 * height, 150);
    reverse = false;
  }

  void move() {
    if (reverse == true) {
      alpha -= 0.01;
      if (alpha < 0) {
        reset();
      }
    } else {
      alpha += 0.01;
      if (alpha > 1.2) {
        reverse = true;
      }
    }
  }
}
