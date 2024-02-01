import 'package:flutter/widgets.dart';

class ColorConverter {
  static Color getColorFromHex(String colorCode) {
    String code = colorCode.substring(1);
    final String hexCode = "FF$code";
    return Color(int.parse("0x$hexCode"));
  }
}
