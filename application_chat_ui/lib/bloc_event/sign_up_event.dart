import 'package:messenger_ui/model/dto/user_dto.dart';

class SignUpEvent {}

class SubmitFormEvent extends SignUpEvent {
  String username;
  String password;
  String confirmPassword;
  String email;
  String name;

  SubmitFormEvent(
      {required this.username,
      required this.password,
      required this.confirmPassword,
      required this.email,
      required this.name});
}

class ValidateOtp extends SignUpEvent {
  String otp;

  ValidateOtp({required this.otp});
}

class SignUpRequest extends SignUpEvent {
  UserDto userDto;

  SignUpRequest({required this.userDto});
}