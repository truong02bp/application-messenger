import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_ui/bloc_event/message_event.dart';
import 'package:messenger_ui/bloc_state/message_state.dart';
import 'package:messenger_ui/injection.dart';
import 'package:messenger_ui/model/dto/media_dto.dart';
import 'package:messenger_ui/model/media.dart';
import 'package:messenger_ui/repository/media_repository.dart';
import 'package:messenger_ui/repository/message_repository.dart';
class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageRepository messageRepository = getIt<MessageRepository>();
  MediaRepository mediaRepository = getIt<MediaRepository>();

  MessageBloc() : super(MessageState());

  @override
  Stream<MessageState> mapEventToState(MessageEvent event) async* {
    switch (event.runtimeType) {
      case GetMessage:
        event as GetMessage;
        final messages = await messageRepository.getMessageByChatBoxId(chatBoxId: event.chatBoxId, size: event.size, page: event.page);
        yield GetMessageSuccess(messages: messages);
        break;
      case SendMessage:
        yield Loading();
        event as SendMessage;
        if (event.messageDto.isMedia) {
          Media image = await mediaRepository.upload(mediaDto: MediaDto(name: event.messageDto.name!, bytes: event.messageDto.bytes!));
          event.messageDto.mediaId = image.id;
          event.messageDto.bytes = null;
        }
        // ChatBoxBloc.stompClient.send(destination: "/app/message/send", body: jsonEncode(event.messageDto), headers : headers);
        break;
    }
  }
}