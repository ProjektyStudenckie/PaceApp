import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pace_app/app/models/theme_settings.dart';
import 'package:pace_app/injection/injection.dart';
import 'package:pace_app/pages/game/view/game_form.dart';
import 'package:pace_app/pages/home/cubit/home_cubit.dart';
import 'package:pace_app/pages/home/view/home_form.dart';

class GamePage extends StatelessWidget {
  const GamePage({Key? key}) : super(key: key);

  static Page page() => MaterialPage<void>(child: GamePage());

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const GamePage());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: BlocProvider(
        create: (_) => HomeCubit(getIt.get()),
        child: GameForm(),
      ),
    );
  }
}
