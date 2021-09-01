import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_ui/bloc_event/home_event.dart';
import 'package:messenger_ui/bloc_state/home_state.dart';
import 'package:messenger_ui/repository/chat_box_repository.dart';
import 'package:messenger_ui/injection.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  ChatBoxRepository chatBoxRepository = getIt<ChatBoxRepository>();

  HomeBloc() : super(HomeState());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is GetAllChatBox) {
      final chatBoxes = await chatBoxRepository.getAllChatBoxByUserId(userId: event.userId);
      if (chatBoxes.isNotEmpty) {
        yield GetAllChatBoxSuccess(chatBoxes: chatBoxes);
      }
      else
        yield GetAllChatBoxFailure();
    }
    else
      yield HomeState();
  }

}