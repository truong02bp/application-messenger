import 'package:flutter/material.dart';
import 'package:messenger_ui/model/chat_box.dart';
import 'package:messenger_ui/screens/chat_box/components/header.dart';

class ChatBoxScreen extends StatelessWidget {

  static final String routeName = "/chat-box";

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    ChatBox chatBox = arguments["chatBox"];
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Header(chatBox: chatBox,)
          ],
        ),
      ),
    );
  }
}
