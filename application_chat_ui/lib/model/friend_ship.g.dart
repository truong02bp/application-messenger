// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_ship.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FriendShip _$FriendShipFromJson(Map<String, dynamic> json) {
  return FriendShip(
    id: json['id'] as int,
    user: User.fromJson(json['user'] as Map<String, dynamic>),
    friend: User.fromJson(json['friend'] as Map<String, dynamic>),
    isAccept: json['isAccept'] as bool,
  );
}

Map<String, dynamic> _$FriendShipToJson(FriendShip instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'friend': instance.friend,
      'isAccept': instance.isAccept,
    };
