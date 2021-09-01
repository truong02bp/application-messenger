
import 'package:json_annotation/json_annotation.dart';
import 'package:messenger_ui/model/messenger.dart';
import 'package:messenger_ui/model/reaction.dart';
part 'message_detail.g.dart';

@JsonSerializable(explicitToJson: true)
class MessageDetail {
  int id;
  Reaction reaction;
  Messenger seenBy;
  DateTime createdDate;


  MessageDetail({required this.id, required this.createdDate, required this.reaction, required this.seenBy});

  factory MessageDetail.fromJson(Map<String, dynamic> json) => _$MessageDetailFromJson(json);

  Map<String, dynamic> toJson() => _$MessageDetailToJson(this);
}