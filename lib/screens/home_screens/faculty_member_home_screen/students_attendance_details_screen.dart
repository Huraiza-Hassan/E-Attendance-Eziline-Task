import 'package:e_attendence_system/constants/constants.dart';
import 'package:e_attendence_system/controller/data_controllers/fetch_data_controller.dart';
import 'package:e_attendence_system/strings/strings.dart';
import 'package:e_attendence_system/styles/custom_style.dart';
import 'package:e_attendence_system/widgets/app_bars/custom_app_bar.dart';
import 'package:e_attendence_system/widgets/list_view_widgets/student_attend_details_card.dart';
import 'package:e_attendence_system/widgets/list_view_widgets/student_attendance_card.dart';
import 'package:e_attendence_system/widgets/progress_dialog/progress_indicator.dart';
import 'package:e_attendence_system/widgets/text_widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentsAttendanceDetailsScreen extends StatelessWidget {
  StudentsAttendanceDetailsScreen({Key? key}) : super(key: key);

  List argumentsList = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //app bar
      appBar: const CustomAppBar(
          title: CustomStrings.studentsAttendanceDetailsScreenAppBarText),

      //body
      body: FutureBuilder(
          future: FetchDataController.getStudentsAttendances(
              teacherFirebaseId: userFirebaseId,
              teacherCourseId: argumentsList[0]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              //if we got an error
              if (snapshot.hasError) {
                //error text widget
                TextWidgets.defaultTextWidget("${snapshot.error} occured");
              }

              //if snapshot contains data
              else if (snapshot.hasData) {
                //listing all the students
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: FetchDataController.attendances.length,
                  itemBuilder: (BuildContext context, int index) {
                    return studentAttendanceDetailsCard(
                        attendanceDate: FetchDataController
                            .attendances[index].attendanceDate,
                        studentName:
                            FetchDataController.attendances[index].studentName,
                        degreeName: argumentsList[1],
                        attendanceStatus: FetchDataController
                            .attendances[index].attendanceStatus);
                  },
                );
              }
            }
            //displaying progress indicator until data is fetched from firebase
            return showProgressIndicator();
          }),
    );
  }
}
