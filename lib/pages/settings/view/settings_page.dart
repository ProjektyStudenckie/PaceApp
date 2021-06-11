import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pace_app/app/app.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Settings!"),
          ElevatedButton(
              onPressed: () {
                BlocProvider.of<AppBloc>(context).add(AppUserDeleteRequested());
              },
              child: Text("Delete User"))
        ],
      ),
    );
  }
}
