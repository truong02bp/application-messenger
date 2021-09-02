import 'package:flutter/material.dart';
import 'package:messenger_ui/model/chat_box.dart';
import 'package:messenger_ui/model/message.dart';
import 'package:messenger_ui/screens/chat_box/components/text_card.dart';
import 'package:messenger_ui/widgets/avatar_chat_box.dart';
import 'package:messenger_ui/widgets/message_status.dart';
import 'package:messenger_ui/widgets/time_bar.dart';

class MessageCard extends StatefulWidget {
  final Message message;
  final ChatBox chatBox;
  final bool showDate;
  final bool needBuildDot;

  MessageCard({required this.message, required this.chatBox, required this.showDate, required this.needBuildDot});

  @override
  _MessageCardState createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {

  late bool showDetail;

  @override
  void initState() {
    // TODO: implement initState
    showDetail = widget.showDate;
  }

  @override
  Widget build(BuildContext context) {
    bool isSender = widget.message.sender.id == widget.chatBox.currentUser.id;
    return Column(
      children: [
        widget.showDate || showDetail
            ? TimeBar(time: widget.message.createdDate)
            : Container(),
        Row(
          mainAxisAlignment:
              isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            isSender
                ? Container()
                : Container(
                    margin: EdgeInsets.only(right: 5),
                    child: AvatarChatBox(
                      chatBox: widget.chatBox,
                      height: 40,
                      width: 40,
                    )),
            Stack(children: [
              Container(
                constraints: new BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 2 / 3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey.withOpacity(0.12)),
                padding: EdgeInsets.all(10),
                child: TextCard(
                  text: widget.message.content,
                ),
              ),
              widget.needBuildDot ? Positioned(
                bottom: 0,
                  right: 0,
                  child: MessageStatus(currentUser: widget.chatBox.currentUser, message: widget.message, color: widget.chatBox.color,)
              ) : Container(),
            ]),
            // showDetail
            //     ? Padding(
            //   padding: const EdgeInsets.only(right: 20, left: 20),
            //   child: Row(
            //     mainAxisAlignment: widget.message.sender.id == widget.chatBox.currentUser.id
            //         ? MainAxisAlignment.end
            //         : MainAxisAlignment.start,
            //     children: [
            //       guestMessageDetail != null
            //           ? Text(
            //           'Seen at ${formatDate(time: guestMessageDetail.createdDate)}')
            //           : Text('Sent'),
            //     ],
            //   ),
            // )
            //     : Container()
          ],
        ),
      ],
    );
  }
}
