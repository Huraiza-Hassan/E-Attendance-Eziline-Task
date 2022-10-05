import 'package:e_attendence_system/styles/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastMessages {
  static void showToast(String msg) {
    Fluttertoast.showToast(msg: msg, backgroundColor: Colors.orange);
  }
}
