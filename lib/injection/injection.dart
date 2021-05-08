import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:pace_app/repository/authentication_repository.dart';

import 'injection.config.dart';

final getIt = GetIt.instance;

@injectableInit
void configureDependencies() => $initGetIt(getIt);

Future<void> setupGetIt() async {
  if (GetIt.I.isRegistered<AuthenticationRepository>()) {
    await getIt.reset();
  }

  if (!GetIt.I.isRegistered<AuthenticationRepository>()) {
    getIt.registerSingleton<AuthenticationRepository>(
        AuthenticationRepository());
  }
}
