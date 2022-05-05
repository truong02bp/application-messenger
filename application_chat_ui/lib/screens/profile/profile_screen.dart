
import 'package:flutter/material.dart';
import 'package:messenger_ui/model/user.dart';

import 'components/body.dart';

class ProfileScreen extends StatelessWidget {

  static final String routeName = "/profile";

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    User user = arguments["user"];
    return Scaffold(
      body: Body(user: user,),
    );
  }
}
