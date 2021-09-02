import 'package:flutter/material.dart';
import 'package:messenger_ui/content_type.dart';
import 'package:messenger_ui/host_api.dart';
import 'package:messenger_ui/model/chat_box.dart';
import 'package:messenger_ui/model/message.dart';
import 'package:messenger_ui/model/message_detail.dart';
import 'package:messenger_ui/model/messenger.dart';
import 'package:messenger_ui/screens/chat_box/chat_box_screen.dart';
import 'package:messenger_ui/widgets/avatar_chat_box.dart';
import 'package:messenger_ui/widgets/dot_seen.dart';
import 'package:messenger_ui/widgets/dot_send.dart';
import 'package:messenger_ui/widgets/message_status.dart';

class ChatBoxCard extends StatefulWidget {
  final ChatBox chatBox;

  ChatBoxCard({required this.chatBox});

  @override
  _ChatBoxCardState createState() => _ChatBoxCardState();
}

class _ChatBoxCardState extends State<ChatBoxCard> {

  late ChatBox chatBox;
  late Messenger guest;
  bool isSeen = false;
  late List<MessageDetail> details;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chatBox = widget.chatBox;
    guest = chatBox.guestUser.first;
    details = chatBox.lastMessage.details;
    details.removeWhere((detail) => detail.seenBy.id == chatBox.lastMessage.sender.id);
    if (details.isNotEmpty)
      isSeen = true;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(25),
      splashColor: Colors.pink.withOpacity(0.2),
      onTap: (){
        Navigator.popAndPushNamed(context, ChatBoxScreen.routeName, arguments: {"chatBox" : chatBox});
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.black.withOpacity(0.03)
        ),
        height: 70,
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AvatarChatBox(chatBox: chatBox),
            SizedBox(width: 20,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${chatBox.name != null ? chatBox.name : guest.nickName !=
                        null ? guest.nickName : guest.user.name}',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight:
                        isSeen ? FontWeight.normal : FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  buildLastMessage(message: chatBox.lastMessage),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Row buildLastMessage({required Message message}) {
    StringBuffer content = new StringBuffer();
    if (message.sender.id != chatBox.currentUser.id) {
      String name = message.sender.user.name;
      if (name.indexOf(" ") != -1) name = name.substring(0, name.indexOf(" "));
      content.write("$name: ");
    } else {
      content.write("you: ");
    }
    if (message.media != null) {
      if (message.media!.contentType == "sticker") {
        content.write("send a sticker");
      } else if (fileContentType.contains(message.media!.contentType)) {
        content.write("send a file");
      } else if (imageContentType.contains(message.media!.contentType)) {
        content.write("send a photo");
      }
      else {
        content.write("send a video");
      }
    } else {
      if (message.content!.length < 35)
        content.write("${message.content}");
      else
        content.write("${message.content!.substring(0, 35)}...");
    }
    Row row = new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          content.toString(),
          style: TextStyle(
              color: Colors.black,
              fontWeight: isSeen ? FontWeight.normal : FontWeight.bold),
        ),
        MessageStatus(message: message, currentUser: chatBox.currentUser)
      ],
    );
    return row;
  }



}
