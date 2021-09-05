
import 'dart:developer';

import 'package:messenger_ui/bloc_event/login_event.dart';
import 'package:messenger_ui/bloc_state/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_ui/injection.dart';
import 'package:messenger_ui/model/user.dart';
import 'package:messenger_ui/repository/user_repository.dart';
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository userRepository = getIt<UserRepository>();
  User? currentUser;
  LoginBloc() : super(LoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    // TODO: implement mapEventToState
    switch (event.runtimeType) {
      case SubmitLogin:
        event as SubmitLogin;
        yield Loading();
        List<String> errors = validateInfo(event.username, event.password);
        if (errors.isEmpty) {
          final user = await userRepository.login(event.username, event.password);
          if (user != null) {
            currentUser = user;
            yield LoginSuccess(user: user);
          } else {
            errors.add("Username, password incorrect");
            yield LoginFailure(errors: errors);
          }
        }
        else {
          yield LoginFailure(errors: errors);
        }
        break;
      case UpdateOnlineEvent:
        log("online");
        User user = await userRepository.updateOnline(id: currentUser!.id, online: true);
        yield UpdateOnlineSuccess(user: user);
        break;
      case UpdateOfflineEvent:
        log("offline");
        User user = await userRepository.updateOnline(id: currentUser!.id, online: false);
        yield UpdateOnlineSuccess(user: user);
        break;
    }
    if (event is UpdateOnlineEvent) {

    }
    if (event is UpdateOfflineEvent) {

    }
    else
      yield LoginState();
  }


  List<String> validateInfo(String username, String password) {
    List<String> errors = [];
    if (username.isEmpty)
      errors.add("Username must be not empty");
    if (password.isEmpty)
      errors.add("Password must be not empty");
    return errors;
  }
}