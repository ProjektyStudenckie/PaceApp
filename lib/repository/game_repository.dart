import 'package:injectable/injectable.dart';
import 'package:pace_app/extensions/stream_value.dart';
import 'package:pace_app/injection/injection.dart';
import 'package:pace_app/repository/quotes_repository.dart';
import 'package:pace_app/repository/stats_repository.dart';

@lazySingleton
class GameRepository {
  late String _quote;
  // List<String> _textParts = [
  //   'lorem',
  //   'ipsum',
  //   'dolor',
  // ];
  // String gameText(int index) => _textParts[index];
  // int get textPartsCount => _textParts.length;
  Future<String> get quote async =>
      (await QuotesRepository.fetchRandomQuote()).content;

  StreamValue<bool> _playGame = StreamValue();
  Stream<bool> get playGameValue => _playGame.getStreamValue;

  void setPlayGameValue(bool b) {
    _playGame.setCallback(_callback);
    _playGame.setValue(b);
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

  int _lettersCount = 0;
  int get lettersCount => _lettersCount;
  void setLettersCount({required int nrOfLetters}) {
    _lettersCount = nrOfLetters;
  }

  void _callback() {
    print('Stream value changed');
  }

  void saveDataInFirebase() {
    getIt
        .get<StatsRepository>()
        .addNewStat(time, lettersCount - mistakes, mistakes, 100);
    wpm = getIt
        .get<StatsRepository>()
        .calculateNetWPM(lettersCount - mistakes, mistakes, time);
    lastSavedMistakes = mistakes;
    accuracy = getIt
        .get<StatsRepository>()
        .calculateAccuracy(lettersCount - mistakes, mistakes);

    setMistakes(nrOfMistakes: 0);
    setLettersCount(nrOfLetters: 0);
  }
}
