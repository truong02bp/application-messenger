
import 'package:messenger_ui/model/user.dart';

class LoginState {

}

class Loading extends LoginState {

}

class LoginSuccess extends LoginState {
  final User user;

  LoginSuccess({required this.user});
}

class LoginFailure extends LoginState {
  final List<String> errors;

  LoginFailure({required this.errors});
}

class UpdateOnlineSuccess extends LoginState {
  final User user;
  UpdateOnlineSuccess({required this.user});
}