import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:pace_app/app/bloc/app_bloc.dart';
import 'package:pace_app/app/models/theme_settings.dart';
import 'package:pace_app/app/routes/routes.dart';
import 'package:pace_app/constants.dart';
import 'package:pace_app/repository/authentication_repository.dart';

class App extends StatelessWidget {
  const App({
    required Key key,
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(key: key);

  final AuthenticationRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: BlocProvider(
        create: (_) => AppBloc(
          authenticationRepository: _authenticationRepository,
        ),
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ThemeSettings>(
        initialData: ThemeSettings(),
        stream: context.read<AppBloc>().outTheme,
        builder: (context, snapshot) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: snapshot.hasData
                ? _buildThemeSettings(snapshot.data!)
                : ThemeData.dark().copyWith(backgroundColor: kGrey),
            home: FlowBuilder<AppStatus>(
              state: context.select((AppBloc bloc) => bloc.state.status),
              onGeneratePages: onGenerateAppViewPages,
            ),
          );
        });
  }

  ThemeData _buildThemeSettings(ThemeSettings themeSettings) {
    return ThemeData(
      brightness: themeSettings.themeBrightness,
      backgroundColor: themeSettings.themeBrightness == Brightness.dark ? kGrey : kDarkWhite
    );
  }
}
