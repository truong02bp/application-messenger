import 'package:flutter/material.dart';
import 'package:messenger_ui/screens/sign_up/components/body.dart';

class SignUpScreen extends StatelessWidget {

  static final String routeName = "/sign-up";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
