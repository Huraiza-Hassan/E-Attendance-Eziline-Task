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

class StudentHomeScreen extends StatelessWidget {
  const StudentHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //app bar
      appBar: const CustomAppBar(title: CustomStrings.studentScreenAppBarText),
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
          //enroll in course button
          MainMenuButton(
              buttonText: CustomStrings.enrollCourseButtonText,
              iconName: "enroll",
              onTap: () {
                //navigating to enroll in course screen
                Get.toNamed("/enrollInCourseScreen");
              }),
          //view available teachers button
          MainMenuButton(
              buttonText: CustomStrings.availableTeachersButtonText,
              iconName: "teachers",
              onTap: () {
                //navigating to view available teachers screen
                Get.toNamed("/availableTeachersScreen", arguments: ["", false]);
              }),
        ],
      ),
    ],
  );
}
