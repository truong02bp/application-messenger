import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:messenger_ui/bloc/sign_up_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_ui/bloc_event/sign_up_event.dart';
import 'package:messenger_ui/bloc_state/sign_up_state.dart';
import 'package:messenger_ui/screens/login/login_screen.dart';
import 'package:messenger_ui/ultils/ultil.dart';
class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  TextEditingController _username = new TextEditingController();
  TextEditingController _name = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  TextEditingController _confirmPassword = new TextEditingController();
  late SignUpBloc _signUpBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _signUpBloc = BlocProvider.of<SignUpBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _signUpBloc,
      listener: (context, state) {
        if (state is SignUpFailure) {
          showDialogErrors(context: context, errors: state.errors, title: 'Sign up failure');
        }
        if (state is AuthenticationOtp) {
          validateOtp(context: context, otp: "${state.otp}", email: "${state.userDto.email}", callBack: (validate) {
            _signUpBloc.add(new SignUpRequest(userDto: state.userDto));
          });
        }
        if (state is SignUpSuccess) {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                content: Container(
                  height: 40.0,
                  width: 300,
                  child:  Center(child: Text('Signup success', style: TextStyle(color: Colors.green),))),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).popAndPushNamed(LoginScreen.routeName);
                      },
                      child: Text('OK'))
                ],
              ));
        }
      },
      child: Column(
        children: [
          Spacer(
            flex: 1,
          ),
          TextFormField(
            controller: _name,
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
            controller: _email,
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
            controller: _username,
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
            controller: _password,
            style: TextStyle(color: Colors.black, fontSize: 17),
            obscureText: true,
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
            controller: _confirmPassword,
            style: TextStyle(color: Colors.black, fontSize: 17),
            obscureText: true,
            decoration: buildInputDecoration(
                labelText: '',
                hintText: 'Confirm your password',
                icon: Icon(
                  Icons.confirmation_num_outlined,
                  color: Colors.black,
                )),
          ),


          BlocBuilder(
            bloc: _signUpBloc,
            builder: (context, state) {
              if (state is Loading) {
                return Flexible(
                  flex: 2,
                  child: Container(
                    height: 75,
                    width: 75,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/loading.gif"),
                            fit: BoxFit.cover)),
                  ),
                );
              }
              return Spacer(
                flex: 2,
              );
            },
          ),
          InkWell(
            onTap: () {
              _signUpBloc.add(new SubmitFormEvent(username : _username.text, password : _password.text, email : _email.text, name: _name.text, confirmPassword: _confirmPassword.text));
            },
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
            flex: 1,
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
      ),
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
