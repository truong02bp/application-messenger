import 'package:messenger_ui/model/user.dart';

class UserEvent {}

class SubmitLogin extends UserEvent {
  String username;
  String password;

  SubmitLogin({required this.username, required this.password});
}

class UpdateOnlineEvent extends UserEvent {}

class UpdateOfflineEvent extends UserEvent {}

class GetUserContact extends UserEvent {
  String name;
  int page;
  int size;

  GetUserContact({required this.name, required this.page, required this.size});
}
