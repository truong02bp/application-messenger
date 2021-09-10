import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(
          flex: 1,
        ),
        TextFormField(
          style: TextStyle(color: Colors.black, fontSize: 17),
          decoration: buildInputDecoration(
              labelText: 'NAME',
              hintText: 'Enter your name',
              icon: Icon(
                Icons.people_outline,
                color: Colors.black,
              )),
        ),
        Spacer(
          flex: 1,
        ),
        TextFormField(
          style: TextStyle(color: Colors.black, fontSize: 17),
          decoration: buildInputDecoration(
              labelText: 'EMAIL',
              hintText: 'Enter your email',
              icon: Icon(
                Icons.email_outlined,
                color: Colors.black,
              )),
        ),
        Spacer(
          flex: 1,
        ),
        TextFormField(
          style: TextStyle(color: Colors.black, fontSize: 17),
          decoration: buildInputDecoration(
              labelText: 'Username',
              hintText: 'Enter your username',
              icon: Icon(
                Icons.accessibility_new,
                color: Colors.black,
              )),
        ),
        Spacer(
          flex: 1,
        ),
        TextFormField(
          style: TextStyle(color: Colors.black, fontSize: 17),
          decoration: buildInputDecoration(
              labelText: 'PASSWORD',
              hintText: 'Enter your password',
              icon: Icon(
                Icons.lock_outline,
                color: Colors.black,
              )),
        ),
        Spacer(
          flex: 1,
        ),
        TextFormField(
          style: TextStyle(color: Colors.black, fontSize: 17),
          decoration: buildInputDecoration(
              labelText: '',
              hintText: 'Confirm your password',
              icon: Icon(
                Icons.confirmation_num_outlined,
                color: Colors.black,
              )),
        ),
        Spacer(
          flex: 1,
        ),
        InkWell(
          onTap: () {},
          child: Container(
            height: 50,
            width: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.orangeAccent),
            child: Center(
                child: Text(
              'Sign up',
              style: TextStyle(fontSize: 18, color: Colors.black),
            )),
          ),
        ),
        Spacer(
          flex: 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Already have an account? ',
              style: TextStyle(color: Colors.black),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: Center(
                    child: Text(
                  'Login',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                )),
              ),
            ),
          ],
        ),
        Spacer(
          flex: 1,
        ),
      ],
    );
  }

  InputDecoration buildInputDecoration(
      {required String labelText,
      required String hintText,
      required Icon icon}) {
    return InputDecoration(
      focusedBorder:
          UnderlineInputBorder(borderRadius: BorderRadius.circular(15)),
      enabledBorder:
          UnderlineInputBorder(borderRadius: BorderRadius.circular(15)),
      errorBorder:
          UnderlineInputBorder(borderRadius: BorderRadius.circular(15)),
      disabledBorder:
          UnderlineInputBorder(borderRadius: BorderRadius.circular(15)),
      suffixIcon: icon,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      labelText: labelText,
      hintText: hintText,
      contentPadding: EdgeInsets.only(left: 20, top: 10, bottom: 5),
      labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      hintStyle: TextStyle(
        color: Colors.black.withOpacity(0.45),
      ),
    );
  }
}
