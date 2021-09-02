import 'package:flutter/material.dart';
import 'package:messenger_ui/model/chat_box.dart';
import 'package:messenger_ui/model/message.dart';
import 'package:messenger_ui/screens/chat_box/components/text_card.dart';
import 'package:messenger_ui/ultils/ultil.dart';
import 'package:messenger_ui/widgets/avatar_chat_box.dart';
import 'package:messenger_ui/widgets/message_status.dart';
import 'package:messenger_ui/widgets/time_bar.dart';

class MessageCard extends StatefulWidget {
  final Message message;
  final ChatBox chatBox;
  final bool showDate;
  final bool needBuildDot;

  MessageCard(
      {required this.message,
      required this.chatBox,
      required this.showDate,
      required this.needBuildDot});

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
    Color color;
    if (widget.chatBox.color == null){
      color = Colors.grey.withOpacity(0.12);
    }
    else
      color = getColor(widget.chatBox.color);
    return Column(
      children: [
        widget.showDate || showDetail
            ? TimeBar(time: widget.message.createdDate)
            : Container(),
        Row(
          mainAxisAlignment:
              isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            !isSender
                ? Container(
                    margin: EdgeInsets.only(right: 5),
                    child: AvatarChatBox(
                      chatBox: widget.chatBox,
                      height: 35,
                      width: 35,
                    ))
                : Container(),
            Stack(children: [
              !isSender ? Positioned(
                  bottom: -2,
                  left: -1,
                  child: CustomPaint(
                    painter: ChatBubbleTriangle(isSender: isSender, color: color),
                  )
              ) : Container(),
              Container(
                constraints: new BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 2 / 3),
                decoration: BoxDecoration(
                    borderRadius: isSender ?
                    BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15), bottomLeft: Radius.circular(15), bottomRight: Radius.circular(9))
                    : BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15), bottomLeft: Radius.circular(9), bottomRight: Radius.circular(15)),
                    color: color),
                padding:
                    EdgeInsets.only(left: 10, right: 10, bottom: 7, top: 7),
                child: TextCard(
                  text: widget.message.content,
                ),
              ),
              widget.needBuildDot
                  ? Positioned(
                      bottom: 0,
                      right: 0,
                      child: MessageStatus(
                        currentUser: widget.chatBox.currentUser,
                        message: widget.message,
                        color: widget.chatBox.color,
                      ))
                  : Container(),
              isSender ? Positioned(
                  bottom: -2,
                  right: -1,
                  child: CustomPaint(
                    painter: ChatBubbleTriangle(isSender: isSender, color: color),
                  )
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

class ChatBubbleTriangle extends CustomPainter {

  final Color color;
  final bool isSender;


  ChatBubbleTriangle({required this.color, required this.isSender});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    Path paintBubbleTail() {
      Path path;
      if (!isSender) {
        path = Path()
          ..moveTo(5, size.height - 5)
          ..quadraticBezierTo(-5, size.height, -16, size.height - 4)
          ..quadraticBezierTo(-5, size.height - 5, 0, size.height - 17);
      }
      else {
        path = Path()
          ..moveTo(size.width - 6, size.height - 4)
          ..quadraticBezierTo(
              size.width + 5, size.height, size.width + 16, size.height - 4)
          ..quadraticBezierTo(
              size.width + 5, size.height - 5, size.width, size.height - 17);
      }
      return path;
    }

    final RRect bubbleBody = RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height), Radius.circular(16));
    final Path bubbleTail = paintBubbleTail();

    canvas.drawRRect(bubbleBody, paint);
    canvas.drawPath(bubbleTail, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
