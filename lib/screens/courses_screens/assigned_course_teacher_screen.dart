import 'package:e_attendence_system/controller/data_controllers/fetch_data_controller.dart';
import 'package:e_attendence_system/strings/strings.dart';
import 'package:e_attendence_system/styles/custom_color.dart';
import 'package:e_attendence_system/styles/custom_style.dart';
import 'package:e_attendence_system/widgets/app_bars/custom_app_bar.dart';
import 'package:e_attendence_system/widgets/list_view_widgets/list_card.dart';
import 'package:e_attendence_system/widgets/list_view_widgets/teacher_info_card.dart';
import 'package:e_attendence_system/widgets/progress_dialog/progress_indicator.dart';
import 'package:e_attendence_system/widgets/text_widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AssignedCourseTeacherScreen extends StatelessWidget {
  AssignedCourseTeacherScreen({Key? key}) : super(key: key);

  //getting argumnent using getx
  String courseId = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //app bar
      appBar: const CustomAppBar(
          title: CustomStrings.viewTeaherInfoScreenAppBarText),

      //body
      body: FutureBuilder(
          future: FetchDataController.getAssignedTeacherId(courseId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              //if we got an error
              if (snapshot.hasError) {
                //error text widget
                TextWidgets.defaultTextWidget("${snapshot.error} occured");
              }

              //if snapshot contains data
              else if (snapshot.hasData) {
                //displaying assigned teacher info
                return teacherInfoCard(
                    teacherName: FetchDataController.teacherModel!.name,
                    teacherDesig: FetchDataController.teacherModel!.userType,
                    empId: courseId);
              }
            }
            //displaying progress indicator until data is fetched from firebase
            return showProgressIndicator();
          }),
    );
  }
}
