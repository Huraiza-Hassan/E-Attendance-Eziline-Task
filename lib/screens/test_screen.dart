import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Hello_World".tr),
          Text("Login".tr),
          Text("Set_Profile".tr),
          Text("Fullname".tr),
          Text("Guardian".tr),
        ],
      ),
    );
  }
}
