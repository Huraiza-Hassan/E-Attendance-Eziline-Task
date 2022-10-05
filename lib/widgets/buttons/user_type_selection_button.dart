import 'package:e_attendence_system/constants/constants.dart';
import 'package:e_attendence_system/styles/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_button/group_button.dart';

Widget userTypeButton() {
  return GroupButton(
    selectedButton: -1,
    direction: Axis.vertical,
    buttonHeight: 25.h,
    selectedColor: CustomColor.primaryColor,
    borderRadius: BorderRadius.circular(5.w),
    spacing: 4.h,
    buttons: const [
      "Admin",
      "   Student   ",
      "Faculty Member",
      "Head of Department",
      "Controller Examination",
    ],
    onSelected: (groupbuttonIndex, isSelected) async {
      if (groupbuttonIndex == 0) {
        selectedUserType = "Admin";
      } else if (groupbuttonIndex == 1) {
        selectedUserType = "Student";
      } else if (groupbuttonIndex == 2) {
        selectedUserType = "Faculty Member";
      } else if (groupbuttonIndex == 3) {
        selectedUserType = "Head of Department";
      } else if (groupbuttonIndex == 4) {
        selectedUserType = "Controller Examination";
      }
    },
  );
}
