import 'package:messenger_ui/model/dto/user_contact.dart';
import 'package:messenger_ui/model/friend_ship.dart';
import 'package:messenger_ui/model/user.dart';

class UserState {}

class Loading extends UserState {}

class LoginSuccess extends UserState {
  final User user;

  LoginSuccess({required this.user});
}

class LoginFailure extends UserState {
  final List<String> errors;

  LoginFailure({required this.errors});
}

class UpdateOnlineSuccess extends UserState {
  final User user;

  UpdateOnlineSuccess({required this.user});
}

class GetUserContactSuccess extends UserState {
  List<UserContact> userContacts;

  GetUserContactSuccess({required this.userContacts});
}

class UserSavedState extends UserState {
  User user;

  UserSavedState({required this.user});
}

class UserNotSavedState extends UserState {

}
