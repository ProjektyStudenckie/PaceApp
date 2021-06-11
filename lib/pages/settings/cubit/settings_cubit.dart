import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pace_app/app/models/theme_settings.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(
      {required String nickname, required ThemeSettings themeSettings})
      : super(SettingsState(
            nickname: nickname,
            darkTheme:
                themeSettings.themeBrightness == Brightness.dark ? true : false,
            indicatorColor: themeSettings.indicatorColor));

  void changeNickname(String newValue) {
    emit(state.copyWith(nickname: newValue));
  }

  void changeThemeBrightness(bool value) {
    emit(state.copyWith(darkTheme: value));
  }

  void changeIndicatorColor(Color color) {
    emit(state.copyWith(indicatorColor: color));
  }
}
