class UserEvent {}

class SubmitLogin extends UserEvent {
  String username;
  String password;

  SubmitLogin({required this.username, required this.password});
}

class UpdateOnlineEvent extends UserEvent {}

class UpdateOfflineEvent extends UserEvent {}

class GetUserByName extends UserEvent {
  String name;
  int page;
  int size;

  GetUserByName({required this.name, required this.page, required this.size});
}
