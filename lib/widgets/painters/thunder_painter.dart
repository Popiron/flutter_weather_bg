import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class ThunderPainter extends CustomPainter {
  var _paint = Paint();
  final List<ThunderParams> thunderParams;

  ThunderPainter(this.thunderParams);

  @override
  void paint(Canvas canvas, Size size) {
    if (thunderParams.isNotEmpty) {
      for (var param in thunderParams) {
        drawThunder(param, canvas, size);
      }
    }
  }

  void drawThunder(ThunderParams params, Canvas canvas, Size size) {
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
      params.alpha,
      0,
    ]);
    _paint.colorFilter = identity;
    canvas.scale(params.widthRatio * 1.2);
    canvas.drawImage(params.image, Offset(params.x, params.y), _paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class ThunderParams {
  final ui.Image image;
  final double width, height, widthRatio;

  ThunderParams(this.image, this.width, this.height, this.widthRatio);

  late double x;
  late double y;
  late double alpha;

  int get imgWidth => image.width;
  int get imgHeight => image.height;

  void reset() {
    x = Random().nextDouble() * 0.5 * widthRatio - 1 / 3 * imgWidth;
    y = Random().nextDouble() * -0.05 * height;
    alpha = 0;
  }
}
