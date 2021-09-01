
import 'package:messenger_ui/model/user.dart';
import 'package:json_annotation/json_annotation.dart';
part 'messenger.g.dart';
@JsonSerializable()
class Messenger {
  int id;
  String? nickName;
  User user;
  int chatBoxId;

  Messenger({required this.id, this.nickName, required this.user, required this.chatBoxId});

  factory Messenger.fromJson(Map<String, dynamic> json) => _$MessengerFromJson(json);

  Map<String, dynamic> toJson() => _$MessengerToJson(this);
}