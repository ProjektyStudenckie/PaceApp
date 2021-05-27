import 'bottom_navbar_state.dart';

abstract class BottomNavbarEvent {
  const BottomNavbarEvent();
}

class NavigateTo extends BottomNavbarEvent {
  final NavItem destination;
  const NavigateTo(this.destination);
}
