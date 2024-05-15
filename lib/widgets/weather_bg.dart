import 'package:flutter/material.dart';
import 'package:flutter_weather_bg/utils/weather_type.dart';
import 'package:flutter_weather_bg/widgets/weather_item_bg.dart';

class WeatherBg extends StatefulWidget {
  final WeatherType weatherType;

  WeatherBg({super.key, required this.weatherType});

  @override
  _WeatherBgState createState() => _WeatherBgState();
}

class _WeatherBgState extends State<WeatherBg> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SizeInherited(
        size: Size(constraints.maxWidth, constraints.maxHeight),
        child: AnimatedSwitcher(
          child: WeatherItemBg(
              key: ValueKey(widget.weatherType),
              weatherType: widget.weatherType),
          duration: Duration(milliseconds: 500),
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
