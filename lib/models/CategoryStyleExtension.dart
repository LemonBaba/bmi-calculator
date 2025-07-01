import 'package:flutter/material.dart';
import '../database/app_database.dart';

extension CategoryStyleExtension on CategoryData {
  Color get backgroundColor {
    switch (name) {
      case 'underweight':
        return Colors.blue.shade100;
      case 'normal':
        return Colors.green.shade100;
      case 'overweight':
        return Colors.orange.shade100;
      case 'obesity1':
        return Colors.deepOrange.shade200;
      case 'obesity2':
        return Colors.red.shade200;
      case 'obesity3':
        return Colors.red.shade400;
      default:
        return Colors.grey.shade300;
    }
  }

  TextStyle get textStyle {
    final brightness = ThemeData.estimateBrightnessForColor(backgroundColor);
    return TextStyle(
      color: brightness == Brightness.dark ? Colors.white : Colors.black,
      fontWeight: FontWeight.w600,
    );
  }
}
