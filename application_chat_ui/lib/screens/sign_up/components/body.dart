import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:messenger_ui/screens/sign_up/components/sign_up_form.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(flex: 1,),
        Flexible(
          flex: 4,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 50, left: 25, right: 25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Create an account', style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25
                ),),
                Expanded(child: SignUpForm())
              ],
            ),
          ),
        ),
      ],
    );
  }
}
