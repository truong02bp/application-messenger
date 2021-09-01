
import 'package:messenger_ui/model/media.dart';
import 'package:messenger_ui/model/message_detail.dart';
import 'package:messenger_ui/model/messenger.dart';
import 'package:json_annotation/json_annotation.dart';
part 'message.g.dart';
@JsonSerializable()
class Message {
  String content;
  Messenger sender;
  Media media;
  List<MessageDetail> details;

  Message({required this.content, required this.sender, required this.media, required this.details});

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}