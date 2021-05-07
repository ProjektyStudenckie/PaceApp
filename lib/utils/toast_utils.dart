import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import "package:flutter/cupertino.dart";

void showSuccessToast(BuildContext context, String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.tealAccent[700],
      textColor: Colors.white,
      fontSize: 16.0);
}

void showErrorToast(BuildContext context, String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.redAccent,
      textColor: Colors.white,
      fontSize: 16.0);
}
