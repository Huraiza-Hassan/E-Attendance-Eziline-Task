import 'package:e_attendence_system/controller/getx_controller.dart';
import 'package:e_attendence_system/screens/test_screen.dart';
import 'package:e_attendence_system/user%20Defined%20Classes%20for%20getx/student.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var number = 0.obs;
    void increment() {
      number += 1;
    }

    // var student = Student();

    // for making the entire class observable
    // var student = Student(name: "Ali", age: 30).obs;

    //for using getx controller
    MyController myController = Get.put(MyController());

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Obx(() {
              return Text("Count is: $number");
            }),
          ),
          ElevatedButton(
            onPressed: () {
              increment();
            },
            child: const Text("Increment"),
          ),
          Obx(() {
            //if the individual variable is observable
            // return Text("Name is: ${student.name}");

            //if entire class is observable
            // return Text("Name is: ${student.value.name}");

            //if we are using getx controller (with individual variable observable)
            // return Text("Name is: ${myController.student.name}");

            //if we are using getx controller (with entire class observable)
            return Text("Name is: ${myController.student.value.name}");
          }),
          ElevatedButton(onPressed: () {
            //if the individual variable is observable
            // student.name.value = student.name.toUpperCase();

            //if the entire class is observable
            // student.update((student) {
            //   student!.name = student.name.toString().toUpperCase();
            // });

            //if we are using getx controller
            if (myController.isUpperCase.isTrue) {
              myController.convertToUpperCase();
              myController.changeButtonState();
            } else {
              myController.convertToLowerCase();
              myController.changeButtonState();
            }
          }, child: Obx(() {
            return (myController.isUpperCase.isTrue)
                ? const Text("Upper Case")
                : const Text("Lower Case");
          })),
          GetX<MyController>(
              init: MyController(),
              builder: ((controller) {
                return Text("${controller.frameworkName}");
              })),
          ElevatedButton(
              onPressed: () {
                //if we are using getx with controller type
                Get.find<MyController>().changeFrameworkName();
              },
              child: const Text("Change Framework Name"))
        ],
      ),
    );
  }
}
