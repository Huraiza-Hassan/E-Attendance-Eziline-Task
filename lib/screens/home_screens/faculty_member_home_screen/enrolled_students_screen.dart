import 'package:e_attendence_system/constants/constants.dart';
import 'package:e_attendence_system/controller/data_controllers/fetch_data_controller.dart';
import 'package:e_attendence_system/controller/data_controllers/save_data_controller.dart';
import 'package:e_attendence_system/helper_methods/helper_methods.dart';
import 'package:e_attendence_system/strings/strings.dart';
import 'package:e_attendence_system/styles/custom_color.dart';
import 'package:e_attendence_system/widgets/app_bars/custom_app_bar.dart';
import 'package:e_attendence_system/widgets/buttons/default_button.dart';
import 'package:e_attendence_system/widgets/input_fields/date_input_text_field.dart';
import 'package:e_attendence_system/widgets/list_view_widgets/student_attendance_card.dart';
import 'package:e_attendence_system/widgets/list_view_widgets/teacher_info_card.dart';
import 'package:e_attendence_system/widgets/progress_dialog/progress_indicator.dart';
import 'package:e_attendence_system/widgets/text_widgets/text_widgets.dart';
import 'package:e_attendence_system/widgets/toasts/toast_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/app_controllers/date_controller.dart';

class EnrolledStudentsScreen extends StatelessWidget {
  EnrolledStudentsScreen({Key? key}) : super(key: key);
  String courseId = Get.arguments;

  @override
  Widget build(BuildContext context) {
    //creating date controller from getx
    DateController dateController = Get.put(DateController());
    //creating form key for validation purpose
    final formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Scaffold(
        //app bar
        appBar: const CustomAppBar(
            title: CustomStrings.enrolledStudentsScreenAppBarText),

        //body
        body: Column(
          children: [
            //getting date
            Padding(
              padding: EdgeInsets.all(8.0.h),
              child: const DateInputTextField(
                  hintText: "Select Attendance Date",
                  prefixIconName: Icon(
                    Icons.date_range,
                    color: CustomColor.primaryColor,
                  )),
            ),

            //displaying enrolled students
            FutureBuilder(
                future: FetchDataController.getEnrolledStudentsData(courseId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    //if we got an error
                    if (snapshot.hasError) {
                      //error text widget
                      TextWidgets.defaultTextWidget(
                          "${snapshot.error} occured");
                    }

                    //if snapshot contains data
                    else if (snapshot.hasData) {
                      //listing all the available courses
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: FetchDataController.enrolledStudents.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              print(
                                  "Enrolled student id: ${FetchDataController.enrolledStudentsIds[index]}");
                            },
                            //displaying enrolled student card
                            child: studentAttendanceCard(
                                studentName: FetchDataController
                                    .enrolledStudents[index].name,
                                studentDesig: FetchDataController
                                    .enrolledStudents[index].userType,
                                studentId: FetchDataController
                                    .enrolledStudentsIds[index]),
                          );
                        },
                      );
                    }
                  }
                  //displaying progress indicator until data is fetched from firebase
                  return showProgressIndicator();
                }),

            //submit attendance button
            DefaultButton(
                title: CustomStrings.submitAttendanceButtonText,
                onPresssed: () async {
                  //checking if the date field is containing date
                  if (!formKey.currentState!.validate()) {
                    return;
                  }
                  //it means date field is containing date
                  else {
                    //calling mark attendance method
                    HelperMethods.markAttendanceOfStudents(
                        context: context,
                        userFirebaseId: userFirebaseId,
                        courseId: courseId,
                        attendanceDate:
                            dateController.courseDateController.value.text);
                  }
                })
          ],
        ),
      ),
    );
  }
}
