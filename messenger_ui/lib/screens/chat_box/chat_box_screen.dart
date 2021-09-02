import 'package:flutter/material.dart';
import 'package:messenger_ui/model/chat_box.dart';
import 'package:messenger_ui/screens/chat_box/components/body.dart';
import 'package:messenger_ui/screens/chat_box/components/header.dart';
import 'package:messenger_ui/screens/chat_box/components/message_form.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
class ChatBoxScreen extends StatelessWidget {

  static final String routeName = "/chat-box";

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    ChatBox chatBox = arguments["chatBox"];
    return SafeArea(
      child: KeyboardDismisser(
        gestures: [GestureType.onTap],
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Header(chatBox: chatBox,),
                Expanded(child: Body(chatBox: chatBox,)),
                MessageForm(chatBox)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
