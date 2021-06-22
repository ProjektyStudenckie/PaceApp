import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pace_app/repository/game_repository.dart';

part 'navbar_cubit.freezed.dart';

class NavBarCubit extends Cubit<NavBarState> {
  final GameRepository _gameRepository;
  late StreamSubscription _playGameChange;
  late StreamSubscription _stopGameChange;

  NavBarCubit(this._gameRepository) : super(NavBarState.init());

  void setup() {
    _gameRepository.setPlayGameValue(false);
    _gameRepository.playGameValue.listen((data) {
      startTheGame(data);
    });
    _gameRepository.stopGameValue.listen((data) {
      stopTheGame(data);
    });
  }

  void stopTheGame(bool stopGame) {
    if (stopGame) {
      print('stop');
      emit(state.copyWith(stopGame: true));
    }

    if (!stopGame) {
      emit(state.copyWith(stopGame: false));
    }
  }

  void startTheGame(bool playGame) {
    if (playGame) {
      emit(state.copyWith(navItem: NavItem.game));
      emit(state.copyWith(playGame: true));
    }

    if (!playGame) {
      emit(state.copyWith(navItem: NavItem.home));
    }
  }

  void selectNewNavBarItem(NavItem item) {
    if (state.navItem == NavItem.game) {
      setBool(saveStats: true);
    }

    emit(state.copyWith(navItem: item));
  }

  void saveData(int time) {
    _gameRepository.setTimerValue(time: time);
    _gameRepository.saveDataInFirebase();
  }

  void setBool({required bool saveStats}) {
    emit(state.copyWith(saveStats: saveStats));
  }

  void setPlayGame({required bool playGame}) {
    emit(state.copyWith(playGame: playGame));
  }

  void setTime(int time) {
    emit(state.copyWith(time: time));
  }

  @override
  Future<void> close() {
    _playGameChange.cancel();
    _stopGameChange.cancel();
    return super.close();
  }
}

@freezed
class NavBarState with _$NavBarState {
  const factory NavBarState({
    required NavItem navItem,
    required bool saveStats,
    required int time,
    required bool stopGame,
    required bool playGame,
  }) = _NavbarState;

  const NavBarState._();

  factory NavBarState.init() => NavBarState(
        navItem: NavItem.home,
        saveStats: false,
        time: 0,
        stopGame: false,
        playGame: true,
      );
}

enum NavItem {
  home,
  settings,
  stats,
  game,
}
