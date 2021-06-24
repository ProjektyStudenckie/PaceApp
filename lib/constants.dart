import 'package:flutter/material.dart';

// Colors for gradients on stats page
const kDarkRed = Color(0x44b15151);
const kDarkBlue = Color(0x4411a1c1);
const kDarkGreen = Color(0x4411c1a1);
const kDarkGrey = Color(0x44111111);
const kVeryDarkBlue = Color(0xFF111130);
const kGrey = Color(0xFF333333);
const kDarkWhite = Color(0xFFEEEEEE);

const kTitleTextStyle = TextStyle(
  fontSize: 45.0,
  fontWeight: FontWeight.w900,
);

const kSubTitleTextStyle = TextStyle(
  fontSize: 38.0,
  fontWeight: FontWeight.w900,
);

const kTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

// RichText
const kTextStyleRed = TextStyle(
  color: Colors.redAccent,
  fontSize: 45.0,
  fontWeight: FontWeight.bold,
);

const kTextStyleWhite = TextStyle(
  color: Colors.white,
  fontSize: 45.0,
  fontWeight: FontWeight.bold,
);

const kTextStyleDark = TextStyle(
  color: Colors.black,
  fontSize: 45.0,
  fontWeight: FontWeight.bold,
);

var kTextStyleOldPartWhite = TextStyle(
  color: Colors.white.withOpacity(0.6),
  fontSize: 22.0,
  fontWeight: FontWeight.bold,
);

var kTextStyleOldPartDark = TextStyle(
  color: Colors.black54.withOpacity(0.6),
  fontSize: 22.0,
  fontWeight: FontWeight.bold,
);

var kTextStyleOldPartRed = TextStyle(
  color: Colors.redAccent.withOpacity(0.6),
  fontSize: 22.0,
  fontWeight: FontWeight.bold,
);

const kTextStyleCongrats = TextStyle(
  color: Colors.white,
  fontSize: 32.0,
  fontWeight: FontWeight.bold,
);

const kTextStyleCongratsDark = TextStyle(
  color: Colors.black54,
  fontSize: 32.0,
  fontWeight: FontWeight.bold,
);

const kTextStyleStats = TextStyle(
  color: Colors.white,
  fontSize: 25.0,
  fontWeight: FontWeight.bold,
);

const kTextStyleStatsDark = TextStyle(
  color: Colors.black54,
  fontSize: 25.0,
  fontWeight: FontWeight.bold,
);

const List<Color> gradientColorsRed = [
  const Color(0xffa35646),
  const Color(0xffe2938a),
];

const List<Color> gradientColorsPurple = [
  const Color(0xffd863ff),
  const Color(0xffc163ff),
];

const List<Color> gradientColorsGreen = [
  const Color(0xff23b6e6),
  const Color(0xff02d39a),
];
