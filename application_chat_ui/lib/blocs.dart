import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_ui/bloc/chat_box_bloc.dart';
import 'package:messenger_ui/bloc/login_bloc.dart';
import 'package:messenger_ui/bloc/message_bloc.dart';
import 'package:messenger_ui/bloc/sign_up_bloc.dart';

final List<BlocProvider> blocs = [
  BlocProvider<LoginBloc>(create: (context) => LoginBloc(),),
  BlocProvider<ChatBoxBloc>(create: (context) => ChatBoxBloc(),),
  BlocProvider<MessageBloc>(create: (context) => MessageBloc(),),
  BlocProvider<SignUpBloc>(create: (context) => SignUpBloc(),),
];