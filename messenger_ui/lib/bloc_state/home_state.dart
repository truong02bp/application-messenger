
import 'package:messenger_ui/model/chat_box.dart';

class HomeState {

}

class GetAllChatBoxSuccess extends HomeState {
  List<ChatBox> chatBoxes;

  GetAllChatBoxSuccess({required this.chatBoxes});
}

class GetAllChatBoxFailure extends HomeState {

}