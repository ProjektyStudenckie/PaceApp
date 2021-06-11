import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pace_app/forms/forms.dart';
import 'package:pace_app/repository/game_repository.dart';

part 'navbar_cubit.freezed.dart';

class NavBarCubit extends Cubit<NavBarState> {
  NavBarCubit() : super(NavBarState.init());

  void selectNewNavBarItem(NavItem item) {
    emit(state.copyWith(navItem: item));
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
}
