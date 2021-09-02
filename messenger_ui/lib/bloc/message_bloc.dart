import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_ui/bloc_event/message_event.dart';
import 'package:messenger_ui/bloc_state/message_state.dart';
import 'package:messenger_ui/injection.dart';
import 'package:messenger_ui/repository/message_repository.dart';
class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageRepository messageRepository = getIt<MessageRepository>();

  MessageBloc() : super(MessageState());

  @override
  Stream<MessageState> mapEventToState(MessageEvent event) async* {
    if (event is GetMessage) {
      final messages = await messageRepository.getMessageByChatBoxId(chatBoxId: event.chatBoxId, size: event.size, page: event.page);
      yield GetMessageSuccess(messages: messages);
      }
    else
      yield MessageState();
  }
}