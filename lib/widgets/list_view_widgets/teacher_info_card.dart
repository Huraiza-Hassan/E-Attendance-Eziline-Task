import 'package:e_attendence_system/strings/strings.dart';
import 'package:e_attendence_system/styles/custom_color.dart';
import 'package:e_attendence_system/styles/custom_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget teacherInfoCard(
    {required String teacherName,
    required String teacherDesig,
    required String empId}) {
  return Card(
    elevation: 8.0.h,
    margin: EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 6.0.h),
    child: Container(
      decoration: BoxDecoration(
          color: CustomColor.primaryColor,
          borderRadius: BorderRadius.circular(10.w)),
      child: ListTile(
        contentPadding:
            EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 10.0.h),
        leading: const Icon(
          Icons.person,
          color: Colors.orange,
        ),
        title: Text(
          teacherName,
          style: CustomStyle.listTitleTextStyle,
        ),
        subtitle: Text(
          teacherDesig,
          style: CustomStyle.dateTextStyle,
        ),
        trailing: Column(
          children: [
            Text(
              CustomStrings.empIdText,
              style: CustomStyle.empIdTextStyle,
            ),
            Text(
              //displaying text in two lines
              "${empId.substring(0, 14)}\n${empId.substring(14, empId.length)}",
              style: CustomStyle.dateTextStyle,
            ),
          ],
        ),
      ),
    ),
  );
}
