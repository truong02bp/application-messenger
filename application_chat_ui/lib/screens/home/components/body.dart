import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_ui/bloc/chat_box_bloc.dart';
import 'package:messenger_ui/bloc/user_bloc.dart';
import 'package:messenger_ui/bloc_event/chat_box_event.dart';
import 'package:messenger_ui/bloc_event/user_event.dart';
import 'package:messenger_ui/bloc_state/chat_box_state.dart';
import 'package:messenger_ui/model/chat_box.dart';
import 'package:messenger_ui/model/user.dart';
import 'package:messenger_ui/screens/home/components/active_bar.dart';
import 'package:messenger_ui/screens/home/components/chat_box_card.dart';

class Body extends StatefulWidget {
  final User user;

  Body({required this.user});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with WidgetsBindingObserver {
  List<ChatBox> chatBoxes = [];
  late ChatBoxBloc _chatBoxBloc;
  late UserBloc _userBloc;
  ScrollController _scrollController = ScrollController();
  int page = 0;
  int size = 15;
  int chatBoxUpdateId = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _chatBoxBloc = BlocProvider.of<ChatBoxBloc>(context);
    _userBloc = BlocProvider.of<UserBloc>(context);
    _chatBoxBloc.add(GetAllChatBox(userId: widget.user.id, page: page, size: size));
    _userBloc.add(UpdateOnlineEvent());
    WidgetsBinding.instance!.addObserver(this);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _chatBoxBloc.add(
            GetAllChatBox(userId: widget.user.id, page: page + 1, size: size));
        page += 1;
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _userBloc.add(UpdateOnlineEvent());
    } else
      _userBloc.add(UpdateOfflineEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 80,
            child: ActiveBar(user: widget.user)
        ),
        SizedBox(height: 10,),
        BlocConsumer(
          bloc: _chatBoxBloc,
          listener: (context, state) {
            if (state is NewMessageState) {
              _chatBoxBloc
                  .add(GetChatBox(id: state.chatBoxId, userId: widget.user.id));
            }

            if (state is GetAllChatBoxSuccess) {
              if (page == 0)
                chatBoxes.clear();
              chatBoxes.addAll(state.chatBoxes);
              chatBoxes.removeWhere((element) => element.lastMessage == null && !element.isGroup);
            }
            if (state is GetChatBoxSuccess) {
              chatBoxes.removeWhere((element) => element.id == state.chatBox.id);
              chatBoxes.insert(0, state.chatBox);
              chatBoxUpdateId = state.chatBox.id;
            }
          },
          builder: (context, state) {
            return Expanded(
              child: ListView.builder(
                  controller: _scrollController,
                  itemCount: chatBoxes.length,
                  itemBuilder: (context, index) {
                    if (chatBoxUpdateId == chatBoxes[index].id)
                      return ChatBoxCard(chatBox: chatBoxes[index], key: UniqueKey());
                    return ChatBoxCard(chatBox: chatBoxes[index], key: ValueKey(chatBoxes[index].id),);
                  }),
            );
          },
        ),
      ],
    );
  }
}
