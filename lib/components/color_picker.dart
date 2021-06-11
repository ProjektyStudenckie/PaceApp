import 'package:flutter/material.dart';

class ColorPicker extends StatelessWidget {
  ColorPicker({required this.onColorTap});

  final Function(Color) onColorTap;

  final List<Color> colors = [
    Colors.blue,
    Colors.blueAccent,
    Colors.red,
    Colors.redAccent,
    Colors.green,
    Colors.greenAccent,
    Colors.yellow,
    Colors.orange,
    Colors.brown,
    Colors.blueGrey
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(children: [
      for (int i = 0; i < colors.length; i++) ...[
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: GestureDetector(
            onTap: () {
              onColorTap.call(colors[i]);
            },
            child: CircleAvatar(
              backgroundColor: colors[i],
            ),
          ),
        )
      ]
    ]);
  }
}
