import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:messenger_ui/bloc/user_bloc.dart';
import 'package:messenger_ui/bloc_event/user_event.dart';
import 'package:messenger_ui/bloc_state/user_state.dart';
import 'package:messenger_ui/screens/home/home_screen.dart';
import 'package:messenger_ui/screens/login/components/body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  static final String routeName = "/login-screen";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late UserBloc _userBloc;
  bool isLogin = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userBloc = BlocProvider.of<UserBloc>(context);
    _userBloc.add(GetUserEvent());
    log('init');
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _userBloc,
      listener: (context, state) {
        if (state is GetUserSuccess && !isLogin) {
          setState(() {
            isLogin = true;
          });
          log('login add');
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName, arguments: {"user" : state.user});
        }
      },
      child: Scaffold(
        body: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background3.jpg"),
                  fit: BoxFit.cover)),
          child: LoginScreenBody(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
