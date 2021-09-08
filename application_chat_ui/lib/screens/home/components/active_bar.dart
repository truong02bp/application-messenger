import 'package:flutter/material.dart';
import 'package:messenger_ui/model/chat_box.dart';
import 'package:messenger_ui/screens/chat_box/chat_box_screen.dart';
import 'package:messenger_ui/widgets/avatar_chat_box.dart';

class ActiveBar extends StatelessWidget {

  final List<ChatBox> chatBoxes;


  ActiveBar({required this.chatBoxes});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
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
                  SizedBox(height: 2,),
                  Text('Your story', style: TextStyle(color: Colors.grey),)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(chatBoxes.length, (index){
                  ChatBox chatBox = chatBoxes[index];
                  String name;
                  if (chatBox.isGroup && chatBox.image != null) {
                    if (chatBox.name != null)
                     name = chatBox.name!;
                    else
                      name = "${chatBox.currentUser.user.name}, ${chatBox.guestUser.first.user.name}";
                  }
                  else {
                    name = chatBox.guestUser.first.user.name;
                  }
                  return Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(25),
                      splashColor: Colors.pink.withOpacity(0.2),
                      onTap: (){
                          Navigator.popAndPushNamed(context, ChatBoxScreen.routeName, arguments: {"chatBox" : chatBox});
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AvatarChatBox(chatBox : chatBox),
                          SizedBox(height: 2,),
                          Text('${name.substring(name.lastIndexOf(" "))}')
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        )
      ],
    );
  }

}
