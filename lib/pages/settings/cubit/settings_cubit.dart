import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pace_app/app/models/theme_settings.dart';
import 'package:pace_app/repository/stats_repository.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  StatsRepository statsRepository;

  SettingsCubit(
      {required this.statsRepository,
      required String nickname,
      required ThemeSettings themeSettings})
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

  void removeUserStats() {
    statsRepository.removeUserStats();
  }
}
