import 'dart:convert';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_ui/bloc_event/chat_box_event.dart';
import 'package:messenger_ui/bloc_state/chat_box_state.dart';
import 'package:messenger_ui/host_api.dart';
import 'package:messenger_ui/model/chat_box.dart';
import 'package:messenger_ui/model/message.dart';
import 'package:messenger_ui/repository/chat_box_repository.dart';
import 'package:messenger_ui/injection.dart';
import 'package:messenger_ui/repository/message_repository.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
class ChatBoxBloc extends Bloc<ChatBoxEvent, ChatBoxState> {

  ChatBoxRepository chatBoxRepository = getIt<ChatBoxRepository>();
  MessageRepository messageRepository = getIt<MessageRepository>();
  static StompClient? stompClient;

  ChatBoxBloc() : super(ChatBoxState());

  @override
  Stream<ChatBoxState> mapEventToState(ChatBoxEvent event) async* {
    switch (event.runtimeType) {
      case GetAllChatBox:
        event as GetAllChatBox;
        final chatBoxes = await chatBoxRepository.getAllChatBoxByUserId(userId: event.userId);
        if (chatBoxes.isNotEmpty) {
          connect(chatBoxes);
          yield GetAllChatBoxSuccess(chatBoxes: chatBoxes);
        }
        else
          yield GetAllChatBoxFailure();
        break;
      case GetMessage:
        event as GetMessage;
        final messages = await messageRepository.getMessageByChatBoxId(chatBoxId: event.chatBoxId, size: event.size, page: event.page);
        yield GetMessageSuccess(messages: messages);
        break;
      case NewMessageEvent:
        event as NewMessageEvent;
        yield NewMessageState(chatBoxId: event.chatBoxId, message: event.message);
    }
  }

  void connect(List<ChatBox> chatBoxes) {
    if (stompClient != null)
      stompClient!.deactivate();
    stompClient = StompClient(
        config: StompConfig(
          url: 'ws://$host:8080/ws-chat',
          onConnect: (StompFrame client) {
            chatBoxes.forEach((chatBox) {
              stompClient!.subscribe(
                  destination: '/topic/${chatBox.id}',
                  callback: (StompFrame frame) {
                    Message message = Message.fromJson(jsonDecode(frame.body!));
                    add(NewMessageEvent(message: message, chatBoxId: chatBox.id));
                  });
            });
            log('Connected');
          },
          onWebSocketError: (dynamic error) => print(error.toString()),
        ));
    stompClient!.activate();

    //   client.subscribe(destination: '/topic/update/seen', callback: (StompFrame frame){
    //     List<Message> messages = jsonDecode(frame.body).map<Message>((json) => Message.fromJson(json)).toList();
    //     add(UpdateMessageSeenEvent(messages: messages));
    //   });
    //   client.subscribe(destination: '/topic/update/reaction', callback: (StompFrame frame){
    //     Message message = Message.fromJson(jsonDecode(frame.body));
    //     add(UpdateMessageReactionEvent(message: message));
    //   });
  }
}