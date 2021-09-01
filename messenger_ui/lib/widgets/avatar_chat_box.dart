import 'package:flutter/material.dart';
import 'package:messenger_ui/host_api.dart';
import 'package:messenger_ui/model/chat_box.dart';
import 'package:messenger_ui/ultils/time_ulti.dart';

class AvatarChatBox extends StatelessWidget {

  final ChatBox chatBox;

  AvatarChatBox({required this.chatBox});

  @override
  Widget build(BuildContext context) {
    String url;
    int minuteLeave = 0;
    bool isActive = chatBox.isGroup ? true : chatBox.guestUser.first.user.online;
    if (chatBox.isGroup && chatBox.image != null) {
      url = chatBox.image!.url;
    }
    else
      url = chatBox.guestUser.first.user.avatar.url;
    if (!isActive){
      minuteLeave = getTimeOnline(time : chatBox.guestUser.first.user.lastOnline);
    }
    return Stack(
      children: [ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: FadeInImage(
          height: 50,
          width: 50,
          fit: BoxFit.cover,
          placeholder: AssetImage("assets/images/loading.gif"),
          image: NetworkImage(minioUrl + url),
        ),
      ),
        Positioned(
          right: 3,
          bottom: 0,
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
                color: isActive ? Colors.green.withOpacity(0.95): Colors.white70,
                borderRadius: BorderRadius.circular(6)),
            child: minuteLeave != 0 ? Center(
                child: Text(
                  '$minuteLeave\'',
                  style: TextStyle(fontSize: 3, fontWeight: FontWeight.bold),
                ))
                : Container(),
          ),
        )
    ]
    );
  }

}
