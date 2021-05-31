import 'package:flutter/material.dart';

// Colors for gradients on stats page
const kDarkRed = Color(0x44b15151);
const kDarkBlue = Color(0x4411a1c1);
const kDarkGreen = Color(0x4411c1a1);
const kDarkGrey = Color(0x44111111);
const kVeryDarkBlue = Color(0xFF111130);

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
