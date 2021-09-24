import 'package:messenger_ui/model/chat_box.dart';
import 'package:messenger_ui/model/message.dart';

class ChatBoxState {}

class GetAllChatBoxSuccess extends ChatBoxState {
  List<ChatBox> chatBoxes;

  GetAllChatBoxSuccess({required this.chatBoxes});
}

class GetAllOldChatBoxSuccess extends ChatBoxState {
  List<ChatBox> chatBoxes;

  GetAllOldChatBoxSuccess({required this.chatBoxes});
}

class GetAllChatBoxFailure extends ChatBoxState {}

class GetMessageSuccess extends ChatBoxState {
  final List<Message> messages;

  GetMessageSuccess({required this.messages});
}

class NewMessageState extends ChatBoxState {
  final int chatBoxId;
  final Message message;

  NewMessageState({required this.chatBoxId, required this.message});
}

class UpdateMessageSuccess extends ChatBoxState {
  final Message message;

  UpdateMessageSuccess({required this.message});
}

class UpdateMessageSeenSuccess extends ChatBoxState {
  final List<Message> messages;
  final int chatBoxId;

  UpdateMessageSeenSuccess({required this.messages, required this.chatBoxId});
}

class UpdateMessageReactionSuccess extends ChatBoxState {
  final Message message;
  final int chatBoxId;

  UpdateMessageReactionSuccess(
      {required this.message, required this.chatBoxId});
}

class GetChatBoxSuccess extends ChatBoxState {
  ChatBox chatBox;

  GetChatBoxSuccess({required this.chatBox});
}
