import 'package:e_attendence_system/controller/data_controllers/fetch_data_controller.dart';
import 'package:e_attendence_system/controller/data_controllers/save_data_controller.dart';
import 'package:e_attendence_system/models/course_model.dart';
import 'package:e_attendence_system/strings/strings.dart';
import 'package:e_attendence_system/widgets/progress_dialog/progress_dialog.dart';
import 'package:e_attendence_system/widgets/toasts/toast_messages.dart';
import 'package:flutter/material.dart';

class HelperMethods {
  //create course button method
  static void createCourse(
      {required BuildContext context,
      required String degreeName,
      required String courseName,
      required String courseCode,
      required String courseStartingDate}) async {
    //filling course model with course attributes
    CourseModel courseModel = CourseModel(
        degreeName: degreeName,
        courseName: courseName,
        courseCode: courseCode,
        courseStartingDate: courseStartingDate);

    //showing progress indicator
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => WillPopScope(
            onWillPop: () => Future.value(false),
            child: const ProgressDialog(msg: CustomStrings.waitText)));

    //calling save data method from controller
    await SaveDataController.saveCourseDataOnFirebase(courseModel.toMap());

    //popping progress indicator
    Navigator.pop(context);

    //displaying success message
    ToastMessages.showToast(CustomStrings.courseCreatedMsg);
  }

  //mark attendance button method
  static void markAttendanceOfStudents(
      {required BuildContext context,
      required String userFirebaseId,
      required String courseId,
      required String attendanceDate}) async {
    //checking if all the students' attendance is marked
    if (SaveDataController.attendanceMap.length !=
        FetchDataController.enrolledStudents.length) {
      ToastMessages.showToast(CustomStrings.markAllStudAttendWarning);
    } else {
      //submit attendance to server
      //calling save attendance function
      await SaveDataController.markStudentAttendance(
          context: context,
          teacherFirebaseId: userFirebaseId,
          courseId: courseId,
          attendanceDate: attendanceDate,
          studentsAttendanceMap: SaveDataController.attendanceMap);
    }
  }
}
