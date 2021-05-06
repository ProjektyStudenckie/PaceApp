import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pace_app/repository/authentication_repository.dart';
// ignore: implementation_imports
//import 'package:authentication_repository/src/injection/injection.dart';

import 'app/bloc_observer.dart';
import 'app/view/app.dart';
//import 'package:authentication_repository/injection/injection.dart';

import 'injection/injection.dart';

void main() async {
  configureDependencies();
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await setupGetIt();
  await Firebase.initializeApp();
  // final authenticationRepository = AuthenticationRepository();
  // await authenticationRepository.user.first;
  // TODO check if this key is correct as empty
  runApp(App(
    authenticationRepository: getIt<AuthenticationRepository>(),
    key: Key(''),
  ));
}
