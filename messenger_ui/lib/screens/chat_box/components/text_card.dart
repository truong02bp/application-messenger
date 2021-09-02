import 'package:flutter/material.dart';

class TextCard extends StatelessWidget {

  final String? text;

  TextCard({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text('$text',
        style: TextStyle(
            fontSize: 16,
            color: Colors.black.withOpacity(0.9)));
  }
}
