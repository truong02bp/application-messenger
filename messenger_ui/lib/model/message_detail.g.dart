// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageDetail _$MessageDetailFromJson(Map<String, dynamic> json) {
  return MessageDetail(
    id: json['id'] as int,
    createdDate: DateTime.parse(json['createdDate'] as String),
    reaction: Reaction.fromJson(json['reaction'] as Map<String, dynamic>),
    seenBy: Messenger.fromJson(json['seenBy'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MessageDetailToJson(MessageDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'reaction': instance.reaction.toJson(),
      'seenBy': instance.seenBy.toJson(),
      'createdDate': instance.createdDate.toIso8601String(),
    };
