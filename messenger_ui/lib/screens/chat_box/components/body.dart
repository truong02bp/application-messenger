import 'package:flutter/material.dart';
import 'package:messenger_ui/bloc/chat_box_bloc.dart';
import 'package:messenger_ui/bloc_event/chat_box_event.dart';
import 'package:messenger_ui/bloc_state/chat_box_state.dart';
import 'package:messenger_ui/model/chat_box.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_ui/model/message.dart';
import 'package:messenger_ui/screens/chat_box/components/message_card.dart';

class Body extends StatefulWidget {
  final ChatBox chatBox;

  Body({required this.chatBox});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late ChatBox chatBox;
  late ChatBoxBloc _chatBoxBloc;
  List<Message> messages = [];
  int size = 20;
  int page = 0;
  ScrollController _scrollController = ScrollController(keepScrollOffset: true);
  Set<int> idsNeedBuild = Set();
  Set<int> idsNeedAvatar = Set();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chatBox = widget.chatBox;
    _chatBoxBloc = BlocProvider.of<ChatBoxBloc>(context);
    _chatBoxBloc.add(GetMessage(chatBoxId: chatBox.id, size: size, page: page));
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _chatBoxBloc.add(GetMessage(
            page: page + 1, size: size, chatBoxId: widget.chatBox.id));
        setState(() {
          page = page + 1;
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    messages.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocListener(
          bloc: _chatBoxBloc,
          listener: (context, state) {
            if (state is GetMessageSuccess) {
              setState(() {
                messages.addAll(state.messages);
              });
            }
            if (state is NewMessageState && state.chatBoxId == chatBox.id) {
              setState(() {
                if (state.message.sender.id == chatBox.currentUser.id)
                  idsNeedBuild.add(state.message.id);
                else
                  idsNeedAvatar.add(state.message.id);
                messages.insert(0, state.message);
              });
            }
          },
          child: Expanded(
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.vertical,
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                bool showDate = false;
                Message message = messages[index];
                if (index == messages.length -1)
                  showDate = true;
                else {
                  int minute = message.createdDate.difference(messages[index+1].createdDate).inMinutes;
                  if (minute > 10)
                    showDate = true;
                }
                if (widget.chatBox.currentUser.id != message.sender.id) {
                  if (index == 0)
                    idsNeedAvatar.add(message.id);
                  else {
                    if (messages[index-1].sender.id == message.sender.id){
                      int minute = messages[index-1].createdDate.difference(message.createdDate).inMinutes;
                      print("${message.createdDate} ${messages[index-1].createdDate} $minute");
                      if (minute > 10)
                        idsNeedAvatar.add(message.id);
                    }
                    else
                      idsNeedAvatar.add(message.id);
                  }
                }
                if (widget.chatBox.currentUser.id == message.sender.id && !idsNeedBuild.contains(-1)) {
                  idsNeedBuild.add(message.id);
                  if (message.details.indexWhere((element) => element.seenBy.id != chatBox.currentUser.id) != -1) {
                    idsNeedBuild.add(-1);
                  }
                }
                else {
                  idsNeedBuild.add(-1);
                }
                bool needMessageStatus = idsNeedBuild.contains(message.id);
                bool needAvatar = idsNeedAvatar.contains(message.id);
                Widget card = Padding(
                  padding: const EdgeInsets.only(bottom: 7),
                  child: MessageCard(message: message, chatBox: chatBox, needMessageStatus: needMessageStatus, showDate: showDate, needAvatar: needAvatar,),
                );
                return card;
              },
            ),
          ),
        ),
      ],
    );
  }
}
