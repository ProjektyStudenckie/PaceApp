import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pace_app/repository/game_repository.dart';

part 'game_cubit.freezed.dart';

class GameCubit extends Cubit<GameState> {
  final GameRepository _gameRepository;
  GameCubit(this._gameRepository) : super(GameState.init());

  void setup() {
    emit(state.copyWith(gameText: getText));
  }

  void startOrFinishTheGame({required bool startTheGame}) {
    emit(state.copyWith(playGame: startTheGame));
  }

  String get getText => _gameRepository.gameText;

  void setCurrentIndex(int index) {
    emit(state.copyWith(currentIndex: index));
  }
}

@freezed
class GameState with _$GameState {
  const factory GameState({
    required bool playGame,
    required String gameText,
    required int currentIndex,
  }) = _GameState;

  const GameState._();

  factory GameState.init() =>
      GameState(playGame: false, gameText: '', currentIndex: 0);
}
