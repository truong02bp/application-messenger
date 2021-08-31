import 'package:flutter/material.dart';
import 'package:messenger_ui/blocs.dart';
import 'package:messenger_ui/injection.dart';
import 'package:messenger_ui/routers.dart';
import 'package:messenger_ui/screens/login/login_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
void main() {
  configureDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: blocs,
      child: MaterialApp(
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
      ),
    );
  }
}
