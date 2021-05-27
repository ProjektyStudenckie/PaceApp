import 'package:bloc/bloc.dart';

import 'bottom_navbar_event.dart';
import 'bottom_navbar_state.dart';

class BottomNavbarBloc extends Bloc<BottomNavbarEvent, BottomNavbarState> {
  BottomNavbarBloc() : super(BottomNavbarState(NavItem.home));

  @override
  Stream<BottomNavbarState> mapEventToState(BottomNavbarEvent event) async* {
    if (event is NavigateTo) {
      if (event.destination != state.selectedItem) {
        yield BottomNavbarState(event.destination);
      }
    }
  }
}
