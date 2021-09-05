import 'package:flutter/material.dart';

InputDecoration buildInputDecoration({String? hintText, String? labelText}) {
  return InputDecoration(
      border: outlineInputBorder,
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      hintText: hintText == null ? "" : hintText,
      labelText: labelText == null ? "" : labelText,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      contentPadding: EdgeInsets.all(20),
      hintStyle: TextStyle(
        color: Colors.white.withOpacity(0.85),
      ),
      labelStyle: TextStyle(
          color: Colors.white.withOpacity(0.85),
          fontWeight: FontWeight.bold));
}

var outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(50),
  borderSide: BorderSide(color: Colors.white.withOpacity(0.5)),
  gapPadding: 5,
);