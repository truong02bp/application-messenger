import 'package:flutter/material.dart';
import 'package:messenger_ui/model/message_detail.dart';
import 'package:messenger_ui/ultils/time_ultil.dart';

class SeenInfo extends StatelessWidget {

  final bool isSender;
  final MessageDetail? detail;

  SeenInfo({required this.isSender, required this.detail});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20),
      child: Row(
        mainAxisAlignment: isSender
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          detail != null
              ? Text(
              'Seen at ${formatDate(time: detail!.createdDate)}')
              : Text('Sent'),
        ],
      ),
    );
  }
}
