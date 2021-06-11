import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit({required String nickname, required bool darkTheme})
      : super(SettingsState(nickname: nickname, darkTheme: darkTheme));

  void changeNickname(String newValue) {
    emit(state.copyWith(nickname: newValue));
  }

  void changeThemeBrightness(bool value) {
    emit(state.copyWith(darkTheme: value));
  }
}
