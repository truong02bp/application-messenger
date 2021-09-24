import 'package:flutter/material.dart';
import 'package:messenger_ui/bloc/chat_box_bloc.dart';
import 'package:messenger_ui/bloc/message_bloc.dart';
import 'package:messenger_ui/bloc_event/chat_box_event.dart';
import 'package:messenger_ui/bloc_event/message_event.dart';
import 'package:messenger_ui/bloc_state/chat_box_state.dart';
import 'package:messenger_ui/content_type.dart';
import 'package:messenger_ui/model/chat_box.dart';
import 'package:messenger_ui/model/dto/message_dto.dart';
import 'package:messenger_ui/model/message.dart';
import 'package:messenger_ui/model/message_detail.dart';
import 'package:messenger_ui/model/messenger.dart';
import 'package:messenger_ui/screens/chat_box/chat_box_screen.dart';
import 'package:messenger_ui/ultils/time_ultil.dart';
import 'package:messenger_ui/widgets/avatar_chat_box.dart';
import 'package:messenger_ui/widgets/message_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBoxCard extends StatefulWidget {
  final ChatBox chatBox;
  final Key key;
  ChatBoxCard({required this.key, required this.chatBox});

  @override
  _ChatBoxCardState createState() => _ChatBoxCardState();
}

class _ChatBoxCardState extends State<ChatBoxCard> {
  late ChatBox chatBox;
  late Messenger guest;
  late Message? lastMessage;
  bool isSeen = false;
  late List<MessageDetail> details = [];
  late ChatBoxBloc _chatBoxBloc;
  late MessageBloc _messageBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _chatBoxBloc = BlocProvider.of<ChatBoxBloc>(context);
    _messageBloc = BlocProvider.of<MessageBloc>(context);
    chatBox = widget.chatBox;
    guest = chatBox.guestUser.first;
    lastMessage = chatBox.lastMessage;
    if (lastMessage != null) {
      details.addAll(lastMessage!.details);
      details
          .removeWhere((detail) => detail.seenBy.id == lastMessage!.sender.id);
      if (lastMessage != null &&
          lastMessage!.sender.id == chatBox.currentUser.id) {
        isSeen = true;
      }
      if (details.isNotEmpty) {
        isSeen = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      key: widget.key,
      bloc: _chatBoxBloc,
      listener: (context, state) {
        if (state is UpdateMessageSeenSuccess &&
            state.chatBoxId == widget.chatBox.id &&
            state.messages.isNotEmpty) {
          if (state.messages[0].sender.id == widget.chatBox.currentUser.id) {
            setState(() {
              lastMessage = state.messages[0];
              isSeen = true;
            });
          }
        }
      },
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        splashColor: Colors.pink.withOpacity(0.2),
        onTap: () {
          // if (chatBox.lastMessage != null && chatBox.lastMessage!.sender.id != chatBox.currentUser.id && isSeen == false) {
          //   MessageDto messageDto = MessageDto(
          //       messengerId: chatBox.currentUser.id,
          //       chatBoxId: chatBox.id);
          //   _messageBloc.add(UpdateMessageEvent(messageDto: messageDto, option: "seen"));
          // }
          Navigator.popAndPushNamed(context, ChatBoxScreen.routeName,
              arguments: {"chatBox": chatBox});
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.black.withOpacity(0.03)),
          height: 70,
          padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AvatarChatBox(chatBox: chatBox),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${chatBox.name != null ? chatBox.name : guest.nickName != null ? guest.nickName : guest.user.name}',
                      style: TextStyle(
                          color: isSeen ? Colors.grey : Colors.white,
                          fontSize: 18),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    lastMessage != null
                        ? buildLastMessage(message: lastMessage)
                        : Container(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Row buildLastMessage({required Message? message}) {
    StringBuffer content = new StringBuffer();
    if (message!.sender.id != chatBox.currentUser.id) {
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
      } else {
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
            color: isSeen ? Colors.grey : Colors.white,
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Text(
          '${formatDateWithoutHour(time: message.createdDate)}',
          style: TextStyle(
            color: isSeen ? Colors.grey : Colors.white,
          ),
        ),
        Spacer(),
        MessageStatus(
          message: message,
          currentUser: chatBox.currentUser,
          color: chatBox.color,
        )
      ],
    );
    return row;
  }
}
