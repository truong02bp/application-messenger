import 'package:json_annotation/json_annotation.dart';
import 'package:messenger_ui/model/user.dart';
part 'friend_ship.g.dart';

@JsonSerializable()
class FriendShip {
  int? id;
  User user; // user is request sender
  User friend; // friend is user receiver request
  bool accepted;
  FriendShip({this.id, required this.user, required this.friend, required this.accepted});

  factory FriendShip.fromJson(Map<String, dynamic> json) => _$FriendShipFromJson(json);

  Map<String, dynamic> toJson() => _$FriendShipToJson(this);
}