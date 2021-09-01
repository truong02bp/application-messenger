import 'package:flutter/material.dart';
class CustomIcon extends StatelessWidget {
  final String image;
  final double? width;
  final double? height;

  CustomIcon({required this.image, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(height == null ? 20 : height!/2),
      child: Container(
          width: width == null ? 40 : width,
          height: height == null ? 40 : height,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(height == null ? 20 : height!/2),
          ),
          child: Padding(
            padding: EdgeInsets.all(height == null ? 5 : height!/8),
            child: Image.asset(
              image,
            ),
          )),
    );
  }
}
