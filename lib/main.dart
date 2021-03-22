import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pace_app/sreens/login_screen.dart';
import 'package:pace_app/sreens/main_screen.dart';
import 'package:pace_app/sreens/registration_screen.dart';
import 'package:pace_app/sreens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Use ChangeNotifierProvider later
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        MainScreen.id: (context) => MainScreen(),
      },
    );
  }
}
