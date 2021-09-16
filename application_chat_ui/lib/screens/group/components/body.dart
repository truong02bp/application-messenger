import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    final border = UnderlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.deepOrangeAccent, width: 0.8));
    return Column(
      children: [
        TextFormField(
          onChanged: (value){

          },
          decoration: InputDecoration(
            focusedBorder: border,
            enabledBorder: border,
            errorBorder: border,
            disabledBorder: border,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: EdgeInsets.only(left: 20),
            hintText: 'Add people',
            hintStyle: TextStyle(
              color: Colors.deepOrangeAccent,
            ),
          ),
        ),
      ],
    );
  }
}
