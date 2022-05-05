import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:messenger_ui/bloc/user_bloc.dart';
import 'package:messenger_ui/bloc_event/user_event.dart';
import 'package:messenger_ui/bloc_state/user_state.dart';
import 'package:messenger_ui/model/user.dart';
import 'package:messenger_ui/screens/home/components/body.dart';
import 'package:messenger_ui/screens/home/components/home_drawer.dart';
import 'package:messenger_ui/screens/home/components/search_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class HomeScreen extends StatefulWidget {
  static final String routeName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late UserBloc _userBloc;
  User? user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userBloc = BlocProvider.of<UserBloc>(context);
    _userBloc.add(GetUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _userBloc,
      listener: (context, state) {
        if (state is UpdateUserSuccess) {
          setState(() {
            user = state.user;
          });
        }
        if (state is GetUserSuccess) {
          setState(() {
            user = state.user;
          });
        }
      },
      child: user != null ? Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Người trồng cà chua', style: TextStyle(color: Colors.deepOrangeAccent),),
              Container(
                height: 40,
                width: 40,
                child: Image.asset("assets/images/tomato_tree.png"),
              )
            ],
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(height: 20,),
                SearchBar(),
                SizedBox(height: 20,),
                Expanded(child: Body(user: user!)),
              ],
            ),
          ),
        ),
        drawer: Drawer(
            child: HomeDrawer(user: user!,)
        ),
      ) : Center(
        child: Container(
          height: 40,
          width: 40,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

