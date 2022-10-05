import 'package:e_attendence_system/controller/data_controllers/fetch_data_controller.dart';
import 'package:e_attendence_system/controller/data_controllers/save_data_controller.dart';
import 'package:e_attendence_system/strings/strings.dart';
import 'package:e_attendence_system/widgets/app_bars/custom_app_bar.dart';
import 'package:e_attendence_system/widgets/list_view_widgets/teacher_info_card.dart';
import 'package:e_attendence_system/widgets/progress_dialog/progress_indicator.dart';
import 'package:e_attendence_system/widgets/text_widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AvailableTeachersScreen extends StatelessWidget {
  AvailableTeachersScreen({Key? key}) : super(key: key);

  List argumentsList = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //app bar
      appBar: const CustomAppBar(
          title: CustomStrings.availableTeachersCourseScreenAppBarText),

      //body
      body: FutureBuilder(
          future: FetchDataController.getFacultyMembersData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              //if we got an error
              if (snapshot.hasError) {
                //error text widget
                TextWidgets.defaultTextWidget("${snapshot.error} occured");
              }

              //if snapshot contains data
              else if (snapshot.hasData) {
                //listing all the available courses
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: FetchDataController.teachers.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        //checking if the list is clickable or not argumentsList[1] contains boolean value that tells either it is clickable or not (got from pervious screen)
                        if (argumentsList[1] == true) {
                          //assigning course to selected teacher
                          SaveDataController.assingCourseToTeacher(
                              context: context,
                              courseId: argumentsList[
                                  0], //argumentsList[0] contains course id which is tapped
                              facultyMemberFirebaseId:
                                  FetchDataController.facultyMembersIds[index]);
                        }
                      },
                      child: teacherInfoCard(
                          teacherName: FetchDataController.teachers[index].name,
                          teacherDesig:
                              FetchDataController.teachers[index].userType,
                          empId: FetchDataController.facultyMembersIds[index]),
                    );
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
