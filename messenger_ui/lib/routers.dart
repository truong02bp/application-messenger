
import 'package:flutter/cupertino.dart';
import 'package:messenger_ui/screens/chat_box/chat_box_screen.dart';
import 'package:messenger_ui/screens/home/home_screen.dart';
import 'package:messenger_ui/screens/login/login_screen.dart';

final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName : (context) => LoginScreen(),
  HomeScreen.routeName : (context) => HomeScreen(),
  ChatBoxScreen.routeName : (context) => ChatBoxScreen(),
};