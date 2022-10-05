import 'package:e_attendence_system/strings/strings.dart';
import 'package:e_attendence_system/styles/custom_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextWidgets {
  static Widget userTypeText() {
    return Padding(
      padding: EdgeInsets.only(left: 8.w, top: 8.h),
      child: Text(
        CustomStrings.askingUserTypeText,
        style: CustomStyle.normalTextStyle,
      ),
    );
  }

  static Widget defaultTextWidget(String text) {
    return Center(
      child: Text(
        text,
      ),
    );
  }
}
