
import 'package:flutter/cupertino.dart';
import 'package:messenger_ui/model/media.dart';
import 'package:messenger_ui/model/message.dart';
import 'package:messenger_ui/model/messenger.dart';
import 'package:json_annotation/json_annotation.dart';
part 'chat_box.g.dart';
@JsonSerializable()
class ChatBox {
  int id;
  String? color;
  String? name;
  bool isGroup;
  Media? image;
  Messenger currentUser;
  List<Messenger> guestUser;
  Message? lastMessage;

  ChatBox(
      {required this.id, this.color, this.name,
      required this.isGroup, this.image,
      required this.currentUser,
      required this.guestUser, this.lastMessage});

  factory ChatBox.fromJson(Map<String, dynamic> json) => _$ChatBoxFromJson(json);

  Map<String, dynamic> toJson() => _$ChatBoxToJson(this);

}