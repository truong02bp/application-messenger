import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_ui/bloc/home_bloc.dart';
import 'package:messenger_ui/bloc/login_bloc.dart';

final blocs = [
  BlocProvider<LoginBloc>(create: (context) => LoginBloc(),),
  BlocProvider<HomeBloc>(create: (context) => HomeBloc(),),
];