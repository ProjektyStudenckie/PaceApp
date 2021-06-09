import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pace_app/components/bottom_navbar_widget.dart';
import 'package:pace_app/pages/game_settings/game_settings.dart';
import 'package:pace_app/pages/home/home.dart';
import 'package:pace_app/pages/navbar_container/cubit/navbar_cubit.dart';
import 'package:pace_app/pages/settings/view/settings_page.dart';
import 'package:pace_app/pages/stats/page/stats_page.dart';

class NavBarContainer extends StatelessWidget {
  NavBarContainer({Key? key}) : super(key: key);

  static Page page() => MaterialPage<void>(child: NavBarContainer());

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => NavBarContainer());
  }

  final NavBarCubit _cubit = NavBarCubit();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<NavBarCubit, NavBarState>(
        bloc: _cubit,
        builder: (context, state) {
          return Scaffold(
            bottomNavigationBar: BottomNavbarWidget(_cubit),
            appBar: AppBar(
              title: Text(_titleForState(state.navItem) ?? "Pace App"),
              actions: [
                state.navItem == NavItem.home
                    ? GestureDetector(
                        child: Icon(Icons.menu),
                        onTap: () {
                          Navigator.push(context, GameSettingsPage.route());
                        },
                      )
                    : Text(''),
              ],
            ),
            body: AnimatedSwitcher(
              switchInCurve: Curves.easeInExpo,
              switchOutCurve: Curves.easeOutExpo,
              duration: Duration(milliseconds: 200),
              child: _bodyForState(state.navItem),
            ),
          );
        },
      ),
    );
  }
}

String? _titleForState(NavItem item) {
  switch (item) {
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

Widget? _bodyForState(NavItem item) {
  switch (item) {
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
