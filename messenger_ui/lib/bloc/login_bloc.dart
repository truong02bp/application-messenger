
import 'package:messenger_ui/bloc_event/login_event.dart';
import 'package:messenger_ui/bloc_state/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class LoginBLoc extends Bloc<LoginEvent, LoginState> {

  LoginBLoc() : super(LoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }

}