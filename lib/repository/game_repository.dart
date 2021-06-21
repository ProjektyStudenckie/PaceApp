import 'package:injectable/injectable.dart';
import 'package:pace_app/extensions/stream_value.dart';
import 'package:pace_app/injection/injection.dart';
import 'package:pace_app/repository/stats_repository.dart';

@lazySingleton
class GameRepository {
  List<String> _textParts = [
    'lorem',
    'ipsum',
    'dolor',
  ];
  String gameText(int index) => _textParts[index];

  StreamValue<bool> _playGame = StreamValue();
  Stream<bool> get playGameValue => _playGame.getStreamValue;

  void setPlayGameValue(bool b) {
    _playGame.setCallback(_callback);
    _playGame.setValue(b);
  }

  int _timerValue = 0;
  int get time => _timerValue;
  void setTimerValue({required int time}) {
    _timerValue = time;
  }

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
    setMistakes(nrOfMistakes: 0);
    setLettersCount(nrOfLetters: 0);
  }
}
