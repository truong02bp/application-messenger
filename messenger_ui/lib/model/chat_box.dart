
import 'package:messenger_ui/model/media.dart';
import 'package:messenger_ui/model/message.dart';
import 'package:messenger_ui/model/messenger.dart';
import 'package:json_annotation/json_annotation.dart';
part 'chat_box.g.dart';
@JsonSerializable()
class ChatBox {
  String color;
  String name;
  bool isGroup;
  bool isNew;
  Media? image;
  Messenger currentUser;
  List<Messenger> guestUser;
  Message lastMessage;

  ChatBox(
      {required this.color,
      required this.name,
      required this.isGroup,
      required this.isNew,
        this.image,
      required this.currentUser,
      required this.guestUser,
      required this.lastMessage});

  factory ChatBox.fromJson(Map<String, dynamic> json) => _$ChatBoxFromJson(json);

  Map<String, dynamic> toJson() => _$ChatBoxToJson(this);

}