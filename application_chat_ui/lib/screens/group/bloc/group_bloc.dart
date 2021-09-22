import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_ui/injection.dart';
import 'package:messenger_ui/repository/chat_box_repository.dart';
import 'package:messenger_ui/repository/friend_ship_repository.dart';
import 'package:messenger_ui/screens/group/bloc/group_event.dart';
import 'package:messenger_ui/screens/group/bloc/group_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
class GroupBloc extends Bloc<GroupEvent, GroupState> {

  FriendShipRepository friendShipRepository = getIt<FriendShipRepository>();
  ChatBoxRepository chatBoxRepository = getIt<ChatBoxRepository>();

  GroupBloc() : super(GroupState());
  @override
  Stream<GroupState> mapEventToState(GroupEvent event) async* {
    switch (event.runtimeType) {
      case GetFriendShipEvent:
        SharedPreferences preferences = await SharedPreferences.getInstance();
        int userId = preferences.getInt("userId")!;
        event as GetFriendShipEvent;
        if (event.page == 0)
          yield Loading();
        final friendShips = await friendShipRepository.findByUserIdAndName(userId: userId, name: event.name, page: event.page, size: event.size);
        yield GetFriendShipSuccess(friendShips: friendShips);
        break;
      case AddMemberEvent:
        event as AddMemberEvent;
        yield AddMemberSuccess(user: event.user);
        break;

      case RemoveMemberEvent:
        event as RemoveMemberEvent;
        yield RemoveMemberSuccess(user: event.user);
        break;

      case CreateGroupEvent:
        event as CreateGroupEvent;
        yield Loading();
        await chatBoxRepository.createGroup(userIds: event.userIds);
        yield CreateGroupSuccess();
    }
  }
}
