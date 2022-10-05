import 'dart:async';
import 'dart:convert';

import 'package:e_attendence_system/constants/constants.dart';
import 'package:e_attendence_system/controller/data_controllers/save_data_controller.dart';
import 'package:e_attendence_system/models/attendance_model.dart';
import 'package:e_attendence_system/models/course_model.dart';
import 'package:e_attendence_system/models/user_model.dart';
import 'package:e_attendence_system/strings/strings.dart';
import 'package:e_attendence_system/widgets/toasts/toast_messages.dart';
import 'package:firebase_database/firebase_database.dart';

class FetchDataController {
  //courses list
  static List<String> coursesIds = [];

  //courses data map
  static Map coursesDataMap = {};

  //course model list
  static List<CourseModel> courses = [];

  //initializing user model
  static UserModel? teacherModel;

  //get courses data method
  static Future<Map> getCoursesData() async {
    final ref = FirebaseDatabase.instance.ref();

    //initializing source of the user data from firebase
    final snapshot = await ref.child('Available Courses').get();

    //clearing courses list
    courses = [];

    if (snapshot.exists) {
      //clearing courses data map
      coursesDataMap = {};
      //converting snapshot to json format
      coursesDataMap =
          json.decode(json.encode(snapshot.value)) as Map<dynamic, dynamic>;

      //clearing courses ids list
      coursesIds = [];

      //getting ids of all courses
      coursesDataMap.forEach((key, value) {
        coursesIds.add(key);
      });

      //assigning course data to courses list
      for (int i = 0; i <= coursesIds.length - 1; i++) {
        //passing each course's map to course model to be assigned to it
        //courseIds list is being used to fetch each course's data from coursesDataMap
        courses.add(CourseModel.fromJson(coursesDataMap[coursesIds[i]]));
      }

      return coursesDataMap;
      // //initializing user model with user attributes got from firebase
      // userModel = UserModel.fromJson(userDataMap);
    } else {
      ToastMessages.showToast(CustomStrings.noDataFoundMsg);
      return {};
    }
  }

  //initializing map to get faculty member's assigned courses data
  static Map facMemberCoursesDataMap = {};

  //initializing list to get faculty member's assigned courses ids
  static List facMemberCoursesIds = [];

  //initializing list of CourseModel type to store its objects in it
  static List<CourseModel> facMemberCourses = [];

  //get faculty member's courses data method
  static Future<Map> getFacMemberCoursesData() async {
    //reference for assigned courses ids
    final ref = FirebaseDatabase.instance.ref();

    //clearing facMemberCourses list
    facMemberCourses = [];

    //initializing source of the courses data from firebase
    final snapshot = await ref
        .child('Users/Faculty Member/$userFirebaseId/assignedCourses')
        .get();

    if (snapshot.exists) {
      //clearing facMemberCoursesDataMap map
      facMemberCoursesDataMap = {};
      //converting snapshot to json format
      facMemberCoursesDataMap =
          json.decode(json.encode(snapshot.value)) as Map<dynamic, dynamic>;

      //clearing facMemberCoursesIds list
      facMemberCoursesIds = [];

      //getting ids of all courses
      facMemberCoursesDataMap.forEach((key, value) {
        facMemberCoursesIds.add(key);
      });

      //initializing source of the course data from firebase
      DatabaseReference courseDataRef =
          FirebaseDatabase.instance.ref('Available Courses');

      //getting each course' data one by one by using assigned course id
      for (int i = 0; i <= facMemberCoursesIds.length - 1; i++) {
        //getting course data
        await courseDataRef.child(facMemberCoursesIds[i]).once().then((value) {
          final snap = value.snapshot;
          if (snap.value != null) {
            //converting snap value to json format
            facMemberCoursesDataMap =
                json.decode(json.encode(snap.value)) as Map<dynamic, dynamic>;
            //initializing courseModel with every assigned course data
            facMemberCourses.add(CourseModel.fromJson(facMemberCoursesDataMap));
          }
        });
      }

      return facMemberCoursesDataMap;
    } else {
      ToastMessages.showToast(CustomStrings.noDataFoundMsg);
      return {};
    }
  }

