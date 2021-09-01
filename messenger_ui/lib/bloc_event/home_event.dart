
class HomeEvent {

}

class GetAllChatBox extends HomeEvent {
  int userId;

  GetAllChatBox({required this.userId});
}