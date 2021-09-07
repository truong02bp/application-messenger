
import 'package:messenger_ui/model/media.dart';
import 'package:messenger_ui/model/message_detail.dart';
import 'package:messenger_ui/model/messenger.dart';
import 'package:json_annotation/json_annotation.dart';
part 'message.g.dart';
@JsonSerializable()
class Message {
  int id;
  String? content;
  Messenger sender;
  Media? media;
  List<MessageDetail> details;
  DateTime createdDate;
  bool? isSticker;
  Message({required this.id, this.content, required this.sender, this.media, required this.details, required this.createdDate, this.isSticker});

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}