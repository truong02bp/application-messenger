
import 'package:flutter/cupertino.dart';
import 'package:messenger_ui/screens/chat_box/chat_box_screen.dart';
import 'package:messenger_ui/screens/chat_box/components/image_card.dart';
import 'package:messenger_ui/screens/forgot_password/forgot_password_screen.dart';
import 'package:messenger_ui/screens/group/group_screen.dart';
import 'package:messenger_ui/screens/home/home_screen.dart';
import 'package:messenger_ui/screens/login/login_screen.dart';
import 'package:messenger_ui/screens/search_screen/search_screen.dart';
import 'package:messenger_ui/screens/sign_up/sign_up_screen.dart';
import 'package:messenger_ui/screens/video_call/video_call_screen.dart';

final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName : (context) => LoginScreen(),
  HomeScreen.routeName : (context) => HomeScreen(),
  ChatBoxScreen.routeName : (context) => ChatBoxScreen(),
  FullScreenImage.routeName : (context) => FullScreenImage(),
  VideoCallScreen.routeName : (context) => VideoCallScreen(),
  SignUpScreen.routeName : (context) => SignUpScreen(),
  ForgotPasswordScreen.routeName : (context) => ForgotPasswordScreen(),
  SearchScreen.routeName : (context) => SearchScreen(),
  GroupScreen.routeName : (context) => GroupScreen(),
};