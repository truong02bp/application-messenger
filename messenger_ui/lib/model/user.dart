
import 'package:json_annotation/json_annotation.dart';
import 'package:messenger_ui/model/media.dart';
import 'package:messenger_ui/model/role.dart';
part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  int id;
  String name;
  String username;
  String password;
  String address;
  List<Role> roles;
  Media avatar;
  bool active;
  bool online;
  DateTime lastOnline;
  User({required this.id, required this.name, required this.username,
    required this.password, required this.address, required this.roles,
    required this.avatar, required this.active, required this.lastOnline, required this.online});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}