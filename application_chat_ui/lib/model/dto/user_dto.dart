import 'package:json_annotation/json_annotation.dart';
part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  String username;
  String password;
  String email;
  String name;

  UserDto({required this.username, required this.password, required this.email, required this.name});
  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}