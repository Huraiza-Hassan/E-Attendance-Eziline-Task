import 'package:e_attendence_system/styles/custom_color.dart';
import 'package:e_attendence_system/styles/custom_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainMenuButton extends StatelessWidget {
  const MainMenuButton(
      {Key? key,
      required this.buttonText,
      required this.iconName,
      required this.onTap})
      : super(key: key);

  final String buttonText;
  final String iconName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        splashColor: CustomColor.primaryColor,
        onTap: onTap,
        child: Card(
          elevation: 5,
          child: SizedBox(
            height: 140.h,
            width: 140.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  "assets/images/button_icons/$iconName.png",
                  height: 80.h,
                ),
                Text(
                  buttonText,
                  textAlign: TextAlign.center,
                  style: CustomStyle.mainMenuButtonTextStyle,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