  //----------------------------------------------------------------------------

  //initializing map to get enrolled students' data
  static Map enrolledStudentsDataMap = {};

  //initializing list to get enrolled students' ids
  static List enrolledStudentsIds = [];

  //initializing list of UserModel type to store its objects in it
  static List<UserModel> enrolledStudents = [];

  //get enrolled students data method
  static Future<Map> getEnrolledStudentsData(String courseId) async {
    //clearing student attendance map to avoid repetition of data
    SaveDataController.attendanceMap = {};

    //reference for enrolled students' ids
    final ref = FirebaseDatabase.instance.ref();

    //initializing source of the courses data from firebase
    final snapshot =
        await ref.child('Available Courses/$courseId/enrolledStudents').get();

    //clearing enrolled students list
    enrolledStudents = [];

    if (snapshot.exists) {
      //clearing enrolledStudentsDataMap map
      enrolledStudentsDataMap = {};
      //converting snapshot to json format
      enrolledStudentsDataMap =
          json.decode(json.encode(snapshot.value)) as Map<dynamic, dynamic>;

      //clearing enrolledStudentsIds list
      enrolledStudentsIds = [];

      //getting ids of all enrolled students
      enrolledStudentsDataMap.forEach((key, value) {
        enrolledStudentsIds.add(key);
      });

      //initializing source of the course data from firebase
      DatabaseReference studentsDataRef =
          FirebaseDatabase.instance.ref('Users/Student');

      //getting each enrolled student's data one by one by using enrolled student id
      for (int i = 0; i <= enrolledStudentsIds.length - 1; i++) {
        //getting course data
        await studentsDataRef
            .child(enrolledStudentsIds[i])
            .once()
            .then((value) {
          final snap = value.snapshot;
          if (snap.value != null) {
            //converting snap value to json format
            enrolledStudentsDataMap =
                json.decode(json.encode(snap.value)) as Map<dynamic, dynamic>;
            //initializing UserModel with every enrolled student's data
            enrolledStudents.add(UserModel.fromJson(enrolledStudentsDataMap));
          }
        });
      }

      return enrolledStudentsDataMap;
    } else {
      ToastMessages.showToast(CustomStrings.noDataFoundMsg);
      return {};
    }
  }

  //---------------------------------------------------------------------------------

  //getting students' attendance details method (starting)
  //initializing map to get attendance data
  static Map attendanceDataMap = {};

  //initializing list to get each attendance data as its key
  static List attendanceDatesIds = [];

  //initializing list of AttendanceModel type to store its objects in it
  static List<AttendanceModel> attendances = [];

  //get enrolled students data method
  static Future<Map> getStudentsAttendances(
      {required String teacherFirebaseId,
      required String teacherCourseId}) async {
    //reference for students' attendances
    final ref = FirebaseDatabase.instance.ref();

    //initializing source of the courses data from firebase
    final snapshot = await ref
        .child(
            'Users/Faculty Member/$teacherFirebaseId/attendances/$teacherCourseId')
        .get();

    //clearing attendanceDataMap map
    attendanceDataMap = {};

    //clearing attendanceDatesIds list
    attendanceDatesIds = [];

    //clearing attendances list
    attendances = [];

    if (snapshot.exists) {
      //converting snapshot to json format
      attendanceDataMap =
          json.decode(json.encode(snapshot.value)) as Map<dynamic, dynamic>;

      //getting ids of all enrolled students
      attendanceDataMap.forEach((key, value) {
        attendanceDatesIds.add(key);
      });

      //initializing attendanceModel with attendance details
      for (int i = 0; i <= attendanceDatesIds.length - 1; i++) {
        Map attendMap = attendanceDataMap[attendanceDatesIds[i]];
        attendMap.forEach((key, value) {
          attendances.add(AttendanceModel(
              attendanceDate: attendanceDatesIds[i],
              studentName: key,
              attendanceStatus: value));
        });
      }

      return attendanceDataMap;
    } else {
      ToastMessages.showToast(CustomStrings.noDataFoundMsg);
      return {};
    }
  }
  //getting students' attendance details method (ending)

