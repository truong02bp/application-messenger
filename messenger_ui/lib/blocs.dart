import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_ui/bloc/home_bloc.dart';
import 'package:messenger_ui/bloc/login_bloc.dart';
import 'package:messenger_ui/bloc/message_bloc.dart';

final List<BlocProvider> blocs = [
  BlocProvider<LoginBloc>(create: (context) => LoginBloc(),),
  BlocProvider<HomeBloc>(create: (context) => HomeBloc(),),
  BlocProvider<MessageBloc>(create: (context) => MessageBloc(),),
];