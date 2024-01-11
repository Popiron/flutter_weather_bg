import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_weather_bg/utils/image_utils.dart';
import 'dart:ui' as ui;

import 'package:flutter_weather_bg/utils/weather_type.dart';
import 'package:flutter_weather_bg/widgets/weather_bg.dart';

class WeatherRainSnowBg extends StatefulWidget {
  final WeatherType weatherType;
  final double viewWidth;
  final double viewHeight;

  WeatherRainSnowBg({
    super.key,
    required this.weatherType,
    required this.viewWidth,
    required this.viewHeight,
  });

  @override
  _WeatherRainSnowBgState createState() => _WeatherRainSnowBgState();
}

class _WeatherRainSnowBgState extends State<WeatherRainSnowBg>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final List<ui.Image> _images = [];
  final List<RainSnowParams> _rainSnows = [];
  int count = 0;
  bool isMounted = false;

  Future<void> fetchImages() async {
    final images = [
      await ImageUtils.getImage('images/rain.webp'),
      await ImageUtils.getImage('images/snow.webp'),
    ];
    _images.addAll(images);
  }

  Future<void> initParams() async {
    if (widget.viewWidth != 0 && widget.viewHeight != 0 && _rainSnows.isEmpty) {
      if (widget.weatherType.isSnowy || widget.weatherType.isRainy) {
        if (widget.weatherType == WeatherType.lightRain) {
          count = 70;
        } else if (widget.weatherType == WeatherType.middleRain) {
          count = 100;
        } else if (widget.weatherType == WeatherType.heavyRain ||
            widget.weatherType == WeatherType.thunder) {
          count = 200;
        } else if (widget.weatherType == WeatherType.lightSnow) {
          count = 30;
        } else if (widget.weatherType == WeatherType.middleSnow) {
          count = 100;
        } else if (widget.weatherType == WeatherType.heavySnow) {
          count = 200;
        }
        final widthRatio = SizeInherited.of(context).size.width / 392.0;
        final heightRatio = SizeInherited.of(context).size.height / 817;
        for (int i = 0; i < count; i++) {
          final rainSnow = RainSnowParams(
            widget.viewWidth,
            widget.viewHeight,
            widget.weatherType,
          );
          rainSnow.init(widthRatio, heightRatio);
          _rainSnows.add(rainSnow);
        }
      }
    }
    _controller.forward();
  }

  @override
  void didUpdateWidget(WeatherRainSnowBg oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.weatherType != widget.weatherType ||
        oldWidget.viewWidth != widget.viewWidth ||
        oldWidget.viewHeight != widget.viewHeight) {
      _rainSnows.clear();
      initParams();
    }
  }

  @override
  void initState() {
    super.initState();
    initAnim();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await fetchImages();
      initParams();
      setState(() {
        isMounted = true;
      });
    });
  }

  void initAnim() {
    _controller = AnimationController(
      duration: Duration(minutes: 1),
      vsync: this,
    )
      ..addListener(() {
        if (mounted) setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.repeat();
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isMounted) {
      return CustomPaint(painter: RainSnowPainter(this));
    }
    return SizedBox.shrink();
  }
}

class RainSnowPainter extends CustomPainter {
  final _paint = Paint();
  _WeatherRainSnowBgState _state;

  RainSnowPainter(this._state);

  @override
  void paint(Canvas canvas, Size size) {
    if (_state.widget.weatherType.isSnowy) {
      drawSnow(canvas, size);
    } else if (_state.widget.weatherType.isRainy) {
      drawRain(canvas, size);
    }
  }

  void drawRain(Canvas canvas, Size size) {
    if (_state._images.length > 1) {
      ui.Image image = _state._images[0];
      if (_state._rainSnows.isNotEmpty) {
        _state._rainSnows.forEach((element) {
          move(element);
          ui.Offset offset = ui.Offset(element.x, element.y);
          canvas.save();
          canvas.scale(element.scale);
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
            element.alpha,
            0,
          ]);
          _paint.colorFilter = identity;
          canvas.drawImage(image, offset, _paint);
          canvas.restore();
        });
      }
    }
  }

  void move(RainSnowParams params) {
    params.y = params.y + params.speed;
    if (_state.widget.weatherType.isSnowy) {
      double offsetX = sin(params.y / (300 + 50 * params.alpha)) *
          (1 + 0.5 * params.alpha) *
          params.widthRatio;
      params.x += offsetX;
    }
    if (params.y > params.height / params.scale) {
      params.y = -params.height * params.scale;
      if (_state.widget.weatherType.isRainy && _state._images.isNotEmpty) {
        params.y = -_state._images[0].height.toDouble();
      }
      params.reset();
    }
  }

  void drawSnow(Canvas canvas, Size size) {
    if (_state._images.length > 1) {
      ui.Image image = _state._images[1];
      if (_state._rainSnows.isNotEmpty) {
        _state._rainSnows.forEach((element) {
          move(element);
          ui.Offset offset = ui.Offset(element.x, element.y);
          canvas.save();
          canvas.scale(element.scale, element.scale);
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
            element.alpha,
            0,
          ]);
          _paint.colorFilter = identity;
          canvas.drawImage(image, offset, _paint);
          canvas.restore();
        });
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class RainSnowParams {
  late double x;

  late double y;

  late double speed;

  late double scale;

  double width;

  double height;

  late double alpha;

  WeatherType weatherType;

  late double widthRatio;
  late double heightRatio;

  RainSnowParams(this.width, this.height, this.weatherType);

  void init(widthRatio, heightRatio) {
    this.widthRatio = widthRatio;
    this.heightRatio = max(heightRatio, 0.65);

    reset();
    y = Random().nextInt(800 ~/ scale).toDouble();
  }

  void reset() {
    double ratio = 1.0;

    if (weatherType == WeatherType.lightRain) {
      ratio = 0.5;
    } else if (weatherType == WeatherType.middleRain) {
      ratio = 0.75;
    } else if (weatherType == WeatherType.heavyRain ||
        weatherType == WeatherType.thunder) {
      ratio = 1;
    } else if (weatherType == WeatherType.lightSnow) {
      ratio = 0.5;
    } else if (weatherType == WeatherType.middleSnow) {
      ratio = 0.75;
    } else if (weatherType == WeatherType.heavySnow) {
      ratio = 1;
    }
    if (weatherType.isRainy) {
      double random = 0.4 + 0.12 * Random().nextDouble() * 5;
      this.scale = random * 1.2;
      this.speed = 30 * random * ratio * heightRatio;
      this.alpha = random * 0.6;
      x = Random().nextInt(width * 1.2 ~/ scale).toDouble() -
          width * 0.1 ~/ scale;
    } else {
      double random = 0.4 + 0.12 * Random().nextDouble() * 5;
      this.scale = random * 0.8 * heightRatio;
      this.speed = 8 * random * ratio * heightRatio;
      this.alpha = random;
      x = Random().nextInt(width * 1.2 ~/ scale).toDouble() -
          width * 0.1 ~/ scale;
    }
  }
}
