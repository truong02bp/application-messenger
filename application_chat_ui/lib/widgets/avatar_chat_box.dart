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
  final bool buildTime;

  AvatarChatBox(
      {required this.chatBox,
      this.height = 50,
      this.width = 50,
      this.buildDot = true,
      this.buildTime = true});

  @override
  Widget build(BuildContext context) {
    String url;
    String timeOffline = "";
    bool isActive =
        chatBox.isGroup ? true : chatBox.guestUser.first.user.online;
    if (chatBox.isGroup) {
      if (chatBox.image != null)
        url = chatBox.image!.url;
      else
        url = "assets/images/group.jpg";
    } else
      url = chatBox.guestUser.first.user.avatar.url;
    if (!isActive) {
      timeOffline =
          getTimeOnlineString(time: chatBox.guestUser.first.user.lastOnline);
      timeOffline = timeOffline.substring(0, timeOffline.lastIndexOf(" "));
    }
    ClipRRect image = ClipRRect(
      borderRadius: BorderRadius.circular(height! / 2),
      child: url.contains("assets")
          ? Container(height: height, width: height, child: Image.asset(url))
          : CachedNetworkImage(
              height: height,
              width: height,
              fit: BoxFit.cover,
              placeholder: (context, url) {
                return Image.asset('assets/images/loading.gif');
              },
              imageUrl: minioUrl + url,
            ),
    );
    if (!buildDot) return image;
    return Stack(children: [
      image,
      Positioned(
        right: height! / 20,
        bottom: 0,
        child: isActive
            ? Container(
                width: height! / 5 + 2,
                height: width! / 5 + 2,
                decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(height! / 10 + 1)),
              )
            : buildTime
                ? Container(
                    width: height! / 2 + 10,
                    height: width! / 5 + 2,
                    decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(height! / 10 + 1)),
                    child: timeOffline != "" && !timeOffline.contains("day")
                        ? Center(
                            child: Text(
                            '$timeOffline',
                            style: TextStyle(
                                fontSize: 7, fontWeight: FontWeight.bold),
                          ))
                        : Container())
                : Container(),
      )
    ]);
  }
}
