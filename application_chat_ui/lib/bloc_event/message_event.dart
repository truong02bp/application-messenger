
import 'package:messenger_ui/model/dto/message_dto.dart';

class MessageEvent {

}

class SendMessage extends MessageEvent {
  MessageDto messageDto;
  SendMessage({required this.messageDto});
}

class UpdateMessageEvent extends MessageEvent {
  final String option;
  final MessageDto messageDto;

  UpdateMessageEvent({required this.messageDto, required this.option});
}