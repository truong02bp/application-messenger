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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _chatBoxBloc = BlocProvider.of<ChatBoxBloc>(context);
    _userBloc = BlocProvider.of<UserBloc>(context);
    _chatBoxBloc.add(GetAllChatBox(userId: widget.user.id));
    _userBloc.add(UpdateOnlineEvent());
    WidgetsBinding.instance!.addObserver(this);
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
        BlocBuilder(
          bloc: _chatBoxBloc,
          builder: (context, state) {
            if (state is GetAllChatBoxSuccess) {
              return ActiveBar(chatBoxes: state.chatBoxes);
            }
            return Container();
          },
        ),
        SizedBox(
          height: 20,
        ),
        BlocBuilder(
          bloc: _chatBoxBloc,
          builder: (context, state) {
            if (state is GetAllChatBoxSuccess) {
              List<ChatBox> chatBoxes = [];
              chatBoxes.addAll(state.chatBoxes);
              chatBoxes.removeWhere((element) => element.lastMessage == null);
              return Column(
                children: List.generate(chatBoxes.length, (index) {
                  return ChatBoxCard(chatBox: chatBoxes[index]);
                }),
              );
            }

            return Container();
          },
        )
      ],
    );
  }
}
