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
                    // przykladowy subtitle - mozna z tym pokombinowac
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
              color: Colors.lightBlueAccent,
              text: 'Log in',
              onPressed: () {
                Navigator.of(context).push<void>(LoginPage.route());
              },
            ),
            RoundedButton(
              color: Colors.blueAccent,
              text: 'Register',
              onPressed: () {
                Navigator.of(context).push<void>(RegistrationPage.route());
              },
            ),
          ],
        ),
      ),
    );
  }
}
