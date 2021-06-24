import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pace_app/components/bottom_navbar_widget.dart';
import 'package:pace_app/injection/injection.dart';
import 'package:pace_app/pages/game/game.dart';
import 'package:pace_app/pages/home/home.dart';
import 'package:pace_app/pages/navbar_container/cubit/navbar_cubit.dart';
import 'package:pace_app/pages/settings/view/settings_page.dart';
import 'package:pace_app/pages/stats/page/stats_page.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

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
  final NavBarCubit _cubit = NavBarCubit(getIt.get())..setup();
  late final StopWatchTimer _stopWatchTimer;

  @override
  void initState() {
    _stopWatchTimer = StopWatchTimer(
      mode: StopWatchMode.countUp,
      onChange: (value) => _cubit.setTime(value),
    );
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<NavBarCubit, NavBarState>(
        bloc: _cubit,
        builder: (context, state) {
          if (state.startTimer) {
            _stopWatchTimer.onExecute.add(StopWatchExecute.start);
            _cubit.stopTimer();
          }

          if (state.navItem != NavItem.game && state.saveStats == true) {
            _cubit.saveData(_stopWatchTimer.secondTime.value);
            _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
            _cubit.setBool(saveStats: false);
          }

          if (state.stopGame) {
            _cubit.saveData(_stopWatchTimer.secondTime.value);
            _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
            _cubit.setPlayGame(playGame: false);
            _cubit.stopTheGame(false);
          }

          return Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            bottomNavigationBar: BottomNavbarWidget(_cubit),
            appBar: AppBar(
              title: _titleForState(state.navItem, _stopWatchTimer),
              actions: [
                state.navItem == NavItem.game
                    ? GestureDetector(
                        child: Icon(
                          Icons.close,
                          color: Colors.redAccent,
                        ),
                        onTap: () {
                          _cubit.stopTheGame(true);
                          _cubit.selectNewNavBarItem(NavItem.home);
                        })
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

Widget _titleForState(NavItem item, StopWatchTimer timer) {
  switch (item) {
    case NavItem.home:
      return Text('Home');
    case NavItem.game:
      return _buildTimer(timer);
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

StreamBuilder _buildTimer(StopWatchTimer _stopWatchTimer) {
  return StreamBuilder<int>(
    stream: _stopWatchTimer.rawTime,
    initialData: _stopWatchTimer.secondTime.value,
    builder: (context, snap) {
      final value = snap.data!;
      final displayTime = StopWatchTimer.getDisplayTime(value,
          hours: false, milliSecond: false);
      return Text(displayTime);
    },
  );
}
