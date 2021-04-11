import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pace_app/cubit/current_user_cubit.dart';

import 'screens/login_screen.dart';
import 'screens/main_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Use ChangeNotifierProvider later
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CurrentUserCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          MainScreen.id: (context) => MainScreen(),
        },
      ),
    );
  }
}
