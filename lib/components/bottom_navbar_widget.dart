import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pace_app/bottom_navbar/bloc/bottom_navbar_bloc.dart';
import 'package:pace_app/bottom_navbar/bloc/bottom_navbar_event.dart';
import 'package:pace_app/bottom_navbar/bloc/bottom_navbar_state.dart';

class BottomNavbarWidget extends StatefulWidget {
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
      currentIndex: _selectedIndex,
      onTap: (index) => _handleItemClick(context, index),
      items: _listItems,
      backgroundColor: Colors.black38,
    );
  }

  void _handleItemClick(BuildContext context, int index) {
    BlocProvider.of<BottomNavbarBloc>(context)
        .add(NavigateTo(_findItem(index)));
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
