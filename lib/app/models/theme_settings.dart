import 'package:flutter/material.dart';

class ThemeSettings {
  Brightness themeBrightness;
  Color indicatorColor;

  ThemeSettings(
      {this.themeBrightness = Brightness.dark,
      this.indicatorColor = Colors.yellow});
}
