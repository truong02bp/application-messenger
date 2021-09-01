import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_ui/bloc/home_bloc.dart';
import 'package:messenger_ui/bloc_event/home_event.dart';
import 'package:messenger_ui/bloc_state/home_state.dart';
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

class _BodyState extends State<Body> {

  List<ChatBox> chatBoxes = [];
  late HomeBloc _homeBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    _homeBloc.add(GetAllChatBox(userId: widget.user.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _homeBloc,
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