  //get course's assigned teacher id method
  static Future<String?> getAssignedTeacherId(String courseId) async {
    //initializing source of the user data from firebase
    DatabaseReference assignedTeacherIdRef = FirebaseDatabase.instance
        .ref('Available Courses/$courseId/assignedTeacherId');

    //assigned teacher id
    String? assignedTeacherId;

    //getting assigned teacher id
    await assignedTeacherIdRef.once().then((value) async {
      final snap = value.snapshot;
      if (snap.value != null) {
        assignedTeacherId = snap.value.toString();
        //getting assigned teacher data from firebase
        await FetchDataController.getAssignedTeacherData(assignedTeacherId!);
      } else {
        ToastMessages.showToast(CustomStrings.noDataFoundMsg);
      }
    });
    return assignedTeacherId;
  }

  //get assigned teacher data method
  static Future<void> getAssignedTeacherData(String assignedTeacherId) async {
    final ref = FirebaseDatabase.instance.ref();

    //initializing source of the user data from firebase
    final snapshot = await ref
        .child('Users')
        .child('Faculty Member')
        .child(assignedTeacherId)
        .get();

    if (snapshot.exists) {
      //assigned Teacher data map
      Map assignedTeacherDataMap = {};
      //converting snapshot to json format
      assignedTeacherDataMap =
          json.decode(json.encode(snapshot.value)) as Map<dynamic, dynamic>;

      // //initializing user model with teacher attributes got from firebase
      FetchDataController.teacherModel =
          UserModel.fromJson(assignedTeacherDataMap);
    } else {
      ToastMessages.showToast(CustomStrings.noDataFoundMsg);
    }
  }

  //check if the course is already assigned to any teacher method
  static Future<bool> checkCourseAssignment(String courseId) async {
    //creating an instance of course reference to firebase
    DatabaseReference courseRef = FirebaseDatabase.instance
        .ref("Available Courses/$courseId/assignedTeacherId");

    final snapshot = await courseRef.get();
    if (snapshot.exists) {
      return true;
    } else {
      return false;
    }
  }

  //faculty members map
  static Map facultyMembersDataMap = {};

  //faculty members ids list
  static List<String> facultyMembersIds = [];

  //teachers list of UserModel type
  static List<UserModel> teachers = [];

  //get faculty members data method
  static Future<Map> getFacultyMembersData() async {
    final ref = FirebaseDatabase.instance.ref();

    //initializing source of the user data from firebase
    final snapshot = await ref.child('Users/Faculty Member').get();

    //clearing faculty members data map
    facultyMembersDataMap = {};

    //clearing facultyMembers ids list
    facultyMembersIds = [];

    //clearing teachers list
    teachers = [];

    if (snapshot.exists) {
      //converting snapshot to json format
      facultyMembersDataMap =
          json.decode(json.encode(snapshot.value)) as Map<dynamic, dynamic>;

      //getting ids of all faculty members
      facultyMembersDataMap.forEach((key, value) {
        facultyMembersIds.add(key);
      });

      //assigning faculty member's data to teachers list
      for (int i = 0; i <= facultyMembersIds.length - 1; i++) {
        //passing each faculty member's map to user model to be assigned to it
        //facultyMembersIds list is being used to fetch each teacher's data from facultyMembersDataMap
        teachers.add(
            UserModel.fromJson(facultyMembersDataMap[facultyMembersIds[i]]));
      }

      return facultyMembersDataMap;
    } else {
      ToastMessages.showToast(CustomStrings.noDataFoundMsg);
      return {};
    }
  }
}
