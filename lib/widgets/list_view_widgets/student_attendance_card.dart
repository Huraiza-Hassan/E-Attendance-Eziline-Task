import 'package:e_attendence_system/controller/data_controllers/save_data_controller.dart';
import 'package:e_attendence_system/strings/strings.dart';
import 'package:e_attendence_system/styles/custom_color.dart';
import 'package:e_attendence_system/styles/custom_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_button/group_button.dart';

Widget studentAttendanceCard(
    {required String studentName,
    required String studentDesig,
    required String studentId}) {
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
          studentName,
          style: CustomStyle.listTitleTextStyle,
        ),
        subtitle: Text(
          studentDesig,
          style: CustomStyle.dateTextStyle,
        ),
        trailing: Column(
          children: [
            //present/absent button
            GroupButton(
              selectedButton: -1,
              direction: Axis.vertical,
              buttonHeight: 25.h,
              selectedColor: Colors.orange,
              borderRadius: BorderRadius.circular(5.w),
              spacing: 2.h,
              buttons: const [
                "Present",
                "Absent",
              ],
              onSelected: (groupbuttonIndex, isSelected) async {
                if (groupbuttonIndex == 0) {
                  //marking the specific student as present
                  SaveDataController.attendanceMap[studentName] = "Present";
                } else if (groupbuttonIndex == 1) {
                  //marking the specific student as absent
                  SaveDataController.attendanceMap[studentName] = "Absent";
                }
              },
            ),
          ],
        ),
      ),
    ),
  );
}
