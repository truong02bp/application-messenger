
class MessageEvent {

}

class GetMessage extends MessageEvent {
  final int chatBoxId;
  final int size;
  final int page;

  GetMessage({required this.chatBoxId, required this.size, required this.page});

}