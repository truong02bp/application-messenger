import 'package:flutter/material.dart';
import 'package:messenger_ui/model/user.dart';
import 'package:messenger_ui/screens/home/components/body.dart';
import 'package:messenger_ui/screens/home/components/header.dart';
import 'package:messenger_ui/screens/home/components/search_bar.dart';

class HomeScreen extends StatelessWidget {
  static final String routeName = "/home";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    User user = args["user"];
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Header(user: user),
              SizedBox(height: 20,),
              SearchBar(),
              SizedBox(height: 20,),
              Body(user: user),
            ],
          ),
        ),
      ),
    );
  }
}

