import 'package:flutter/material.dart';
import 'package:messenger_ui/model/user.dart';
import 'package:messenger_ui/screens/home/components/body.dart';
import 'package:messenger_ui/screens/home/components/home_drawer.dart';
import 'package:messenger_ui/screens/home/components/search_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
class HomeScreen extends StatelessWidget {
  static final String routeName = "/home";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    User user = args["user"];
    return Scaffold(
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
              Body(user: user),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: HomeDrawer(user: user,)
      ),
    );
  }
}

