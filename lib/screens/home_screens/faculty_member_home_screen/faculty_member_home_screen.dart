import 'package:e_attendence_system/constants/constants.dart';
import 'package:e_attendence_system/controller/authentication_controllers/authentication_controller.dart';
import 'package:e_attendence_system/strings/strings.dart';
import 'package:e_attendence_system/widgets/add_spaces/spaces.dart';
import 'package:e_attendence_system/widgets/app_bars/custom_app_bar.dart';
import 'package:e_attendence_system/widgets/buttons/main_menu_button.dart';
import 'package:e_attendence_system/widgets/drawers/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class FacMembHomeScreen extends StatelessWidget {
  const FacMembHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //app bar
      appBar: const CustomAppBar(title: CustomStrings.facMembScreenAppBarText),
      //drawer menu
      drawer: UserDrawer(
        userName: userModel!.name,
        userEmail: userModel!.userEmail,
        userDeignation: userModel!.userType,
        onTap: () async {
          //calling singout function
          await AuthenticationControllers.signOutFirebaseUser();
        },
      ),
      //body
      body: SingleChildScrollView(
        child: Column(
          children: [
            addVerticalSpace(5.h),
            //main menu buttons
            mainMenuButtons()
          ],
        ),
      ),
    );
  }
}

Widget mainMenuButtons() {
  //main menu buttons column
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //my courses button
          MainMenuButton(
              buttonText: CustomStrings.myCoursesButtonText,
              iconName: "information",
              onTap: () {
                //navigating to faculty member courses screen
                Get.toNamed("/facultyMemberCoursesScreen",
                    arguments:
                        false); //false means list tile will not be clickable in the next screen
              }),
          //mark attendance button
          MainMenuButton(
              buttonText: CustomStrings.markAttendanceButtonText,
              iconName: "attendance",
              onTap: () {
                //navigating to faculty member courses screen
                Get.toNamed("/facultyMemberCoursesScreen",
                    arguments:
                        true); //true means list tile will be clickable in the next screen
              }),
        ],
      ),
      addVerticalSpace(5.h),
      //view attendance button
      MainMenuButton(
          buttonText: CustomStrings.viewAttendanceButtonText,
          iconName: "viewAttendance",
          onTap: () {
            //navigating to faculty member courses screen
            Get.toNamed("/viewAttendanceScreen");
          }),
    ],
  );
}
