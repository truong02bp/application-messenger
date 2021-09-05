import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_ui/bloc/chat_box_bloc.dart';
import 'package:messenger_ui/bloc/login_bloc.dart';
import 'package:messenger_ui/bloc_event/chat_box_event.dart';
import 'package:messenger_ui/bloc_event/login_event.dart';
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
  late LoginBloc _loginBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _chatBoxBloc = BlocProvider.of<ChatBoxBloc>(context);
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _chatBoxBloc.add(GetAllChatBox(userId: widget.user.id));
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _loginBloc.add(UpdateOnlineEvent());
    }
    else
      _loginBloc.add(UpdateOfflineEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _chatBoxBloc,
      listener: (context, state) {
        if (state is GetAllChatBoxSuccess) {
          setState(() {
            chatBoxes = state.chatBoxes;
          });
        }
      },
      child: Column(
        children: [
          ActiveBar(chatBoxes: chatBoxes),
          SizedBox(height: 20,),
          Column(
            children: List.generate(chatBoxes.length, (index) => ChatBoxCard(chatBox: chatBoxes[index])),
          )
        ],
      ),
    );
  }
}
