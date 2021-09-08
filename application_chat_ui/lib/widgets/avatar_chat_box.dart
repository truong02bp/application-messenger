import 'package:flutter/material.dart';
import 'package:messenger_ui/host_api.dart';
import 'package:messenger_ui/model/chat_box.dart';
import 'package:messenger_ui/ultils/time_ultil.dart';
import 'package:cached_network_image/cached_network_image.dart';
class AvatarChatBox extends StatelessWidget {

  final ChatBox chatBox;
  double? height;
  double? width;
  bool buildDot;
  AvatarChatBox({required this.chatBox, this.height=50, this.width=50, this.buildDot = true});

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
    ClipRRect image = ClipRRect(
      borderRadius: BorderRadius.circular(height!/2),
      child: CachedNetworkImage(
        height: height,
        width: height,
        fit: BoxFit.cover,
        placeholder: (context, url) {
          return Image.asset('assets/images/loading.gif');
        },
        imageUrl: minioUrl + url,
      ),
    );
    if (!buildDot)
      return image;
    return Stack(
      children: [
        image,
        Positioned(
          right: height!/20,
          bottom: 0,
          child: Container(
            width: height!/5 + 2,
            height: width!/5 +2,
            decoration: BoxDecoration(
                color: isActive ? Colors.green.withOpacity(0.95): Colors.white70,
                borderRadius: BorderRadius.circular(height!/10+1)),
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
