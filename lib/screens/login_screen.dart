import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/Button.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'dart:async';

class LoginScreen extends StatefulWidget {
  @override
  static String id = 'LoginScreen';
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'Logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                  style: TextStyle(color: Colors.black),
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kBoxDecoration),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                  obscureText: true,
                  style: TextStyle(color: Colors.black),
                  onChanged: (value) {
                    password = value;
                  },
                  decoration:
                      kBoxDecoration.copyWith(hintText: 'Enter your password')),
              SizedBox(
                height: 24.0,
              ),
              Button(
                  color: Colors.lightBlueAccent,
                  text: 'Log In',
                  onPressed: () {
                    try {
                      setState(() {
                        showSpinner = true;
                      });
                      final user = _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      Timer(Duration(seconds: 2), () {
                        print("Yeah, this line is printed after 3 seconds");
                        setState(() {
                          showSpinner = false;
                        });
                        if (user != null)
                          Navigator.pushNamed(context, ChatScreen.id);
                      });
                    } catch (e) {
                      print(e);
                    }
                    ;
                  })
            ],
          ),
        ),
      ),
    );
  }
}
