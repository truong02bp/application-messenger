import 'package:flutter/material.dart';
import 'package:messenger_ui/host_api.dart';
import 'package:messenger_ui/model/message.dart';
import 'package:messenger_ui/model/message_detail.dart';
import 'package:messenger_ui/model/messenger.dart';
import 'package:messenger_ui/ultils/ultil.dart';
import 'package:messenger_ui/widgets/dot_seen.dart';
import 'package:messenger_ui/widgets/dot_send.dart';

class MessageStatus extends StatelessWidget {

  final Message message;
  final Messenger currentUser;
  final String? color;

  MessageStatus({required this.message, required this.currentUser, this.color});

  @override
  Widget build(BuildContext context) {
    List<MessageDetail> details = [];
    details.addAll(message.details);
    details.removeWhere((element) => element.seenBy.id == currentUser.id);
    if (message.sender.id == currentUser.id) {
      if (details.isNotEmpty)
        return Row(
            children: List.generate(details.length, (index) => DotSeen(minioUrl + details[index].seenBy.user.avatar.url)));
      else
        return DotSend(color: getColor(color));
    }
    return Container();
  }
}
