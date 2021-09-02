import 'package:flutter/material.dart';

Color getColor(String? color) {
  switch (color) {
    case "RED":
      return Colors.red;
    case "PINK":
      return Colors.pink.withOpacity(0.7);
    default:
      return Colors.blue.withOpacity(0.8);
  }
}