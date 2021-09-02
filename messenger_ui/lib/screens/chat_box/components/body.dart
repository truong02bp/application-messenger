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
  Widget build(BuildContext context) {
    print('build');
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
                if (index == messages.length -1)
                  showDate = true;
                else {
                  int minute = messages[index].createdDate.difference(messages[index+1].createdDate).inMinutes;
                  if (minute > 10)
                    showDate = true;
                }
                Widget message = Padding(
                  padding: const EdgeInsets.only(bottom: 7),
                  child: MessageCard(message: messages[index], chatBox: chatBox, needBuildDot: false, showDate: showDate,),
                );
                return message;
              },
            ),
          ),
        ),
      ],
    );
  }
}
