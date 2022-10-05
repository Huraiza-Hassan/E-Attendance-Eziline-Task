import 'package:e_attendence_system/controller/app_controllers/date_controller.dart';
import 'package:e_attendence_system/styles/custom_color.dart';
import 'package:e_attendence_system/styles/custom_style.dart';
import 'package:e_attendence_system/styles/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DateInputTextField extends StatelessWidget {
  const DateInputTextField(
      {Key? key, required this.hintText, required this.prefixIconName})
      : super(key: key);

  final String hintText;
  final Icon prefixIconName;

  @override
  Widget build(BuildContext context) {
    DateController dateController = Get.put(DateController());
    return TextFormField(
      validator: ((value) {
        if (value!.isNotEmpty) {
          return null;
        } else if (value.isEmpty) {
          return "Field can't be empty";
        }
      }),
      onTap: () async {
        dateController.chooseDate();
      },
      readOnly: true,
      autofocus: false,
      controller: dateController.courseDateController.value,
      textInputAction: TextInputAction.next,
      textAlignVertical: TextAlignVertical.center,
      // onSaved: (value) => widget.controller.text = value!,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          vertical: 12.h,
        ),
        hintText: hintText,
        hintStyle: CustomStyle.hintTextStyle,
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 25.w, right: 15.w),
          child: SizedBox(
            width: 24.w,
            height: 24.h,
            child: prefixIconName,
          ),
        ),
        suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius),
          borderSide: BorderSide(
            width: 2,
            color: CustomColor.secondaryColor.withOpacity(0.5),
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius),
          borderSide: BorderSide(
            width: 2,
            color: CustomColor.secondaryColor.withOpacity(0.5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius),
          borderSide: BorderSide(
            width: 2,
            color: CustomColor.secondaryColor.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
