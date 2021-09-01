// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) {
  return Message(
    content: json['content'] as String,
    sender: Messenger.fromJson(json['sender'] as Map<String, dynamic>),
    media: Media.fromJson(json['media'] as Map<String, dynamic>),
    details: (json['details'] as List<dynamic>)
        .map((e) => MessageDetail.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'content': instance.content,
      'sender': instance.sender,
      'media': instance.media,
      'details': instance.details,
    };
