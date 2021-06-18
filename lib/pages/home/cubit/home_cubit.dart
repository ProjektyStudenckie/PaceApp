import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pace_app/repository/game_repository.dart';

part 'home_cubit.freezed.dart';

class HomeCubit extends Cubit<HomeState> {
  final GameRepository _gameRepository;
  HomeCubit(this._gameRepository) : super(HomeState.init());

  void startTheGame() {
    _gameRepository.setPlayGameValue(true);
  }
}

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    required bool playGame,
    required String gameText,
    required int currentIndex,
  }) = _HomeState;

  const HomeState._();

  factory HomeState.init() =>
      HomeState(playGame: false, gameText: '', currentIndex: 0);
}
