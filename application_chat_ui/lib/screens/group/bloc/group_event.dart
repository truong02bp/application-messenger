
import 'package:messenger_ui/model/user.dart';

class GroupEvent {

}

class AddMemberEvent extends GroupEvent {
  User user;

  AddMemberEvent({required this.user});
}

class RemoveMemberEvent extends GroupEvent {
  User user;

  RemoveMemberEvent({required this.user});
}

class GetFriendShipEvent extends GroupEvent {
  int page;
  int size;
  String name;

  GetFriendShipEvent({required this.page, required this.size, required this.name});
}

class CreateGroupEvent extends GroupEvent {
  Set<int> userIds;

  CreateGroupEvent({required this.userIds});
}