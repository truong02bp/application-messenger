import 'package:flutter/material.dart';
import 'package:messenger_ui/bloc/message_bloc.dart';
import 'package:messenger_ui/bloc_event/message_event.dart';
import 'package:messenger_ui/model/chat_box.dart';
import 'package:messenger_ui/model/dto/message_dto.dart';
import 'package:messenger_ui/model/message.dart';
import 'package:messenger_ui/model/message_detail.dart';
import 'package:messenger_ui/screens/chat_box/components/reaction_bar.dart';
import 'package:messenger_ui/screens/chat_box/components/text_card.dart';
import 'package:messenger_ui/ultils/time_ultil.dart';
import 'package:messenger_ui/ultils/ultil.dart';
import 'package:messenger_ui/widgets/avatar_chat_box.dart';
import 'package:messenger_ui/widgets/custom_icon.dart';
import 'package:messenger_ui/widgets/message_status.dart';
import 'package:messenger_ui/widgets/time_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class MessageCard extends StatefulWidget {
   Message message;
   ChatBox chatBox;
   bool showDate;
   bool needMessageStatus;
   bool needAvatar;
  MessageCard(
      {required this.message,
      required this.chatBox,
      required this.showDate,
      required this.needMessageStatus, required this.needAvatar});

  @override
  _MessageCardState createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  bool showDetail = false;
  late MessageBloc _messageBloc;
  Map<String, List<String>> reactionDetails = Map();
  MessageDetail? guestMessageDetail;

  @override
  void initState() {
    // TODO: implement initState
    _messageBloc = BlocProvider.of<MessageBloc>(context);
    for (MessageDetail detail in widget.message.details) {
      if (detail.seenBy.id != widget.chatBox.id) {
        guestMessageDetail = detail;
      }
      if (detail.reaction != null) {
        String? name = detail.seenBy.nickName;
        if (name == null)
          name = detail.seenBy.user.name;
        if (reactionDetails[detail.reaction!.code] == null) {
          reactionDetails[detail.reaction!.code] = [];
        }
        reactionDetails[detail.reaction!.code]!.add(name);
      }
      print('${widget.message.content} ${reactionDetails.length}');
    }
  }
  @override
  void dispose() {
    super.dispose();
    reactionDetails.clear();
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
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        widget.showDate || showDetail
            ? TimeBar(time: widget.message.createdDate)
            : Container(),
        Row(
          mainAxisAlignment:
              isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            !isSender && widget.needAvatar
                ? Container(
                    margin: EdgeInsets.only(right: 5),
                    child: AvatarChatBox(
                      chatBox: widget.chatBox,
                      height: 35,
                      width: 35,
                    ))
                : Container(height: 35, width: 40,),
            InkWell(
              onLongPress: (){
                  showDialog(
                      builder: (context) => Hero(
                        tag: 'dash',
                        child: ReactionBar(
                          callBack: (value) {
                            setState(() {
                              _messageBloc.add(UpdateMessageEvent(
                                  option: "reaction",
                                  messageDto: MessageDto(
                                      messageId: widget.message.id,
                                      messengerId: widget.chatBox.currentUser.id,
                                      reaction: value,
                                      chatBoxId: widget.chatBox.id)));
                              Navigator.pop(context);
                            });
                          },
                        ),
                      ),
                      context: context);
              },
              onTap: () {
                setState(() {
                  showDetail = !showDetail;
                });
              },
              child: Stack(children: [
                !isSender && widget.needAvatar ? Positioned(
                    bottom: reactionDetails.isNotEmpty ? 4 : 2,
                    left: 9,
                    child: CustomPaint(
                      painter: ChatBubbleTriangle(isSender: isSender, color: color),
                    )
                ) : Container(),
                Padding(
                  padding: reactionDetails.isNotEmpty ? EdgeInsets.only(left: 8, right: 8, bottom: 7) : EdgeInsets.only(left: 8, right: 8),
                  child: Container(
                    constraints: new BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 2 / 3),
                    decoration: BoxDecoration(
                        borderRadius: isSender ?
                        BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))
                        : BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                        color: color),
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 6, top: 6),
                    child: TextCard(text: widget.message.content,),
                  ),
                ),
                isSender ? Positioned(
                    bottom: reactionDetails.isNotEmpty ? 4 : 2,
                    right: 9,
                    child: CustomPaint(
                      painter: ChatBubbleTriangle(isSender: isSender, color: color),
                    )
                ) : Container(),
                reactionDetails.isNotEmpty ? Positioned(bottom: -2, right: 15, child: buildReaction()) : Container(),
              ]),
            ),
          ],
        ),
        widget.needMessageStatus
            ? MessageStatus(
          currentUser: widget.chatBox.currentUser,
          message: widget.message,
          color: widget.chatBox.color,
        )
            : Container(),
        showDetail
            ? Padding(
          padding: const EdgeInsets.only(right: 20, left: 20),
          child: Row(
            mainAxisAlignment: widget.message.sender.id == widget.chatBox.currentUser.id
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              guestMessageDetail != null
                  ? Text(
                  'Seen at ${formatDate(time: guestMessageDetail!.createdDate)}')
                  : Text('Sent'),
            ],
          ),
        )
            : Container()
      ],
    );
  }
  InkWell buildReaction() {
    int counter = 0;
    List<Container> reactions = [];
    reactionDetails.forEach((key, value) {
      counter += value.length;
      reactions.add(Container(
        child: CustomIcon(
          image: "assets/images/$key.png",
          height: 16,
          width: 16,
        ),
      ));
    });
    if (counter > 1) {
      reactions.add(Container(
        margin: EdgeInsets.only(left: 4),
        child: Text("$counter"),
      ));
    }
    return InkWell(
      onTap: () {},
      child: Container(
        width: (16 * reactions.length).toDouble(),
        height: 18,
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.5),
            borderRadius: BorderRadius.circular(25)),
        child: Row(
          children: reactions,
        ),
      ),
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
          ..moveTo(5, size.height - 4)
          ..quadraticBezierTo(-5, size.height, -10, size.height - 10)
          ..quadraticBezierTo(-5, size.height, 0, size.height - 12);
      }
      else {
        path = Path()
          ..moveTo(size.width - 3, size.height - 5)
          ..quadraticBezierTo(
              size.width + 5, size.height, size.width + 12, size.height - 10)
          ..quadraticBezierTo(
              size.width + 5, size.height , size.width, size.height - 12);
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
