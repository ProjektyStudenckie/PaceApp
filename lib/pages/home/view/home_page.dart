import 'package:flutter/material.dart';
import 'package:pace_app/app/app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pace_app/app/models/theme_settings.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Page page() => MaterialPage<void>(child: HomePage());

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<ThemeSettings>(
        stream: context.read<AppBloc>().outTheme,
        builder: (context, snapshot) {
          return Text("Home");
        }
      ),
    );
  }
}
