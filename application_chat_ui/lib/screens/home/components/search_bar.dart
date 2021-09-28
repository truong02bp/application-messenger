import 'package:flutter/material.dart';
import 'package:messenger_ui/screens/search_screen/search_screen.dart';

class SearchBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        onTap: (){
          Navigator.of(context).pushNamed(SearchScreen.routeName);
        },
        readOnly: true,
        decoration: InputDecoration(
            hintText: "Search",
            disabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search, color: Colors.deepOrangeAccent,)
        ),
      ),
    );
  }
}