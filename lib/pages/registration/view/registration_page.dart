import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pace_app/injection/injection.dart';

import '../registration.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({required Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
        builder: (_) => const RegistrationPage(
              key: Key(''),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocProvider<RegistrationCubit>(
          create: (_) => RegistrationCubit(getIt.get()),
          child: RegistrationForm(),
        ),
      ),
    );
  }
}
