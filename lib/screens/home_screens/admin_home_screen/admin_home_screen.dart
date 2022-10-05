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

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //app bar
      appBar: const CustomAppBar(title: CustomStrings.adminScreenAppBarText),
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
          //create course button
          MainMenuButton(
              buttonText: CustomStrings.createCourseButtonText,
              iconName: "courses",
              onTap: () {
                //navigating to create course screen
                Get.toNamed("/createCourseScreen");
              }),
          //view course info button
          MainMenuButton(
              buttonText: CustomStrings.viewCourseInfoButtonText,
              iconName: "information",
              onTap: () {
                //navigating to view course info screen
                Get.toNamed("/viewCourseInfoScreen");
              }),
        ],
      ),
      addVerticalSpace(5.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //assign course button
          MainMenuButton(
              buttonText: CustomStrings.assignCourseButtonText,
              iconName: "assign",
              onTap: () {
                //navigating to assign course screen
                Get.toNamed('/assignCourseScreen');
              }),
        ],
      )
    ],
  );
}
