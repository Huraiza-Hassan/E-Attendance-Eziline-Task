import 'package:e_attendence_system/constants/constants.dart';
import 'package:e_attendence_system/controller/data_controllers/fetch_data_controller.dart';
import 'package:e_attendence_system/controller/data_controllers/save_data_controller.dart';
import 'package:e_attendence_system/strings/strings.dart';
import 'package:e_attendence_system/widgets/app_bars/custom_app_bar.dart';
import 'package:e_attendence_system/widgets/list_view_widgets/list_card.dart';
import 'package:e_attendence_system/widgets/progress_dialog/progress_indicator.dart';
import 'package:e_attendence_system/widgets/text_widgets/text_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnrollInCourseScreen extends StatelessWidget {
  const EnrollInCourseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //app bar
      appBar:
          const CustomAppBar(title: CustomStrings.enrollCourseScreenAppBarText),

      //body
      body: FutureBuilder(
          future: FetchDataController.getCoursesData(),
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
                  itemCount: FetchDataController.courses.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () async {
                        //enrolling a student in a course
                        await SaveDataController.enrollStudentInCourse(
                            context: context,
                            courseId: FetchDataController.coursesIds[index],
                            studentFirebaseId: userFirebaseId);
                      },
                      child: listCard(
                          leading: FetchDataController
                              .courses[index].courseStartingDate,
                          title: FetchDataController.courses[index].courseName,
                          subtitle:
                              FetchDataController.courses[index].degreeName),
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
