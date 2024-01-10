import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';

class ImageUtils {
  static Future<Image> getImage(String asset) async {
    ByteData data = await rootBundle.load("packages/flutter_weather_bg/$asset");
    Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }
}
