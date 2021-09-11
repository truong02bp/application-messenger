// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDto _$UserDtoFromJson(Map<String, dynamic> json) {
  return UserDto(
    username: json['username'] as String,
    password: json['password'] as String,
    email: json['email'] as String,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'email': instance.email,
      'name': instance.name,
    };
