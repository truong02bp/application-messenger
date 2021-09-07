// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageDto _$MessageDtoFromJson(Map<String, dynamic> json) {
  return MessageDto(
    chatBoxId: json['chatBoxId'] as int,
    content: json['content'] as String?,
    isMedia: json['isMedia'] as bool?,
    messageId: json['messageId'] as int?,
    messengerId: json['messengerId'] as int,
    reaction: json['reaction'] as String?,
    bytes: json['bytes'] as String?,
    name: json['name'] as String?,
    mediaId: json['mediaId'] as int?,
  );
}

Map<String, dynamic> _$MessageDtoToJson(MessageDto instance) =>
    <String, dynamic>{
      'chatBoxId': instance.chatBoxId,
      'content': instance.content,
      'isMedia': instance.isMedia,
      'messageId': instance.messageId,
      'mediaId': instance.mediaId,
      'messengerId': instance.messengerId,
      'reaction': instance.reaction,
      'bytes': instance.bytes,
      'name': instance.name,
    };
