import 'dart:math';

import 'package:injectable/injectable.dart';
import 'package:pace_app/extensions/stream_value.dart';
import 'package:pace_app/injection/injection.dart';
import 'package:pace_app/repository/quotes_repository.dart';
import 'package:pace_app/repository/stats_repository.dart';

@lazySingleton
class GameRepository {
  Future<String> get quote async =>
      (await QuotesRepository.fetchRandomQuote()).content;

  StreamValue<bool> _playGame = StreamValue();
  Stream<bool> get playGameValue => _playGame.getStreamValue;

  void setPlayGameValue(bool b) {
    _playGame.setCallback(_callback);
    _playGame.setValue(b);
  }

  StreamValue<bool> _startTimer = StreamValue();
  Stream<bool> get startTimerValue => _startTimer.getStreamValue;

  void setStartTimerValue(bool b) {
    _startTimer.setCallback(_callback);
    _startTimer.setValue(b);
  }

  StreamValue<bool> _stopGame = StreamValue();
  Stream<bool> get stopGameValue => _stopGame.getStreamValue;

  void setStopGameValue(bool b) {
    _stopGame.setCallback(_callback);
    _stopGame.setValue(b);
  }

  int _timerValue = 0;
  int get time => _timerValue;
  void setTimerValue({required int time}) {
    _timerValue = time;
  }

  double wpm = 0;
  double accuracy = 0;
  int lastSavedMistakes = 0;

  int _mistakes = 0;
  int get mistakes => _mistakes;
  void setMistakes({required int nrOfMistakes}) {
    _mistakes = nrOfMistakes;
  }

  int _textLength = 0;
  int get textLength => _textLength;
  void setTextLength({required int nrOfLetters}) {
    _textLength = nrOfLetters;
  }

  void _callback() {
    print('Stream value changed');
  }

  void saveDataInFirebase() {
    wpm = getIt
        .get<StatsRepository>()
        .calculateNetWPM(_textLength, mistakes, time);
    lastSavedMistakes = mistakes;
    accuracy =
        getIt.get<StatsRepository>().calculateAccuracy(_textLength, mistakes);

    print('wpm: $wpm');

    getIt
        .get<StatsRepository>()
        .addNewStat(textLength: _textLength, mistakes: _mistakes, time: time);

    setMistakes(nrOfMistakes: 0);
    setTextLength(nrOfLetters: 0);
  }
}
