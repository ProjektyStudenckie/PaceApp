import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pace_app/repository/game_repository.dart';

part 'navbar_cubit.freezed.dart';

class NavBarCubit extends Cubit<NavBarState> {
  final GameRepository _gameRepository;
  late StreamSubscription _playGameChange;
  NavBarCubit(this._gameRepository) : super(NavBarState.init());

  void setup() {
    _gameRepository.setPlayGameValue(false);
    _gameRepository.playGameValue.listen((data) {
      startTheGame(data);
    });
  }

  void startTheGame(bool playGame) {
    if (playGame) {
      emit(state.copyWith(navItem: NavItem.game));
    }

    if (!playGame) {
      emit(state.copyWith(navItem: NavItem.home));
    }
  }

  void selectNewNavBarItem(NavItem item) {
    emit(state.copyWith(navItem: item));
  }

  void saveData(int time) {
    print('timeeeeeee $time');
    _gameRepository.setTimerValue(time);
  }

  @override
  Future<void> close() {
    _playGameChange.cancel();
    return super.close();
  }
}

@freezed
class NavBarState with _$NavBarState {
  const factory NavBarState({
    required NavItem navItem,
  }) = _NavbarState;

  const NavBarState._();

  factory NavBarState.init() => NavBarState(navItem: NavItem.home);
}

enum NavItem {
  home,
  settings,
  stats,
  game,
}

Stream<int> timer() {
  late StreamController<int> streamController;
  late Timer timer;
  Duration timerInterval = Duration(seconds: 1);
  int counter = 0;

  void stopTimer() {
    timer.cancel();
    counter = 0;
    streamController.close();
  }

  void tick(_) {
    counter++;
    streamController.add(counter);
  }

  void startTimer() {
    timer = Timer.periodic(timerInterval, tick);
  }

  streamController = StreamController<int>(
    onListen: startTimer,
    onCancel: stopTimer,
    onResume: startTimer,
    onPause: stopTimer,
  );

  return streamController.stream;
}

// Stream<int> stopWatchStream() {
//   StreamController<int> streamController;
//   Timer timer;
//   Duration timerInterval = Duration(seconds: 1);
//   int counter = 0;
//
//   void stopTimer() {
//     if (timer != null) {
//       timer.cancel();
//       timer = null;
//       counter = 0;
//       streamController.close();
//     }
//   }
//
//   void tick(_) {
//     counter++;
//     streamController.add(counter);
//     if (!flag) {
//       stopTimer();
//     }
//   }
//
//   void startTimer() {
//     timer = Timer.periodic(timerInterval, tick);
//   }
//
//   streamController = StreamController<int>(
//     onListen: startTimer,
//     onCancel: stopTimer,
//     onResume: startTimer,
//     onPause: stopTimer,
//   );
//
//   return streamController.stream;
// }
