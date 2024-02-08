import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ColorConverter {
  static Color getColorFromName(String colorCode) {
    switch (colorCode.toLowerCase()) {
      case "red":
        return Colors.red;
      case "green":
        return Colors.green;
      case "white":
        return Colors.black;
      default:
        return Colors.grey;
    }
  }

  static String getColorNameFromColor(Color color) {
    if (color == Colors.red) {
      return "Red";
    }
    if (color == Colors.green) {
      return "Green";
    }
    if (color == Colors.black) {
      return "White";
    }
    return "White";
  }

  static Color getColorFromHex(String colorCode) {
    String code = colorCode.substring(1);
    final String hexCode = "FF$code";
    return Color(int.parse("0x$hexCode"));
  }
}
