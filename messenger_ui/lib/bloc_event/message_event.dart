
import 'package:messenger_ui/model/dto/message_dto.dart';

class MessageEvent {

}

class SendMessage extends MessageEvent {
  MessageDto messageDto;
  SendMessage({required this.messageDto});
}