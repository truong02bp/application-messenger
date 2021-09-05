import 'package:flutter/material.dart';

Color getColor(String? color) {
  switch (color) {
    case "RED":
      return Colors.red;
    case "PINK_CUSTOM":
      return Color(0xfff78379).withOpacity(0.75);
    case "PINK":
      return Colors.pinkAccent.withOpacity(0.6);
    default:
      return Colors.blue.withOpacity(0.8);
  }
}