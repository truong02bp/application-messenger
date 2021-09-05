import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_ui/bloc/chat_box_bloc.dart';
import 'package:messenger_ui/bloc_event/message_event.dart';
import 'package:messenger_ui/bloc_state/message_state.dart';
import 'package:messenger_ui/injection.dart';
import 'package:messenger_ui/model/dto/media_dto.dart';
import 'package:messenger_ui/model/media.dart';
import 'package:messenger_ui/repository/media_repository.dart';
import 'package:messenger_ui/repository/message_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageRepository messageRepository = getIt<MessageRepository>();
  MediaRepository mediaRepository = getIt<MediaRepository>();
  static int chatBoxIdUpdate = -1;
  MessageBloc() : super(MessageState());

  @override
  Stream<MessageState> mapEventToState(MessageEvent event) async* {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    Map<String,String> headers = {'Authorization' : token!};
    switch (event.runtimeType) {
      case SendMessage:
        yield Loading();
        event as SendMessage;
        if (event.messageDto.isMedia!) {
          Media image = await mediaRepository.upload(mediaDto: MediaDto(name: event.messageDto.name!, bytes: event.messageDto.bytes!));
          event.messageDto.mediaId = image.id;
          event.messageDto.bytes = null;
        }
        ChatBoxBloc.stompClient!.send(destination: "/app/message/send", body: jsonEncode(event.messageDto), headers : headers);
        break;
      case UpdateMessageEvent:
        event as UpdateMessageEvent;
        chatBoxIdUpdate = event.messageDto.chatBoxId;
        if (event.option == "seen")
          ChatBoxBloc.stompClient!.send(destination: "/app/message/update/seen", body: jsonEncode(event.messageDto), headers: headers);
        else
        if (event.option == "reaction") {
          ChatBoxBloc.stompClient!.send(destination: "/app/message/update/reaction", body: jsonEncode(event.messageDto), headers: headers);
        }
    }
  }
}