import 'package:flutter/material.dart';
import 'package:messenger_ui/model/chat_box.dart';
import 'package:messenger_ui/screens/video_call/components/body.dart';

class VideoCallScreen extends StatelessWidget {
  static final String routeName = "/video-call";
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    ChatBox chatBox = arguments["chatBox"];
    return Scaffold(
      backgroundColor: Colors.black26,
      body: Body(chatBox : chatBox),
    );
  }
}

