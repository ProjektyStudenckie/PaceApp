import 'package:async/async.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pace_app/repository/game_repository.dart';
import 'package:pace_app/repository/quotes_repository.dart';

part 'game_cubit.freezed.dart';

class GameCubit extends Cubit<GameState> {
  final GameRepository _gameRepository;
  //late final AsyncMemoizer _asyncMemoizer;
  GameCubit(this._gameRepository) : super(GameState.init());

  void startOrFinishTheGame({required bool startTheGame}) {
    emit(state.copyWith(playGame: startTheGame));
  }

  String get getQuote => _gameRepository.quote();

  void setList(List<String> list) {
    List<String> quoteFragments = [];
    for (int i = 0; i < list.length; i++) {
      quoteFragments
          .add(list[i].toLowerCase().replaceAll(',', '').replaceAll('.', ''));
    }
    emit(state.copyWith(quote: quoteFragments));
  }

  void getText() {
    print(state.quote);
    print(state.textPartIndex);
    String text = state.quote[state.textPartIndex];
    print('texteeeee: $text');
    emit(state.copyWith(gameText: text));
    emit(state.copyWith(gameTextLength: text.length));
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
    //print('lettersCount: $_currentNrOfLetters');
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

  void setOldTextPart(TextSpan textSpan) {
    emit(state.copyWith(textSpan: textSpan));
  }

  TextSpan get getOldTextPart => state.textSpan;

  int textPartsCount() {
    print('text PArts count: ${state.quote.length}');
    return state.quote.length;
  }

  void stopTheGame() {
    _gameRepository.setStopGameValue(true);
  }

  void finishGame(bool b) {
    emit(state.copyWith(gameFinished: b));
  }

  void enableChangingWord(bool b) {
    emit(state.copyWith(enableCahngingWord: b));
  }

  double accuracy() {
    return _gameRepository.accuracy;
  }

  double wpm() {
    return _gameRepository.wpm;
  }

  int mistakes() {
    return _gameRepository.lastSavedMistakes;
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
    required TextSpan textSpan,
    required bool gameFinished,
    required List<String> quote,
    required bool enableCahngingWord,
    required int gameTextLength,
  }) = _GameState;

  const GameState._();

  factory GameState.init() => GameState(
        playGame: false,
        gameText: '',
        currentIndex: 0,
        enableCountingMistakes: false,
        textPartIndex: 0,
        textSpan: TextSpan(),
        gameFinished: false,
        quote: [],
        enableCahngingWord: true,
        gameTextLength: 0,
      );
}
