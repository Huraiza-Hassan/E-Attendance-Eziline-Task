import 'package:e_attendence_system/styles/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Size get preferredSize => Size.fromHeight(55.0.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: CustomColor.primaryColor,
      title: Text(title),
      centerTitle: true,
      elevation: 5,
    );
  }
}
