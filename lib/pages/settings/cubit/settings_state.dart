part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState({required this.nickname});

  final String nickname;

  @override
  List<Object> get props => [nickname];

  SettingsState copyWith({String? nickname}) {
    return SettingsState(nickname: nickname ?? this.nickname);
  }
}
