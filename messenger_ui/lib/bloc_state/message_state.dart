
import 'package:messenger_ui/model/message.dart';

class MessageState {

}

class Loading extends MessageState {

}

class GetMessageSuccess extends MessageState {
  final List<Message> messages;

  GetMessageSuccess({required this.messages});
}
