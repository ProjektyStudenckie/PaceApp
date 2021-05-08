import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pace_app/app/app.dart';
import 'package:pace_app/components/nav_drawer_widget.dart';
import 'package:pace_app/navigation_drawer/navigation_drawer.dart';
import 'package:pace_app/pages/home/home.dart';
import 'package:pace_app/pages/settings/view/settings_page.dart';

class DrawerContainer extends StatefulWidget {
  const DrawerContainer({Key? key}) : super(key: key);

  static Page page() => MaterialPage<void>(child: DrawerContainer());

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const DrawerContainer());
  }

  @override
  _DrawerContainerState createState() => _DrawerContainerState();
}

class _DrawerContainerState extends State<DrawerContainer> {
  late NavDrawerBloc _bloc;
  late Widget _content;

  @override
  void initState() {
    super.initState();
    _bloc = NavDrawerBloc();
    _content = _bodyForState(_bloc.state.selectedItem) ?? Container();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider<NavDrawerBloc>(
          create: (_) => NavDrawerBloc(),
          child: BlocConsumer<NavDrawerBloc, NavDrawerState>(
              listener: (BuildContext context, NavDrawerState state) {
            setState(() {
              _content = _bodyForState(state.selectedItem) ?? Container();
            });
          }, builder: (context, state) {
            return Scaffold(
                drawer: NavDrawerWidget(
                    BlocProvider.of<AppBloc>(context).state.user.email),
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
    case NavItem.settings:
      return SettingsPage();
    default:
      return null;
  }
}

// FloatingActionButton? _fabForState(NavItem state, BuildContext context) {
//   switch (state) {
//     case NavItem.home:
//       return HomePage().homeFAB(context);
//     default:
//       return null;
//   }
// }
