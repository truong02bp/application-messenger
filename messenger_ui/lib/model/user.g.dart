// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as int,
    name: json['name'] as String,
    username: json['username'] as String,
    password: json['password'] as String,
    address: json['address'] as String,
    roles: (json['roles'] as List<dynamic>)
        .map((e) => Role.fromJson(e as Map<String, dynamic>))
        .toList(),
    avatar: Media.fromJson(json['avatar'] as Map<String, dynamic>),
    active: json['active'] as bool,
    lastOnline: DateTime.parse(json['lastOnline'] as String),
    online: json['online'] as bool,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'username': instance.username,
      'password': instance.password,
      'address': instance.address,
      'roles': instance.roles.map((e) => e.toJson()).toList(),
      'avatar': instance.avatar.toJson(),
      'active': instance.active,
      'online': instance.online,
      'lastOnline': instance.lastOnline.toIso8601String(),
    };
