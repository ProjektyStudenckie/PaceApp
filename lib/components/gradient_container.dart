import 'package:flutter/material.dart';
import 'package:pace_app/constants.dart';

class GradientContainer extends StatelessWidget {
  const GradientContainer(
      {Key? key,
      required this.child,
      this.accentColor = kDarkBlue,
      this.center = Alignment.topRight})
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
              kVeryDarkBlue,
              kDarkGrey,
            ],
          ),
          borderRadius: BorderRadius.circular(13)),
      child: Container(
        decoration: BoxDecoration(
            gradient: RadialGradient(
              center: center,
              radius: 1.5,
              colors: [
                accentColor,
                kDarkGrey,
              ],
            ),
            borderRadius: BorderRadius.circular(13)),
        child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
            child: child),
      ),
    );
  }
}
