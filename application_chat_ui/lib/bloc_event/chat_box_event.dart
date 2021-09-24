import 'package:flutter/cupertino.dart';
import 'package:messenger_ui/model/message.dart';

class ChatBoxEvent {}

class GetAllChatBox extends ChatBoxEvent {
  int userId;
  final int size;
  final int page;
  GetAllChatBox({required this.userId, required this.size, required this.page});
}

class GetChatBoxMostMessage extends ChatBoxEvent {
  int userId;
  final int size;
  final int page;
  GetChatBoxMostMessage({required this.userId, required this.size, required this.page});
}

class GetMessage extends ChatBoxEvent {
  final int chatBoxId;
  final int size;
  final int page;

  GetMessage({required this.chatBoxId, required this.size, required this.page});
}

class NewMessageEvent extends ChatBoxEvent {
  final int chatBoxId;
  final Message message;

  NewMessageEvent({required this.chatBoxId, required this.message});
}

class UpdateMessageSeenEvent extends ChatBoxEvent {
  final List<Message> messages;

  UpdateMessageSeenEvent({required this.messages});
}

class UpdateMessageReactionEvent extends ChatBoxEvent {
  final Message message;

  UpdateMessageReactionEvent({required this.message});
}

class GetChatBox extends ChatBoxEvent {
  int id;
  int userId;
  GetChatBox({required this.id, required this.userId});
}
