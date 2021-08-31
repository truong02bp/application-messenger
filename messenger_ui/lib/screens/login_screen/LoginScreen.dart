import 'package:flutter/material.dart';
import 'package:messenger_ui/screens/login_screen/components/body.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
class LoginScreen extends StatelessWidget {

  static final String routeName = "/login-screen";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      gestures: [GestureType.onTap],
      child: Scaffold(
        body: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background3.jpg"),
              fit: BoxFit.cover
            )
          ),
          child: LoginScreenBody(),
        ),
      ),
    );
  }
}
