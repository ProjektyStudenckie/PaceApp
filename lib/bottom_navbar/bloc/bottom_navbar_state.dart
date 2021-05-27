class BottomNavbarState {
  final NavItem selectedItem;
  const BottomNavbarState(this.selectedItem);
}

enum NavItem {
  home,
  settings,
  stats,
}
