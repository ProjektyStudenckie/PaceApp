import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pace_app/injection/injection.dart';
import 'package:pace_app/pages/home/cubit/home_cubit.dart';

class HomeForm extends StatefulWidget {
  @override
  _HomeFormState createState() => _HomeFormState();
}

class _HomeFormState extends State<HomeForm> {
  final HomeCubit _cubit = HomeCubit(getIt.get());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.hovered)) {
                  return Theme.of(context).colorScheme.primary.withOpacity(0.7);
                }

                if (states.contains(MaterialState.focused)) {
                  return Theme.of(context).colorScheme.primary.withOpacity(0.7);
                }

                if (states.contains(MaterialState.pressed)) {
                  return Theme.of(context)
                      .colorScheme
                      .primary
                      .withOpacity(0.85);
                }

                return Theme.of(context).colorScheme.primary.withOpacity(0.2);
              },
            ),
            minimumSize: MaterialStateProperty.resolveWith<Size>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered)) {
                return Size(140.0, 50.0);
              }

              if (states.contains(MaterialState.focused)) {
                return Size(140.0, 50.0);
              }

              if (states.contains(MaterialState.pressed)) {
                return Size(160.0, 60.0);
              }

              return Size(130.0, 42.0);
            }),
          ),
          onPressed: () {
            _cubit.startTheGame();
          },
          child: Text(
            'Play',
            style: TextStyle(
              fontSize: 30.0,
            ),
          ),
        ),
      ),
    );
  }
}
