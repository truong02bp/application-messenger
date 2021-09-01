import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_ui/bloc_event/home_event.dart';
import 'package:messenger_ui/bloc_state/home_state.dart';
class HomeBloc extends Bloc<HomeEvent, HomeState> {

  HomeBloc() : super(HomeState());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }

}