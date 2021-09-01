// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messenger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Messenger _$MessengerFromJson(Map<String, dynamic> json) {
  return Messenger(
    id: json['id'] as int,
    nickName: json['nickName'] as String?,
    user: User.fromJson(json['user'] as Map<String, dynamic>),
    chatBoxId: json['chatBoxId'] as int,
  );
}

Map<String, dynamic> _$MessengerToJson(Messenger instance) => <String, dynamic>{
      'id': instance.id,
      'nickName': instance.nickName,
      'user': instance.user,
      'chatBoxId': instance.chatBoxId,
    };
