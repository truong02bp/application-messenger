import 'package:flutter/material.dart';
import 'package:messenger_ui/screens/sign_up/components/body.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
class SignUpScreen extends StatelessWidget {

  static final String routeName = "/sign-up";

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
          child: Body(),
        ),
      ),
    );
  }
}
