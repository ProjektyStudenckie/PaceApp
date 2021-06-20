import 'package:injectable/injectable.dart';
import 'package:pace_app/extensions/stream_value.dart';
import 'package:pace_app/injection/injection.dart';
import 'package:pace_app/repository/stats_repository.dart';
import 'package:rxdart/rxdart.dart';

@lazySingleton
class GameRepository {
  String _tmpText =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
          .toLowerCase();
  String get gameText => _tmpText;

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

  void _callback() {
    print('Stream value changed');
  }

  void saveDataInFirebase() {
    getIt.get<StatsRepository>().addNewStat(time, mistakes, _tmpText.length);
    setMistakes(nrOfMistakes: 0);
  }
}
