
import 'package:messenger_ui/model/dto/message_dto.dart';

class MessageEvent {

}

class GetMessage extends MessageEvent {
  final int chatBoxId;
  final int size;
  final int page;

  GetMessage({required this.chatBoxId, required this.size, required this.page});

}

class SendMessage extends MessageEvent {
  MessageDto messageDto;
  SendMessage({required this.messageDto});
}