import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pace_app/components/rounded_button.dart';
import 'package:pace_app/constants.dart';
import 'package:pace_app/sreens/login_screen.dart';
import 'package:pace_app/sreens/registration_screen.dart';

class WelcomeScreen extends StatelessWidget {
  static const String id = 'welcome_screen'; // using it to make nav easier

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(
                  width: 16.0,
                ),
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                  ),
                ),
                // TypewriterAnimatedTextKit(
                //   text: ['Flash Chat'],
                //   textStyle: TextStyle(
                //     fontSize: 45.0,
                //     fontWeight: FontWeight.w900,
                //   ),
                // ),
                Text(
                  'PaceApp',
                  style: kTitleTextStyle,
                )
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              color: Colors.lightBlueAccent,
              text: 'Log in',
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            RoundedButton(
              color: Colors.blueAccent,
              text: 'Register',
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
