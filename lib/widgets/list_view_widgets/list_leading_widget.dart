import 'package:e_attendence_system/styles/custom_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget listLeadingCircle(String date) {
  return CircleAvatar(
    //course date container
    radius: 30.r,
    backgroundColor: Colors.orange,
    child: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            date.split('-').elementAt(2),
            style: CustomStyle.dateTextStyle,
          ),
          Text(
            date.split('-').elementAt(1),
            style: CustomStyle.dateTextStyle,
          ),
          Text(
            date.split('-').elementAt(0),
            style: CustomStyle.dateTextStyle,
          )
        ],
      ),
    ),
  ); //course date container
}
