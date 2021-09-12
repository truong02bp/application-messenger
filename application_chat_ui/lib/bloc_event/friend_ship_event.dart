
import 'package:messenger_ui/model/user.dart';

class FriendShipEvent {

}

class AddFriendEvent extends FriendShipEvent {
  User friend;

  AddFriendEvent({required this.friend});
}

class DeleteFriendShipEvent extends FriendShipEvent {
  int friendShipId;

  DeleteFriendShipEvent({required this.friendShipId});
}

class ConfirmFriendShipEvent extends FriendShipEvent {
  int friendShipId;

  ConfirmFriendShipEvent({required this.friendShipId});
}