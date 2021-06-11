import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:pace_app/repository/authentication_repository.dart';
import 'package:pace_app/repository/game_repository.dart';

import 'injection.config.dart';

final getIt = GetIt.instance;

@injectableInit
void configureDependencies() => $initGetIt(getIt);

Future<void> setupGetIt() async {
  if (GetIt.I.isRegistered<AuthenticationRepository>() &&
      GetIt.I.isRegistered<GameRepository>()) {
    await getIt.reset();
  }

  if (!GetIt.I.isRegistered<AuthenticationRepository>()) {
    getIt.registerSingleton<AuthenticationRepository>(
        AuthenticationRepository());
  }

  if (!GetIt.I.isRegistered<GameRepository>()) {
    getIt.registerSingleton<GameRepository>(GameRepository());
  }
}
