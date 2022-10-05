import 'package:e_attendence_system/controller/data_controllers/fetch_data_controller.dart';
import 'package:e_attendence_system/strings/strings.dart';
import 'package:e_attendence_system/widgets/app_bars/custom_app_bar.dart';
import 'package:e_attendence_system/widgets/list_view_widgets/list_card.dart';
import 'package:e_attendence_system/widgets/progress_dialog/progress_indicator.dart';
import 'package:e_attendence_system/widgets/text_widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FacultyMemberCoursesScreen extends StatelessWidget {
  FacultyMemberCoursesScreen({Key? key}) : super(key: key);

  bool isClickAble = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //app bar
      appBar: const CustomAppBar(
          title: CustomStrings.facultyMemberCoursesScreenAppBarText),

      //body
      body: FutureBuilder(
          future: FetchDataController.getFacMemberCoursesData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              //if we got an error
              if (snapshot.hasError) {
                //error text widget
                TextWidgets.defaultTextWidget("${snapshot.error} occured");
              }

              //if snapshot contains data
              else if (snapshot.hasData) {
                //listing all the assigned courses
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: FetchDataController.facMemberCourses.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () async {
                        if (isClickAble == true) {
                          print(
                              "Course id: ${FetchDataController.facMemberCoursesIds[index]}");
                          Get.toNamed('/enrolledStudentsScreen',
                              arguments: FetchDataController
                                  .facMemberCoursesIds[index]);
                        }
                      },
                      child: listCard(
                          leading: FetchDataController
                              .facMemberCourses[index].courseStartingDate,
                          title: FetchDataController
                              .facMemberCourses[index].courseName,
                          subtitle: FetchDataController
                              .facMemberCourses[index].degreeName),
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
