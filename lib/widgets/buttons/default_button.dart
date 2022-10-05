import 'package:e_attendence_system/strings/strings.dart';
import 'package:e_attendence_system/styles/custom_color.dart';
import 'package:e_attendence_system/styles/custom_style.dart';
import 'package:e_attendence_system/styles/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({Key? key, required this.title, required this.onPresssed})
      : super(key: key);
  final String title;
  final VoidCallback onPresssed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0.h),
      child: Material(
        child: InkWell(
          onTap: onPresssed,
          child: Container(
            height: 40.h,
            width: 1.sw,
            decoration: BoxDecoration(
                color: CustomColor.primaryColor,
                borderRadius: BorderRadius.circular(Dimensions.radius)),
            child: Center(
                child: Text(
              title,
              style: CustomStyle.buttonTextStyle,
            )),
          ),
        ),
      ),
    );
  }
}
