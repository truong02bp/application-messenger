
class LoginEvent {

}

class SubmitLogin extends LoginEvent {
  String username;
  String password;

  SubmitLogin({required this.username, required this.password});
}