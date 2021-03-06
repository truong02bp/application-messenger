import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messenger_ui/screens/group/bloc/group_bloc.dart';
import 'package:messenger_ui/screens/group/components/body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class GroupScreen extends StatelessWidget {
  static final String routeName = "/group-screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New group'),
        centerTitle: true,
        actions: [
          Container(
            height: 50,
            width: 50,
            padding: EdgeInsets.all(5),
            child: Image.asset("assets/images/tomato_tree.png"),
          )
        ],
      ),
      body: BlocProvider(
          create: (context) => GroupBloc(),
          child: Body()
      ),
    );
  }
}
