import 'package:messenger_ui/model/dto/user_dto.dart';

class SignUpState {}

class Loading extends SignUpState {}

class SignUpFailure extends SignUpState {
  List<String> errors;

  SignUpFailure({required this.errors});
}

class SignUpSuccess extends SignUpState {

}

class AuthenticationOtp extends SignUpState {
  String otp;
  UserDto userDto;
  AuthenticationOtp({required this.otp, required this.userDto});
}
