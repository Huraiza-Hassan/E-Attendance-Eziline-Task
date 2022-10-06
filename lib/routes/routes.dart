import 'package:e_attendence_system/screens/auth_screens/login_screen.dart';
import 'package:e_attendence_system/screens/auth_screens/signup_screen.dart';
import 'package:e_attendence_system/screens/courses_screens/assign_course_screen.dart';
import 'package:e_attendence_system/screens/courses_screens/assigned_course_teacher_screen.dart';
import 'package:e_attendence_system/screens/courses_screens/create_course_screen.dart';
import 'package:e_attendence_system/screens/courses_screens/display_teachers.dart';
import 'package:e_attendence_system/screens/courses_screens/view_course_info_screen.dart';
import 'package:e_attendence_system/screens/home_screens/admin_home_screen/admin_home_screen.dart';
import 'package:e_attendence_system/screens/home_screens/cont_exam_home_screen/cont_exam_home_screen.dart';
import 'package:e_attendence_system/screens/home_screens/faculty_member_home_screen/enrolled_students_screen.dart';
import 'package:e_attendence_system/screens/home_screens/faculty_member_home_screen/faculty_member_courses_screen.dart';
import 'package:e_attendence_system/screens/home_screens/faculty_member_home_screen/faculty_member_home_screen.dart';
import 'package:e_attendence_system/screens/home_screens/faculty_member_home_screen/students_attendance_details_screen.dart';
import 'package:e_attendence_system/screens/home_screens/faculty_member_home_screen/view_attendance_screen.dart';
import 'package:e_attendence_system/screens/home_screens/hod_home_screen/hod_home_screen.dart';
import 'package:e_attendence_system/screens/home_screens/student_home_screen/enroll_in_course_screen.dart';
import 'package:e_attendence_system/screens/home_screens/student_home_screen/student_home_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

class Routes {
  static var pagesList = [
    //authentication pages
    GetPage(
        name: "/signup",
        page: () => const SignupScreen(),
        transition: Transition.downToUp,
        transitionDuration: const Duration(milliseconds: 800)),

    GetPage(
        name: "/login",
        page: () => const LoginScreen(),
        transition: Transition.upToDown,
        transitionDuration: const Duration(milliseconds: 800)),

    //home pages
    GetPage(
        name: "/adminHomeScreen",
        page: () => const AdminHomeScreen(),
        transition: Transition.leftToRight,
        transitionDuration: const Duration(milliseconds: 800)),

    GetPage(
        name: "/studentHomeScreen",
        page: () => const StudentHomeScreen(),
        transition: Transition.leftToRight,
        transitionDuration: const Duration(milliseconds: 800)),

    GetPage(
        name: "/facultyHomeScreen",
        page: () => const FacMembHomeScreen(),
        transition: Transition.leftToRight,
        transitionDuration: const Duration(milliseconds: 800)),

    GetPage(
        name: "/hodHomeScreen",
        page: () => const HodHomeScreen(),
        transition: Transition.leftToRight,
        transitionDuration: const Duration(milliseconds: 800)),

    GetPage(
        name: "/contExamHomeScreen",
        page: () => const ContExamHomeScreen(),
        transition: Transition.leftToRight,
        transitionDuration: const Duration(milliseconds: 800)),

    //courses screens
    GetPage(
        name: "/createCourseScreen",
        page: () => const CreateCourseScreen(),
        transition: Transition.cupertinoDialog,
        transitionDuration: const Duration(milliseconds: 800)),

    GetPage(
        name: "/viewCourseInfoScreen",
        page: () => const ViewCourseInfoScreen(),
        transition: Transition.cupertinoDialog,
        transitionDuration: const Duration(milliseconds: 800)),

    GetPage(
        name: "/viewTeacherInfoScreen",
        page: () => AssignedCourseTeacherScreen(),
        transition: Transition.cupertinoDialog,
        transitionDuration: const Duration(milliseconds: 800)),

    GetPage(
        name: "/assignCourseScreen",
        page: () => const AssignCourseScreen(),
        transition: Transition.cupertinoDialog,
        transitionDuration: const Duration(milliseconds: 800)),

    GetPage(
        name: "/availableTeachersScreen",
        page: () => AvailableTeachersScreen(),
        transition: Transition.cupertinoDialog,
        transitionDuration: const Duration(milliseconds: 800)),

    GetPage(
        name: "/enrollInCourseScreen",
        page: () => const EnrollInCourseScreen(),
        transition: Transition.cupertinoDialog,
        transitionDuration: const Duration(milliseconds: 800)),

    GetPage(
        name: "/facultyMemberCoursesScreen",
        page: () => FacultyMemberCoursesScreen(),
        transition: Transition.cupertinoDialog,
        transitionDuration: const Duration(milliseconds: 800)),

    GetPage(
        name: "/enrolledStudentsScreen",
        page: () => EnrolledStudentsScreen(),
        transition: Transition.cupertinoDialog,
        transitionDuration: const Duration(milliseconds: 800)),

    GetPage(
        name: "/viewAttendanceScreen",
        page: () => const ViewAttendanceScreen(),
        transition: Transition.cupertinoDialog,
        transitionDuration: const Duration(milliseconds: 800)),

    GetPage(
        name: "/studentsAttendanceDetailsScreen",
        page: () => StudentsAttendanceDetailsScreen(),
        transition: Transition.cupertinoDialog,
        transitionDuration: const Duration(milliseconds: 800)),
  ];
}
