import 'dart:convert';

import 'package:e_attendence_system/strings/strings.dart';
import 'package:e_attendence_system/widgets/progress_dialog/progress_dialog.dart';
import 'package:e_attendence_system/widgets/toasts/toast_messages.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class SaveDataController {
  //save course data method
  static Future<void> saveCourseDataOnFirebase(
      Map<String, dynamic> courseInfoMap) async {
    //creating an instance of database reference at a specific location to store course data
    DatabaseReference userDataRef =
        FirebaseDatabase.instance.ref("Available Courses").push();

    //saving course data to firebase
    await userDataRef.set(courseInfoMap);
  }

  //assign a course to teacher method
  static Future<void> assingCourseToTeacher(
      {required BuildContext context,
      required String courseId,
      required String facultyMemberFirebaseId}) async {
    //showing progress indicator
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => WillPopScope(
            onWillPop: () => Future.value(false),
            child: const ProgressDialog(msg: CustomStrings.waitText)));
    //creating an instance of database reference at a specific location to store teacher id to selected course
    DatabaseReference courseRef = FirebaseDatabase.instance
        .ref("Available Courses/$courseId/assignedTeacherId");

    //creating an instance of database reference at a specific location to store courses ids
    DatabaseReference userRef = FirebaseDatabase.instance
        .ref("Users/Faculty Member/$facultyMemberFirebaseId/assignedCourses");

    //initializing assigned courses map
    Map assignedCoursesMap = {};

    //getting previous assigned courses ids map (start)
    //initializing source of the user data from firebase
    final snapshot = await userRef.get();

    if (snapshot.exists) {
      //in case teacher is also being assigned some other courses
      //clearing assigned courses ids map
      assignedCoursesMap = {};
      //converting snapshot to json format
      assignedCoursesMap =
          json.decode(json.encode(snapshot.value)) as Map<dynamic, dynamic>;

      //adding new course id to previously created assigned courses map
      assignedCoursesMap[courseId] = "assigned";
    } else {
      //in case there is first course being assigned to teacher
      //clearing assigned courses ids map
      assignedCoursesMap = {};

      //adding new course id to previously created assigned courses map
      assignedCoursesMap[courseId] = "assigned";

      print("No data available");
    }
    //getting previous assigned courses ids map (end)

    //saving faculty member firebase id to firebase
    await courseRef.set(facultyMemberFirebaseId);

    //assiging course to teacher
    await userRef.set(assignedCoursesMap);

    //popping progress indicator
    Navigator.pop(context);

    //displaying success message
    ToastMessages.showToast(CustomStrings.courseAssignedMsg);
  }

  //enroll in a course method
  static Future<void> enrollStudentInCourse(
      {required BuildContext context,
      required String courseId,
      required String studentFirebaseId}) async {
    //showing progress indicator
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => WillPopScope(
            onWillPop: () => Future.value(false),
            child: const ProgressDialog(msg: CustomStrings.waitText)));
    //creating an instance of database reference at a specific location to store student id to selected course
    DatabaseReference enrolledStudentsRef = FirebaseDatabase.instance
        .ref("Available Courses/$courseId/enrolledStudents");

    //initializing assigned courses map
    Map enrolledStudentsMap = {};

    //getting previous enrolled students map (start)
    //initializing source of the user data from firebase
    final snapshot = await enrolledStudentsRef.get();

    if (snapshot.exists) {
      //in case there are some other students also enrolled in a course
      //clearing enrolled students ids map
      enrolledStudentsMap = {};
      //converting snapshot to json format
      enrolledStudentsMap =
          json.decode(json.encode(snapshot.value)) as Map<dynamic, dynamic>;

      //adding new course id to previously created assigned courses map
      enrolledStudentsMap[studentFirebaseId] = "enrolled";
    } else {
      //in case there is first student being enrolled in a course
      //clearing enrolledStudentsMap map
      enrolledStudentsMap = {};

      //adding new student id to previously created enrolled courses map
      enrolledStudentsMap[studentFirebaseId] = "enrolled";

      print("No data available");
    }
    //getting previous enrolled students ids map (end)

    //saving student firebase id to firebase
    await enrolledStudentsRef.set(enrolledStudentsMap);

    //popping progress indicator
    Navigator.pop(context);

    //displaying success message
    ToastMessages.showToast(CustomStrings.studentEnrolledMsg);
  }

  //initializing attendance map for students attendance
  static Map attendanceMap = {};

  //mark student attendance method
  static Future<void> markStudentAttendance(
      {required BuildContext context,
      required String teacherFirebaseId,
      required String courseId,
      required String attendanceDate,
      required Map studentsAttendanceMap}) async {
    //showing progress indicator
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => WillPopScope(
            onWillPop: () => Future.value(false),
            child: const ProgressDialog(msg: CustomStrings.waitText)));
    //creating an instance of database reference at a specific location to store students' attendance to selected course
    DatabaseReference attendanceRef = FirebaseDatabase.instance
        .ref("Users/Faculty Member/$teacherFirebaseId/attendances/$courseId");

    //pushing attendance map to firebase
    await attendanceRef.child(attendanceDate).set(studentsAttendanceMap);

    //popping progress indicator
    Navigator.pop(context);

    //displaying success message
    ToastMessages.showToast(CustomStrings.attendanceMarkedMsg);
  }
}
