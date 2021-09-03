
import 'package:messenger_ui/model/message.dart';

class ChatBoxEvent {

}

class GetAllChatBox extends ChatBoxEvent {
  int userId;

  GetAllChatBox({required this.userId});
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

