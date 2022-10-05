import 'package:e_attendence_system/controller/data_controllers/save_data_controller.dart';
import 'package:e_attendence_system/strings/strings.dart';
import 'package:e_attendence_system/styles/custom_color.dart';
import 'package:e_attendence_system/styles/custom_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_button/group_button.dart';

Widget studentAttendanceDetailsCard(
    {required String studentName,
    required String degreeName,
    required String attendanceStatus,
    required String attendanceDate}) {
  return Card(
    elevation: 8.0.h,
    margin: EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 6.0.h),
    child: Container(
      decoration: BoxDecoration(
          color: CustomColor.primaryColor,
          borderRadius: BorderRadius.circular(10.w)),
      child: Column(
        children: [
          Text(
            attendanceDate,
            style: CustomStyle.attendDateTextStyle,
          ),
          ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 10.0.h),
            leading: const Icon(
              Icons.person,
              color: Colors.orange,
            ),
            title: Text(
              studentName,
              style: CustomStyle.listTitleTextStyle,
            ),
            subtitle: Text(
              degreeName,
              style: CustomStyle.dateTextStyle,
            ),
            trailing: Text(
              attendanceStatus,
              style: CustomStyle.attendDateTextStyle,
            ),
          ),
        ],
      ),
    ),
  );
}
