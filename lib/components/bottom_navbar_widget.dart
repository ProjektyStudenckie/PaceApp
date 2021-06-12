import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pace_app/constants.dart';
import 'package:pace_app/pages/navbar_container/cubit/navbar_cubit.dart';

class BottomNavbarWidget extends StatefulWidget {
  final NavBarCubit _cubit;
  BottomNavbarWidget(this._cubit);

  @override
  _BottomNavbarWidgetState createState() => _BottomNavbarWidgetState();
}

class _BottomNavbarWidgetState extends State<BottomNavbarWidget> {
  int _selectedIndex = 0;

  final List<BottomNavigationBarItem> _listItems = [
    BottomNavigationBarItem(
        label: 'Play', icon: Icon(Icons.videogame_asset_outlined)),
    BottomNavigationBarItem(label: 'Stats', icon: Icon(Icons.show_chart)),
    BottomNavigationBarItem(label: 'Settings', icon: Icon(Icons.settings)),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor:
          Theme.of(context).brightness == Brightness.dark ? kDarkGrey : null,
      currentIndex: _selectedIndex,
      onTap: (index) => _handleItemClick(context, index),
      items: _listItems,
    );
  }

  void _handleItemClick(BuildContext context, int index) {
    widget._cubit.selectNewNavBarItem(_findItem(index));
    setState(() => _selectedIndex = index);
  }

  NavItem _findItem(int index) {
    switch (index) {
      case 0:
        return NavItem.home;
      case 1:
        return NavItem.stats;
      case 2:
        return NavItem.settings;
      default:
        return NavItem.home;
    }
  }
}
