part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState({required this.nickname, required this.darkTheme});

  final String nickname;
  final bool darkTheme;

  @override
  List<Object> get props => [nickname, darkTheme];

  SettingsState copyWith({String? nickname, bool? darkTheme}) {
    return SettingsState(
        nickname: nickname ?? this.nickname,
        darkTheme: darkTheme ?? this.darkTheme);
  }
}
