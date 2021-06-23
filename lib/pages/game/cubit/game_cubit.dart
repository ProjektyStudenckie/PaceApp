import 'package:async/async.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pace_app/repository/game_repository.dart';
import 'package:pace_app/repository/quotes_repository.dart';

part 'game_cubit.freezed.dart';

class GameCubit extends Cubit<GameState> {
  final GameRepository _gameRepository;
  late final AsyncMemoizer _asyncMemoizer;
  GameCubit(this._gameRepository) : super(GameState.init());

  void startOrFinishTheGame({required bool startTheGame}) {
    emit(state.copyWith(playGame: startTheGame));
  }

  //Future<String> get getQuote async => await _gameRepository.quote;

  void setList(List<String> list) {
    List<String> quoteFragments = [];
    for (int i = 0; i < list.length; i++) {
      quoteFragments
          .add(list[i].toLowerCase().replaceAll(',', '').replaceAll('.', ''));
    }
    emit(state.copyWith(quote: quoteFragments));
  }

  void isLoading(bool b) {
    emit(state.copyWith(isLoading: b));
  }

  getQuote() async {
    String quote = await _gameRepository.quote;
    List<String> list = quote.split(' ');
    setList(list);
    changeLetterCount();
    getText();
    startOrFinishTheGame(startTheGame: true);
    isLoading(false);
    _gameRepository.setStartTimerValue(true);
  }

  void getText() {
    String text = state.quote[state.textPartIndex];
    emit(state.copyWith(gameText: text));
    emit(state.copyWith(gameTextLength: text.length));
  }

  void addMistake() {
    int _currentNrOfMistakes = _gameRepository.mistakes + 1;
    _gameRepository.setMistakes(nrOfMistakes: _currentNrOfMistakes);
  }

  void changeLetterCount() {
    int _nrOfLetters = 0;

    state.quote.forEach((element) {
      _nrOfLetters += element.length;
    });
    print(_nrOfLetters);

    _gameRepository.setTextLength(nrOfLetters: _nrOfLetters);
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

  int get textPartsCount => state.quote.length;

  void stopTheGame() {
    _gameRepository.setStopGameValue(true);
  }

  void finishGame(bool b) {
    emit(state.copyWith(gameFinished: b));
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

  void isDarkMode({required bool isDarkMode}) {
    emit(state.copyWith(isDarkMode: isDarkMode));
  }
}

@freezed
class GameState with _$GameState {
  const factory GameState({
    required bool playGame,
    required String gameText,
    required int currentIndex,
    required int textPartIndex,
    required TextSpan textSpan,
    required bool gameFinished,
    required List<String> quote,
    required int gameTextLength,
    required bool isLoading,
    required bool isDarkMode,
  }) = _GameState;

  const GameState._();

  factory GameState.init() => GameState(
        playGame: false,
        gameText: '',
        currentIndex: 0,
        textPartIndex: 0,
        textSpan: TextSpan(),
        gameFinished: false,
        quote: [],
        gameTextLength: 0,
        isLoading: true,
        isDarkMode: false,
      );
}
