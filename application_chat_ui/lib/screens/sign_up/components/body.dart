import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Flexible(
          child: Text(
            'Sign up',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
          ),
          flex: 3,
        ),
      ],
    );
  }
}
