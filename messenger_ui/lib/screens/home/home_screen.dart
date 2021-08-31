import 'package:flutter/material.dart';
import 'package:messenger_ui/model/user.dart';

class HomeScreen extends StatelessWidget {
  static final String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    User user = args["user"];
    return Container(
      child: Text(user.name),
    );
  }
}
