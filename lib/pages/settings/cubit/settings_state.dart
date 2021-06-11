part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState({required this.nickname, required this.darkTheme, required this.indicatorColor});

  final String nickname;
  final bool darkTheme;
  final Color indicatorColor;

  @override
  List<Object> get props => [nickname, darkTheme, indicatorColor];

  SettingsState copyWith({String? nickname, bool? darkTheme, Color? indicatorColor}) {
    return SettingsState(
        nickname: nickname ?? this.nickname,
        darkTheme: darkTheme ?? this.darkTheme,
        indicatorColor: indicatorColor ?? this.indicatorColor);
  }
}
