import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_ui/bloc/login_bloc.dart';
import 'package:messenger_ui/bloc_event/login_event.dart';
import 'package:messenger_ui/bloc_state/login_state.dart';
import 'package:messenger_ui/screens/forgot_password/forgot_password_screen.dart';
import 'package:messenger_ui/screens/home/home_screen.dart';
import 'package:messenger_ui/screens/sign_up/sign_up_screen.dart';

import '../login_screen_model.dart';

class LoginScreenBody extends StatefulWidget {
  @override
  _LoginScreenBodyState createState() => _LoginScreenBodyState();
}

class _LoginScreenBodyState extends State<LoginScreenBody> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  late LoginBloc _loginBloc;

  @override
  void initState() {
    _loginBloc = BlocProvider.of<LoginBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _loginBloc,
      listener: (context, state) {
        if (state is LoginFailure) {
          handleValidateInfoLoginFailure(state);
        }
        if (state is LoginSuccess) {
          Navigator.popAndPushNamed(context, HomeScreen.routeName,
              arguments: {"user": state.user});
        }
      },
      child: Column(
        children: [
          const Spacer(
            flex: 7,
          ),
          const Flexible(
            child: Text(
              'Welcome back',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
            ),
            flex: 3,
          ),
          const Spacer(
            flex: 2,
          ),
          Row(
            children: [
              Spacer(),
              Flexible(
                flex: 6,
                child: TextFormField(
                  controller: _usernameController,
                  style: TextStyle(color: Colors.white, fontSize: 19),
                  decoration: buildInputDecoration(
                      hintText: 'Enter your username', labelText: 'Username'),
                ),
              ),
              Spacer(),
            ],
          ),
          const Spacer(
            flex: 1,
          ),
          Row(
            children: [
              Spacer(),
              Flexible(
                flex: 6,
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  style: TextStyle(color: Colors.white, fontSize: 19),
                  decoration: buildInputDecoration(
                      hintText: 'Enter your password', labelText: 'Password'),
                ),
              ),
              Spacer(),
            ],
          ),
          BlocBuilder(
            bloc: _loginBloc,
            builder: (context, state) {
              if (state is Loading) {
                return Flexible(
                  flex: 3,
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/loading.gif"),
                            fit: BoxFit.cover)),
                  ),
                );
              }
              return const Spacer(
                flex: 1,
              );
            },
          ),
          InkWell(
            onTap: () {
              _loginBloc.add(SubmitLogin(
                  username: _usernameController.text,
                  password: _passwordController.text));
            },
            child: Container(
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.red),
              child: Center(
                  child: Text(
                'Login',
                style: TextStyle(fontSize: 18, color: Colors.black),
              )),
            ),
          ),
          const Spacer(
            flex: 5,
          ),
          Row(
            children: [
              Spacer(
                flex: 1,
              ),
              Flexible(
                  flex: 2,
                  child: InkWell(onTap: () {
                    Navigator.of(context).pushNamed(ForgotPasswordScreen.routeName);
                  }, child: Text('Forgot password'))),
              Spacer(
                flex: 2,
              ),
              Flexible(
                  flex: 1,
                  child: InkWell(onTap: () {
                    Navigator.of(context).pushNamed(SignUpScreen.routeName);
                  }, child: Text('Sign up'))),
              Spacer(
                flex: 1,
              ),
            ],
          ),
          const Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }

  void handleValidateInfoLoginFailure(LoginFailure state) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Text('Login failure'),
              content: Container(
                height: 40,
                width: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:
                      state.errors.map((error) => Text('$error')).toList(),
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'))
              ],
            ));
  }
}
