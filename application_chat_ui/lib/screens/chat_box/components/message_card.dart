import 'package:flutter/material.dart';
import 'package:messenger_ui/bloc/message_bloc.dart';
import 'package:messenger_ui/bloc_event/message_event.dart';
import 'package:messenger_ui/content_type.dart';
import 'package:messenger_ui/model/chat_box.dart';
import 'package:messenger_ui/model/dto/message_dto.dart';
import 'package:messenger_ui/model/message.dart';
import 'package:messenger_ui/model/message_detail.dart';
import 'package:messenger_ui/screens/chat_box/components/chat_bubble_triangle.dart';
import 'package:messenger_ui/screens/chat_box/components/image_card.dart';
import 'package:messenger_ui/screens/chat_box/components/reaction_bar.dart';
import 'package:messenger_ui/screens/chat_box/components/reaction_status.dart';
import 'package:messenger_ui/screens/chat_box/components/seen_info.dart';
import 'package:messenger_ui/screens/chat_box/components/sticker_card.dart';
import 'package:messenger_ui/screens/chat_box/components/text_card.dart';
import 'package:messenger_ui/screens/chat_box/components/video_card.dart';
import 'package:messenger_ui/ultils/ultil.dart';
import 'package:messenger_ui/widgets/avatar_chat_box.dart';
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
      if (detail.seenBy.id != widget.chatBox.currentUser.id) {
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
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            !isSender && widget.needAvatar
                ? Container(
                    margin: EdgeInsets.only(right: 5),
                    child: AvatarChatBox(
                      chatBox: widget.chatBox,
                      height: 35,
                      width: 35,
                      buildTime: false,
                    ))
                : Container(height: 35, width: 40,),
            InkWell(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
              onLongPress: (){
                showReactionBar();
              },
              onTap: () {
                setState(() {
                  showDetail = !showDetail;
                });
              },
              child: Stack(children: [

                !isSender && widget.needAvatar ? Positioned(
                    bottom: reactionDetails.isNotEmpty ? 4 : -3,
                    left: 8,
                    child: CustomPaint(
                      painter: ChatBubbleTriangle(isSender: isSender, color: color),
                    )
                ) : Container(),

                Padding(
                  padding: reactionDetails.isNotEmpty ? EdgeInsets.only(left: 8, right: 8, bottom: 7) : EdgeInsets.only(left: 8, right: 8),
                  child: widget.message.media == null ? TextCard(text: widget.message.content, color: color,)
                      : imageContentType.contains(widget.message.media!.contentType) ? ImageCard(url: widget.message.media!.url,)
                      : videoContentType.contains(widget.message.media!.contentType) ? VideoCard(url: widget.message.media!.url) : StickerCard(widget.message.media!.url),
                ),

                isSender ? Positioned(
                    bottom: reactionDetails.isNotEmpty ? 4 : -3,
                    right: 8,
                    child: CustomPaint(
                      painter: ChatBubbleTriangle(isSender: isSender, color: color),
                    )
                ) : Container(),

                reactionDetails.isNotEmpty ? Positioned(bottom: -1, right: 15, child: ReactionStatus(reactionDetails)) : Container(),
              ]),
            ),
          ],
        ),
        widget.needMessageStatus ? MessageStatus(
          currentUser: widget.chatBox.currentUser,
          message: widget.message,
          color: widget.chatBox.color,
        ) : Container(),
        showDetail ? SeenInfo(isSender: isSender, detail: guestMessageDetail,) : Container()
      ],
    );
  }

  void showReactionBar() {
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
  }
}


