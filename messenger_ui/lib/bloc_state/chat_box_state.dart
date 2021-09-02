
import 'package:messenger_ui/model/chat_box.dart';
import 'package:messenger_ui/model/message.dart';

class ChatBoxState {

}

class GetAllChatBoxSuccess extends ChatBoxState {
  List<ChatBox> chatBoxes;

  GetAllChatBoxSuccess({required this.chatBoxes});
}

class GetAllChatBoxFailure extends ChatBoxState {

}

class GetMessageSuccess extends ChatBoxState {
  final List<Message> messages;

  GetMessageSuccess({required this.messages});
}

class NewMessageState extends ChatBoxState {
  final int chatBoxId;
  final Message message;

  NewMessageState({required this.chatBoxId, required this.message});
}