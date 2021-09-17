
import 'package:messenger_ui/model/friend_ship.dart';
import 'package:messenger_ui/model/user.dart';

class GroupState {

}

class AddMemberSuccess extends GroupState {
  User user;
  AddMemberSuccess({required this.user});
}


class RemoveMemberSuccess extends GroupState {
  User user;
  RemoveMemberSuccess({required this.user});
}

class GetFriendShipSuccess extends GroupState {
  List<FriendShip> friendShips;

  GetFriendShipSuccess({required this.friendShips});
}

class CreateGroupSuccess extends GroupState {

}