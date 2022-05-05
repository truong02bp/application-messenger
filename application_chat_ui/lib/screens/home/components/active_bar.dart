import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:messenger_ui/bloc/chat_box_bloc.dart';
import 'package:messenger_ui/bloc_event/chat_box_event.dart';
import 'package:messenger_ui/bloc_state/chat_box_state.dart';
import 'package:messenger_ui/model/chat_box.dart';
import 'package:messenger_ui/model/user.dart';
import 'package:messenger_ui/screens/chat_box/chat_box_screen.dart';
import 'package:messenger_ui/widgets/avatar_chat_box.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActiveBar extends StatefulWidget {
  final User user;

  ActiveBar({required this.user});

  @override
  _ActiveBarState createState() => _ActiveBarState();
}

class _ActiveBarState extends State<ActiveBar> {
  late ChatBoxBloc _chatBoxBloc;
  List<ChatBox> chatBoxes = [];
  int page = 0;
  int size = 6;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _chatBoxBloc = BlocProvider.of<ChatBoxBloc>(context);
    chatBoxes = [];
    _chatBoxBloc.add(
        GetChatBoxMostMessage(userId: widget.user.id, page: page, size: size));
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _chatBoxBloc.add(GetChatBoxMostMessage(
            userId: widget.user.id, page: page + 1, size: size));
        page += 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(27),
                    ),
                    child: Icon(Icons.add),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    'Your story',
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
              BlocConsumer(
                bloc: _chatBoxBloc,
                listener: (context, state) {
                  if (state is GetChatBoxMostMessageSuccess) {
                    chatBoxes.addAll(state.chatBoxes);
                  }
                },
                builder: (context, state) {
                  return Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: chatBoxes.length,
                        itemBuilder: (context, index) {
                          ChatBox chatBox = chatBoxes[index];
                          String name;
                          if (chatBox.isGroup && chatBox.image != null) {
                            if (chatBox.name != null)
                              name = chatBox.name!;
                            else
                              name =
                                  "${chatBox.currentUser.user.name}, ${chatBox.guestUser.first.user.name}";
                          } else {
                            name = chatBox.guestUser.first.user.name;
                          }
                          return Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(25),
                              splashColor: Colors.pink.withOpacity(0.2),
                              onTap: () {
                                Navigator.popAndPushNamed(
                                    context, ChatBoxScreen.routeName,
                                    arguments: {"chatBox": chatBox});
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  AvatarChatBox(chatBox: chatBox),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  name.contains(" ")
                                      ? Text(
                                          '${name.substring(name.lastIndexOf(" "))}')
                                      : Text('$name')
                                ],
                              ),
                            ),
                          );
                        }),
                  );
                },
              )
            ],
          ),
        )
      ],
    );
  }

}
