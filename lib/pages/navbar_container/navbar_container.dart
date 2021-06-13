import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pace_app/components/bottom_navbar_widget.dart';
import 'package:pace_app/constants.dart';
import 'package:pace_app/injection/injection.dart';
import 'package:pace_app/pages/game/game.dart';
import 'package:pace_app/pages/home/home.dart';
import 'package:pace_app/pages/navbar_container/cubit/navbar_cubit.dart';
import 'package:pace_app/pages/settings/view/settings_page.dart';
import 'package:pace_app/pages/stats/page/stats_page.dart';

class NavBarContainer extends StatefulWidget {
  NavBarContainer({Key? key}) : super(key: key);

  static Page page() => MaterialPage<void>(child: NavBarContainer());

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => NavBarContainer());
  }

  @override
  _NavBarContainerState createState() => _NavBarContainerState();
}

class _NavBarContainerState extends State<NavBarContainer> {
  final NavBarCubit _cubit = NavBarCubit(getIt.get());

  @override
  void initState() {
    _cubit.setup();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<NavBarCubit, NavBarState>(
        bloc: _cubit,
        builder: (context, state) {
          if (state.navItem == NavItem.game) {
            _cubit.startTimer();
          }
          return Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            bottomNavigationBar: BottomNavbarWidget(_cubit),
            appBar: AppBar(
              title: _titleForState(state.navItem, state.time),
              actions: [
                state.navItem == NavItem.game
                    ? GestureDetector(
                        child: Icon(
                          Icons.close,
                          color: Colors.redAccent,
                        ),
                        onTap: () {
                          // send data - finish the game
                          _cubit.selectNewNavBarItem(NavItem.home);
                        },
                      )
                    : Text(''),
              ],
            ),
            body: AnimatedSwitcher(
              switchInCurve: Curves.easeInExpo,
              switchOutCurve: Curves.easeOutExpo,
              duration: Duration(milliseconds: 0),
              child: _bodyForState(state.navItem),
            ),
          );
        },
      ),
    );
  }
}

Widget? _titleForState(NavItem item, int time) {
  switch (item) {
    case NavItem.home:
      return Text('Home');
    case NavItem.game:
      return Text(_buildTimer(time));
    case NavItem.stats:
      return Text("Stats");
    case NavItem.settings:
      return Text("Settings");
    default:
      return Text('PaceApp');
  }
}

Widget? _bodyForState(NavItem item) {
  switch (item) {
    case NavItem.home:
      return HomePage();
    case NavItem.game:
      return GamePage();
    case NavItem.stats:
      return StatsPage();
    case NavItem.settings:
      return SettingsPage();
    default:
      return null;
  }
}

String _buildTimer(int seconds) {
  if (seconds < 10) {
    return '00:0$seconds';
  }

  if (seconds < 60) {
    return '00:$seconds';
  }

  if (seconds < 70) {
    return '01:0${seconds - 60}';
  }

  // max one minute for now
  return '01:${seconds - 60}';
}
