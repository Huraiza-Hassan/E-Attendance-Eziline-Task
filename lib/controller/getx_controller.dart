import 'package:e_attendence_system/user%20Defined%20Classes%20for%20getx/student.dart';
import 'package:get/get.dart';

class MyController extends GetxController {
  //if the individual variable is observable
  // var student = Student();

  // void convertToUpperCase() {
  //   student.name.value = student.name.toUpperCase();
  // }

  //if the entire class is observable
  var student = Student(name: "Huraiza", age: 22).obs;

  void convertToUpperCase() {
    student.update((student) {
      student!.name = student.name.toString().toUpperCase();
    });
  }

  void convertToLowerCase() {
    student.update((student) {
      student!.name = student.name.toString().toLowerCase();
    });
  }

  //for button
  var isUpperCase = RxBool(false);

  void changeButtonState() {
    isUpperCase.toggle();
  }

  //getx with controller type
  var frameworkName = "Flutter".obs;

  void changeFrameworkName() {
    if (frameworkName.value == "Flutter") {
      frameworkName.value = "Dart";
    } else if (frameworkName.value == "Dart") {
      frameworkName.value = "Flutter";
    }
  }
}
