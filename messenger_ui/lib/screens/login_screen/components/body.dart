import 'package:flutter/material.dart';

class LoginScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Spacer(
            flex: 6,
          ),
          Flexible(
            child: Text(
              'Welcome back',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
            ),
            flex: 3,
          ),
          Spacer(
            flex: 2,
          ),
          TextFormField(
            decoration: buildInputDecoration(
                hintText: 'Enter your username', labelText: 'Username'),
          ),
          Spacer(
            flex: 1,
          ),
          TextFormField(
            decoration: buildInputDecoration(
                hintText: 'Enter your password', labelText: 'Password'),
          ),
          Spacer(flex: 1,),
          InkWell(
            onTap: (){
              print('haha');
            },
            child: Container(
              height: 50,
              width: 75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.red
              ),
              child: Center(child: Text('Login', style: TextStyle(fontSize: 18, color: Colors.black),)),
            ),
          ),
          Spacer(
            flex: 6,
          ),
        ],
      ),
    );
  }

  InputDecoration buildInputDecoration({String? hintText, String? labelText}) {
    return InputDecoration(
        border: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        hintText: hintText == null ? "" : hintText,
        labelText: labelText == null ? "" : labelText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.all(20),
        hintStyle: TextStyle(
          color: Colors.white.withOpacity(0.85),
        ),
        labelStyle: TextStyle(
            color: Colors.white.withOpacity(0.85),
            fontWeight: FontWeight.bold));
  }

  var outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(50),
    borderSide: BorderSide(color: Colors.white.withOpacity(0.5)),
    gapPadding: 5,
  );
}
