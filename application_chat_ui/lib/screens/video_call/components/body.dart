import 'package:flutter/material.dart';
import 'package:messenger_ui/model/chat_box.dart';
import 'package:messenger_ui/widgets/avatar_chat_box.dart';

class Body extends StatefulWidget {
  final ChatBox chatBox;

  Body({required this.chatBox});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AvatarChatBox(chatBox: widget.chatBox, height: 200, width: 200, buildDot: false,),
        SizedBox(height: 20,),
        Text('calling video', style: TextStyle(fontSize: 25, color: Colors.white),),
        SizedBox(height: 100,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(onPressed: (){

            }, child: Icon(Icons.cancel, color: Colors.white,),),
            FloatingActionButton(onPressed: (){

            }, child: Icon(Icons.videocam, color: Colors.green,),)
          ],
        )
      ],
    );

  }
}
