import 'package:flutter/material.dart';
import 'package:messenger_ui/routers.dart';
import 'package:messenger_ui/screens/login_screen/LoginScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:
          ThemeData(primarySwatch: Colors.pink, brightness: Brightness.light),
      themeMode: ThemeMode.light,
      darkTheme: ThemeData(
          primarySwatch: Colors.teal,
          primaryColor: Colors.orange,
          accentColor: Colors.orange,
          brightness: Brightness.dark),
      home: LoginScreen(),
      routes: routes,
    );
  }
}
