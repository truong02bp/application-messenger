// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserContact _$UserContactFromJson(Map<String, dynamic> json) {
  return UserContact(
    user: User.fromJson(json['user'] as Map<String, dynamic>),
    friendShip: json['friendShip'] == null
        ? null
        : FriendShip.fromJson(json['friendShip'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserContactToJson(UserContact instance) =>
    <String, dynamic>{
      'user': instance.user,
      'friendShip': instance.friendShip,
    };
