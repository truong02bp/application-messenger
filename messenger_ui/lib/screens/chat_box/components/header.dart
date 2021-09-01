import 'package:flutter/material.dart';
import 'package:messenger_ui/model/chat_box.dart';
import 'package:messenger_ui/model/messenger.dart';
import 'package:messenger_ui/screens/home/home_screen.dart';
import 'package:messenger_ui/ultils/time_ulti.dart';
import 'package:messenger_ui/widgets/avatar_chat_box.dart';

class Header extends StatefulWidget {
  final ChatBox chatBox;

  Header({required this.chatBox});

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  late ChatBox chatBox;
  late String? name;
  String leave = "";
  late bool isActive;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chatBox = widget.chatBox;
    if (chatBox.isGroup && chatBox.name != null) {
      name = chatBox.name!;
    } else {
      Messenger guestUser = chatBox.guestUser.first;
      name =
          guestUser.nickName != null ? guestUser.nickName : guestUser.user.name;
    }

    isActive = chatBox.isGroup ? true : chatBox.guestUser.first.user.online;

    if (!isActive){
      leave = getTimeOnlineString(time : chatBox.guestUser.first.user.lastOnline);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.popAndPushNamed(context, HomeScreen.routeName,
                  arguments: {"user": chatBox.currentUser.user});
            },
            child: Container(
              height: 30,
              width: 30,
              child: Icon(Icons.arrow_back),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          AvatarChatBox(chatBox: chatBox),
          SizedBox(
            width: 15,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$name',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  )),
              SizedBox(
                height: 5,
              ),
              Text(
                isActive ? 'Active' : "$leave",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
              ),
            ],
          ),
          Spacer(),
          PopupMenuButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            itemBuilder: (context) {
              return [
                buildItem(
                    text: 'Call',
                    value: 'call',
                    icon: Icon(
                      Icons.phone,
                    )),
                buildItem(
                    text: 'Video call',
                    value: 'video_call',
                    icon: Icon(Icons.video_call)),
                buildItem(
                    text: 'Search', value: 'search', icon: Icon(Icons.search)),
                buildItem(
                    text: 'Clear history',
                    value: 'clear_history',
                    icon: Icon(Icons.cleaning_services_outlined)),
                buildItem(
                    text: 'Mute notifications',
                    value: 'mute_notification',
                    icon: Icon(Icons.volume_mute)),
                buildItem(
                    text: 'Delete chat',
                    value: 'delete_chat',
                    icon: Icon(Icons.delete)),
              ];
            },
            onSelected: (value) {

            },
          )
        ],
      ),
    );
  }

  PopupMenuItem buildItem(
      {required String text, required String value, required Icon icon}) {
    return PopupMenuItem(
        value: value,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            icon,
            SizedBox(
              width: 10,
            ),
            Text('$text'),
          ],
        ));
  }
}
