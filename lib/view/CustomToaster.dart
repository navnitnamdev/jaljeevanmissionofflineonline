import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toaster {
  static void showToast({
    required String msg,
    required Color backgroundColor,
    required Color textColor,
  }) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: 16.0,
    );
  }
}

