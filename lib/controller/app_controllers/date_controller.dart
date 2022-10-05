import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateController extends GetxController {
  var selectedDate = DateTime.now().obs;

  Rx<TextEditingController> courseDateController = TextEditingController().obs;

  chooseDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: Get.context!,
        initialDate: selectedDate.value,
        firstDate: DateTime(2022),
        lastDate: DateTime(2025));

    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
      courseDateController.value.text =
          selectedDate.value.toString().substring(0, 10);
    }
  }
}
