import 'package:json_annotation/json_annotation.dart';
import 'package:messenger_ui/model/user.dart';
part 'friend_ship.g.dart';

@JsonSerializable()
class FriendShip {
  int id;
  User user; // user is request sender
  User friend; // friend is user receiver request
  bool isAccept;
  FriendShip({required this.id, required this.user, required this.friend, required this.isAccept});

  factory FriendShip.fromJson(Map<String, dynamic> json) => _$FriendShipFromJson(json);

  Map<String, dynamic> toJson() => _$FriendShipToJson(this);
}