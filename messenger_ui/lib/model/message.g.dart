// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) {
  return Message(
    id: json['id'] as int,
    content: json['content'] as String?,
    sender: Messenger.fromJson(json['sender'] as Map<String, dynamic>),
    media: json['media'] == null
        ? null
        : Media.fromJson(json['media'] as Map<String, dynamic>),
    details: (json['details'] as List<dynamic>)
        .map((e) => MessageDetail.fromJson(e as Map<String, dynamic>))
        .toList(),
    createdDate: DateTime.parse(json['createdDate'] as String),
  );
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'sender': instance.sender,
      'media': instance.media,
      'details': instance.details,
      'createdDate': instance.createdDate.toIso8601String(),
    };
