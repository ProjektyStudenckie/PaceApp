import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pace_app/bottom_navbar/bloc/bottom_navbar_bloc.dart';
import 'package:pace_app/bottom_navbar/bloc/bottom_navbar_state.dart';
import 'package:pace_app/components/bottom_navbar_widget.dart';
import 'package:pace_app/pages/home/home.dart';
import 'package:pace_app/pages/settings/view/settings_page.dart';
import 'package:pace_app/pages/stats/page/stats_page.dart';

class NavbarContainer extends StatefulWidget {
  const NavbarContainer({Key? key}) : super(key: key);

  static Page page() => MaterialPage<void>(child: NavbarContainer());

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const NavbarContainer());
  }

  @override
  _NavbarContainerState createState() => _NavbarContainerState();
}

class _NavbarContainerState extends State<NavbarContainer> {
  late BottomNavbarBloc _bloc;
  late Widget _content;

  @override
  void initState() {
    super.initState();
    _bloc = BottomNavbarBloc();
    _content = _bodyForState(_bloc.state.selectedItem) ?? Container();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider<BottomNavbarBloc>(
          create: (_) => BottomNavbarBloc(),
          child: BlocConsumer<BottomNavbarBloc, BottomNavbarState>(
              listener: (BuildContext context, BottomNavbarState state) {
            setState(() {
              _content = _bodyForState(state.selectedItem) ?? Container();
            });
          }, builder: (context, state) {
            return Scaffold(
                bottomNavigationBar: BottomNavbarWidget(),
                appBar: AppBar(
                  title: Text(_titleForState(state.selectedItem) ?? "Pace App"),
                ),
                //floatingActionButton: _fabForState(state.selectedItem, context),
                body: AnimatedSwitcher(
                    switchInCurve: Curves.easeInExpo,
                    switchOutCurve: Curves.easeOutExpo,
                    duration: Duration(milliseconds: 200),
                    child: _content));
          })),
    );
  }
}

String? _titleForState(NavItem state) {
  switch (state) {
    case NavItem.home:
      return "Home";
    case NavItem.stats:
      return "Stats";
    case NavItem.settings:
      return "Settings";
    default:
      return null;
  }
}

Widget? _bodyForState(NavItem state) {
  switch (state) {
    case NavItem.home:
      return HomePage();
    case NavItem.stats:
      return StatsPage();
    case NavItem.settings:
      return SettingsPage();
    default:
      return null;
  }
}
