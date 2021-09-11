
import 'package:messenger_ui/model/friend_ship.dart';
import 'package:messenger_ui/model/user.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_contact.g.dart';
@JsonSerializable()
class UserContact {
  User user;
  FriendShip? friendShip;

  UserContact({required this.user, this.friendShip});
  factory UserContact.fromJson(Map<String, dynamic> json) => _$UserContactFromJson(json);

  Map<String, dynamic> toJson() => _$UserContactToJson(this);
}