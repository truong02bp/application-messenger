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
        themeMode: ThemeMode.light,
        darkTheme: ThemeData(
          // brightness: Brightness.dark,
          primaryColor: Color(0x02596be),
          accentColor: Colors.blueAccent,
          backgroundColor: Color(0x02596be),
          hintColor: Colors.deepOrangeAccent,
          bottomAppBarColor: Colors.grey,
          textTheme: TextTheme(
            title: TextStyle(
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
