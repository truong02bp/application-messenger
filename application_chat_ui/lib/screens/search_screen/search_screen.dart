import 'package:flutter/material.dart';

import 'components/body.dart';
class SearchScreen extends StatefulWidget {

  static final String routeName = "/search-screen";

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String keySearch = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 40,
          child: TextFormField(
            onChanged: (value){
              setState(() {
                keySearch = value;
              });
            },
            decoration: InputDecoration(
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: 'Search',
              hintStyle: TextStyle(
                color: Colors.deepOrangeAccent,
              ),
            ),
          ),
        ),
      ),
      body: Body(keySearch: keySearch),
    );
  }
}
