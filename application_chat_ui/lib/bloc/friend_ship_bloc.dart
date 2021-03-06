import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_ui/bloc_event/friend_ship_event.dart';
import 'package:messenger_ui/bloc_state/friend_ship_state.dart';
import 'package:messenger_ui/repository/friend_ship_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../injection.dart';

class FriendShipBloc extends Bloc<FriendShipEvent, FriendShipState> {

  FriendShipBloc() : super(FriendShipState());
  FriendShipRepository friendShipRepository = getIt<FriendShipRepository>();
  late int userId;
  @override
  Stream<FriendShipState> mapEventToState(FriendShipEvent event) async* {
    switch (event.runtimeType) {
      case AddFriendEvent:
        event as AddFriendEvent;
        SharedPreferences preferences = await SharedPreferences.getInstance();
        userId = preferences.getInt("userId")!;
        final friendShip = await friendShipRepository.create(userId: userId, friendId: event.friend.id);
        yield SendAddFriendSuccess(friendShip: friendShip);
        break;

      case ConfirmFriendShipEvent:
        event as ConfirmFriendShipEvent;
        final friendShip = await friendShipRepository.confirmFriendShip(id: event.friendShipId);
        yield ConfirmFriendShipSuccess(friendShip: friendShip);
        break;

      case DeleteFriendShipEvent:
        event as DeleteFriendShipEvent;
        friendShipRepository.delete(id: event.friendShipId);
        yield DeleteFriendShipSuccess(friendShipId: event.friendShipId);
        break;
    }
  }

}