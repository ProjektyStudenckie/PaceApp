import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pace_app/components/rounded_button.dart';
import 'package:pace_app/utils/login_validation_utils.dart';
import 'package:pace_app/utils/toast_utils.dart';
import '../constants.dart';
import 'main_screen.dart';

// TODO use Provider to authenticate user and switch to stateless widget
class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    String email;
    String password;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Flexible(
                    child: Hero(
                      tag: 'logo',
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
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: kTextFieldDecoration,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    obscureText: true,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter your password'),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  RoundedButton(
                    color: Colors.lightBlueAccent,
                    text: 'Log in',
                    onPressed: () async {
                      if (email == null || password == null) {
                        ToastUtils.showCustomToast(
                            context, "Fill all the fields!");
                        return;
                      }

                      if (!isEmailValid(email)) {
                        ToastUtils.showCustomToast(
                            context, "Email is invalid!");
                        return;
                      }

                      try {
                        final user = await _auth.signInWithEmailAndPassword(
                            email: email, password: password);

                        print(user);
                        if (user != null) {
                          Navigator.pushNamed(context, MainScreen.id);
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
