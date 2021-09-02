import 'package:flutter/material.dart';
import 'package:messenger_ui/ultils/time_ultil.dart';
class TimeBar extends StatelessWidget {

  final DateTime time;

  TimeBar({required this.time});

  @override
  Widget build(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Center(
          child: Text(formatDate(time: time)),
        ),
      );
    }
}
