import 'package:flutter/material.dart';
import 'package:messenger_ui/host_api.dart';
import 'package:messenger_ui/model/user.dart';
import 'package:messenger_ui/widgets/custom_icon.dart';

class Header extends StatelessWidget {
  final User user;

  Header({required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(minioUrl + user.avatar.url),
          maxRadius: 25,
        ),
        SizedBox(
          width: 15,
        ),
        Text(
          'Chats',
          style: TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
        Spacer(),
        CustomIcon(image: "assets/images/camera.png"),
        SizedBox(width: 25,),
        CustomIcon(image: "assets/images/pencil.png"),
      ],
    );
  }
}
