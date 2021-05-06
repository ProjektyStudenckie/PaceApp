
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pace_app/injection/injection.dart';

import '../login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({required Key key}) : super(key: key);

  static Page page() => MaterialPage<void>(
          child: LoginPage(
        key: Key(''),
      ));

  static Route route() {
    return MaterialPageRoute<void>(
        builder: (_) => const LoginPage(
              key: Key(''),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        //child: LoginForm(),
        child: BlocProvider(
          create: (_) => LoginCubit(getIt.get()),
          child: LoginForm(),
        ),
      ),
    );
  }
}
