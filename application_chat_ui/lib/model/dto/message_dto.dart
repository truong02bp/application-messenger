import 'package:json_annotation/json_annotation.dart';
part 'message_dto.g.dart';

@JsonSerializable()
class MessageDto {
  final int chatBoxId;
  final String? content;
  final bool? isMedia;
  final bool? isSticker;
  final int? messageId;
  int? mediaId;
  final int messengerId;
  final String? reaction;
  String? bytes;
  final String? name;
  MessageDto({required this.chatBoxId, this.content, this.isMedia, this.messageId, required this.messengerId,this.reaction, this.bytes, this.name, this.mediaId, this.isSticker});

  factory MessageDto.fromJson(Map<String, dynamic> json) => _$MessageDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MessageDtoToJson(this);

}