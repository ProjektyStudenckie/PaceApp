import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pace_app/app/app.dart';
import 'dart:math';

class StatsPage extends StatelessWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Header(title: "Jakub"),
          )
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
        child: Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Theme.of(context).accentColor,
          child: Icon(
            Icons.person,
            size: 40,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                softWrap: true,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 34),
              )),
        )
      ],
    ));
  }
}

class GradientContainer extends StatelessWidget {
  const GradientContainer({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: RadialGradient(
            radius: 3.5,
            colors: [
              Color(0xFF111130),
              Color(0xFF111111),
            ],
          ),
          borderRadius: BorderRadius.circular(10)),
      child: Container(
        decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.topRight,
              radius: 1.5,
              colors: [
                Color(0x4411c1a1),
                Color(0x44111111),
              ],
            ),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
            child: child),
      ),
    );
  }
}
