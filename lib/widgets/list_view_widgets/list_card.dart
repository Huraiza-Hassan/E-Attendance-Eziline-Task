import 'package:e_attendence_system/styles/custom_color.dart';
import 'package:e_attendence_system/widgets/list_view_widgets/list_leading_widget.dart';
import 'package:e_attendence_system/widgets/list_view_widgets/list_subtitle_text.dart';
import 'package:e_attendence_system/widgets/list_view_widgets/list_title_text.dart';
import 'package:e_attendence_system/widgets/list_view_widgets/list_trailing_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget listCard(
    {required String leading,
    required String title,
    required String subtitle}) {
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
        leading: listLeadingCircle(leading),
        title: listTitleText(title),
        subtitle: listSubtitleText(subtitle),
        trailing: listTrailingIcon(),
      ),
    ),
  );
}
