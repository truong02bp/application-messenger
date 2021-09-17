
import 'package:messenger_ui/model/friend_ship.dart';

class FriendShipState {

}

class SendAddFriendSuccess extends FriendShipState {
  FriendShip friendShip;

  SendAddFriendSuccess({required this.friendShip});
}

class ConfirmFriendShipSuccess extends FriendShipState {
  FriendShip friendShip;

  ConfirmFriendShipSuccess({required this.friendShip});
}

class DeleteFriendShipSuccess extends FriendShipState {
  int friendShipId;

  DeleteFriendShipSuccess({required this.friendShipId});
}
