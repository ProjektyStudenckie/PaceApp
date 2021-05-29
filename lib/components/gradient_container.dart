import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  const GradientContainer(
      {Key? key,
      required this.child,
      this.accentColor = const Color(0x4411a1c1),
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
              Color(0xFF111130),
              Color(0xFF111111),
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
                Color(0x44111111),
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
