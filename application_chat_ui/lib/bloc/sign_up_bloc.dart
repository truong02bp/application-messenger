import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_ui/bloc_event/sign_up_event.dart';
import 'package:messenger_ui/bloc_state/sign_up_state.dart';
import 'package:messenger_ui/injection.dart';
import 'package:messenger_ui/model/dto/user_dto.dart';
import 'package:messenger_ui/repository/api_model.dart';
import 'package:messenger_ui/repository/user_repository.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {

  UserRepository userRepository = getIt<UserRepository>();

  SignUpBloc() : super(SignUpState());

  @override
  Stream<SignUpState> mapEventToState(event) async* {
    switch (event.runtimeType) {
      case SubmitFormEvent:
        event as SubmitFormEvent;
        yield Loading();
        List<String> errors = await validate(event);
        if (errors.isEmpty) {
          String otp = await userRepository.sendOtp(name: event.name, email: event.email);
          UserDto dto = new UserDto(username: event.username, password: event.password, email: event.email, name: event.name);
          yield AuthenticationOtp(otp: otp, userDto: dto);
        }
        else {
          yield SignUpFailure(errors: errors);
        }
        break;
      case SignUpRequest:
        event as SignUpRequest;
        final user = await userRepository.create(userDto: event.userDto);
        if (user != null) {
          yield SignUpSuccess();
        }
        else
          yield SignUpFailure(errors: ["Signup failure"]);
        break;
    }
  }
  
  Future<List<String>> validate(SubmitFormEvent event) async {
    List<String> errors = [];
    if (event.email.isEmpty) {
      errors.add("Email must be not empty");
    }
    else
      if (!event.email.contains("@gmail.com")){
        errors.add("Email must contains @gmail.com");
      }
    if (event.name.isEmpty) {
      errors.add("Name must be not empty");
    }
    if (event.password.isEmpty) {
      errors.add("Password must be not empty");
    }
    if (event.username.isEmpty) {
      errors.add("Username pas must be not empty");
    }
    if (event.confirmPassword != event.password) {
      errors.add("Confirm password isn't match the password");
    }
    if (event.email.isNotEmpty && event.username.isNotEmpty) {
      final listError = await userRepository.validate(username: event.username, email: event.email);
      errors.addAll(listError);
    }
    return errors;
  }



}
