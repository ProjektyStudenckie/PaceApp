import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pace_app/app/app.dart';
import 'dart:math';

class StatsPage extends StatelessWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Header(title: "Jakub Sosna"),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GradientContainer(
                    center: Alignment.bottomLeft,
                      accentColor: Color(0x44b15151),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DataField(label: "WPM", value: "129"),
                          Divider(color: Colors.white24, thickness: 2),
                          DataField(label: "Rank", value: "44"),
                        ],
                      )),
                  flex: 2,
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: GradientContainer(
                    center: Alignment.topCenter,
                      accentColor: Color(0x4411c1a1),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DataField(label: "ACCURACY", value: "100"),
                          Divider(
                            color: Colors.white24,
                            thickness: 2,
                          ),
                          DataField(label: "Rank", value: "1"),
                        ],
                      )),
                  flex: 3,
                )
              ],
            )
          ],
        ),
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
  const GradientContainer(
      {Key? key, required this.child, this.accentColor = const Color(0x4411a1c1), this.center = Alignment.topRight})
      : super(key: key);

  final Widget child;
  final Color accentColor;
  final AlignmentGeometry center;

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
              center: center,
              radius: 1.5,
              colors: [
                accentColor,
                Color(0x44111111),
              ],
            ),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
            child: child),
      ),
    );
  }
}

class DataField extends StatelessWidget {
  const DataField({Key? key, required this.label, required this.value})
      : super(key: key);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            value,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }
}
