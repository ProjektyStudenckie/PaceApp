import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit({required String nickname})
      : super(SettingsState(nickname: nickname));

  void changeNickname(String newValue) {
    emit(state.copyWith(nickname: newValue));
  }
}
