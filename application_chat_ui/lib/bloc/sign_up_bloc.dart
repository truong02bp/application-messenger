import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_ui/bloc_event/sign_up_event.dart';
import 'package:messenger_ui/bloc_state/sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpState());

  @override
  Stream<SignUpState> mapEventToState(event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }
}
