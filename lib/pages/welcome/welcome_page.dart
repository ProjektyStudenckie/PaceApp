import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pace_app/components/rounded_button.dart';
import 'package:pace_app/constants.dart';
import 'package:pace_app/pages/login/login.dart';
import 'package:pace_app/pages/registration/registration.dart';

class WelcomePage extends StatelessWidget {
  static Page page() => MaterialPage<void>(child: WelcomePage());

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
                  key: Key("Hero1"),
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                  ),
                ),
                AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'PaceApp',
                      textStyle: kTitleTextStyle,
                    ),
                    FlickerAnimatedText(
                      'write fast',
                      textStyle: kSubTitleTextStyle,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              key: ValueKey("log in"),
              color: Colors.lightBlueAccent,
              content: Text('LOG IN'),
              onPressed: () {
                Navigator.push(context, LoginPage.route());
              },
            ),
            RoundedButton(
              key: ValueKey("register"),
              color: Colors.blueAccent,
              content: Text('REGISTER'),
              onPressed: () {
                Navigator.push(context, RegistrationPage.route());
              },
            ),
          ],
        ),
      ),
    );
  }
}
