import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pace_app/app/models/theme_settings.dart';
import 'package:pace_app/repository/authentication_repository.dart';
import 'package:pace_app/repository/models/models.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(
          authenticationRepository.currentUser.isNotAnonymous
              ? AppState.authenticated(authenticationRepository.currentUser)
              : const AppState.unauthenticated(),
        ) {
    _userSubscription = _authenticationRepository.user.listen(_onUserChanged);
    _loadTheme();
  }

  static const darkThemeKey = "dark_theme";
  static const indicatorColorKey = "indicator_color";

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<User> _userSubscription;

  final _theme = BehaviorSubject<ThemeSettings>();
  Function(ThemeSettings) get inTheme => _theme.sink.add;
  Stream<ThemeSettings> get outTheme => _theme.stream;

  void _onUserChanged(User user) => add(AppUserChanged(user));

  void saveThemeBrightness(bool darkTheme) async {
    final shared = await SharedPreferences.getInstance();

    shared.setBool(darkThemeKey, darkTheme);
  }

  void saveIndicatorColor(Color color) async {
    final shared = await SharedPreferences.getInstance();

    shared.setInt(indicatorColorKey, color.value);
  }

  void _loadTheme() async {
    final shared = await SharedPreferences.getInstance();

    final darkTheme = shared.getBool(darkThemeKey);
    final indicatorColorInt = shared.getInt(indicatorColorKey);

    var indicatorColor =
        indicatorColorInt != null ? Color(indicatorColorInt) : null;

    if (indicatorColor != null && darkTheme != null) {
      inTheme.call(ThemeSettings(
          indicatorColor: indicatorColor,
          themeBrightness: darkTheme ? Brightness.dark : Brightness.light));
      print("loaded");
    }
  }

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is AppUserChanged) {
      yield _mapUserChangedToState(event, state);
      return;
    }

    if (event is AppLogoutRequested) {
      _authenticationRepository.logOut();
      return;
    }

    if (event is AppUserDeleteRequested) {
      _authenticationRepository.deleteUser();
      return;
    }
  }

  AppState _mapUserChangedToState(AppUserChanged event, AppState state) {
    return event.user.isNotAnonymous
        ? AppState.authenticated(event.user)
        : const AppState.unauthenticated();
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    _theme.close();
    return super.close();
  }
}
