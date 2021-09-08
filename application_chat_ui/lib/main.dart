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
        theme: ThemeData(primarySwatch: Colors.pink, brightness: Brightness.light),
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Color(0xff263238),
          accentColor: Color(0xfff78379).withOpacity(0.75),
          backgroundColor: Color(0xff263238),
          popupMenuTheme: PopupMenuThemeData(
            color: Colors.white,
            textStyle: TextStyle(color: Colors.black),
          ),
          scaffoldBackgroundColor: Color(0xff263238),
          primaryColorDark: Color(0xff263238),
          hintColor: Colors.deepOrangeAccent,
          bottomAppBarColor: Color(0xff263238),
          textTheme: TextTheme(
            headline6: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        home: LoginScreen(),
        routes: routes,
      ),
    );
  }
}
