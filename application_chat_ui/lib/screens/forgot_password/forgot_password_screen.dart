import 'package:flutter/material.dart';
import 'package:messenger_ui/screens/forgot_password/components/body.dart';

class ForgotPasswordScreen extends StatelessWidget {

  static final String routeName = "/forgot-password";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
