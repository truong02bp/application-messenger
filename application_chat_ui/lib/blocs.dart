import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_ui/bloc/chat_box_bloc.dart';
import 'package:messenger_ui/bloc/friend_ship_bloc.dart';
import 'package:messenger_ui/bloc/user_bloc.dart';
import 'package:messenger_ui/bloc/message_bloc.dart';
import 'package:messenger_ui/bloc/sign_up_bloc.dart';

final List<BlocProvider> blocs = [
  BlocProvider<UserBloc>(create: (context) => UserBloc(),),
  BlocProvider<ChatBoxBloc>(create: (context) => ChatBoxBloc(),),
  BlocProvider<MessageBloc>(create: (context) => MessageBloc(),),
  BlocProvider<SignUpBloc>(create: (context) => SignUpBloc(),),
  BlocProvider<FriendShipBloc>(create: (context) => FriendShipBloc(),),
];