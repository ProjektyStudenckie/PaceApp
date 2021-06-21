import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pace_app/repository/game_repository.dart';

part 'game_cubit.freezed.dart';

class GameCubit extends Cubit<GameState> {
  final GameRepository _gameRepository;
  GameCubit(this._gameRepository) : super(GameState.init());

  void setup() {
    getText();
  }

  void startOrFinishTheGame({required bool startTheGame}) {
    emit(state.copyWith(playGame: startTheGame));
  }

  void getText() {
    String text = _gameRepository.gameText(state.textPartIndex);
    emit(state.copyWith(gameText: text));
  }

  void addMistake() {
    if (!state.enableCountingMistakes) {
      return;
    }

    int _currentNrOfMistakes = _gameRepository.mistakes + 1;
    print('mistakes: $_currentNrOfMistakes');
    _gameRepository.setMistakes(nrOfMistakes: _currentNrOfMistakes);
    enableCountingMistakes(false);
  }

  void addLetter() {
    int _currentNrOfLetters = _gameRepository.lettersCount + 1;
    print('lettersCount: $_currentNrOfLetters');
    _gameRepository.setLettersCount(nrOfLetters: _currentNrOfLetters);
  }

  void enableCountingMistakes(bool b) {
    emit(state.copyWith(enableCountingMistakes: b));
  }

  void setIndex(int i) {
    emit(state.copyWith(currentIndex: i));
  }

  void setTextPartIndex(int i) {
    emit(state.copyWith(textPartIndex: i));
  }
}

@freezed
class GameState with _$GameState {
  const factory GameState({
    required bool playGame,
    required String gameText,
    required int currentIndex,
    required bool enableCountingMistakes,
    required int textPartIndex,
  }) = _GameState;

  const GameState._();

  factory GameState.init() => GameState(
        playGame: false,
        gameText: '',
        currentIndex: 0,
        enableCountingMistakes: false,
        textPartIndex: 0,
      );
}
