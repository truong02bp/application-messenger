// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_box.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatBox _$ChatBoxFromJson(Map<String, dynamic> json) {
  return ChatBox(
    id: json['id'] as int,
    color: json['color'] as String?,
    name: json['name'] as String?,
    isGroup: json['isGroup'] as bool,
    image: json['image'] == null
        ? null
        : Media.fromJson(json['image'] as Map<String, dynamic>),
    currentUser:
        Messenger.fromJson(json['currentUser'] as Map<String, dynamic>),
    guestUser: (json['guestUser'] as List<dynamic>)
        .map((e) => Messenger.fromJson(e as Map<String, dynamic>))
        .toList(),
    lastMessage: json['lastMessage'] == null
        ? null
        : Message.fromJson(json['lastMessage'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ChatBoxToJson(ChatBox instance) => <String, dynamic>{
      'id': instance.id,
      'color': instance.color,
      'name': instance.name,
      'isGroup': instance.isGroup,
      'image': instance.image,
      'currentUser': instance.currentUser,
      'guestUser': instance.guestUser,
      'lastMessage': instance.lastMessage,
    };
