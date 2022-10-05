import 'package:e_attendence_system/strings/strings.dart';
import 'package:e_attendence_system/styles/custom_color.dart';
import 'package:e_attendence_system/styles/custom_style.dart';
import 'package:e_attendence_system/styles/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextInputField extends StatelessWidget {
  const TextInputField(
      {Key? key,
      required this.controller,
      required this.hintText,
      required this.labelText,
      required this.keyboardType,
      required this.prefixIcon,
      required this.isObscure})
      : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final TextInputType keyboardType;
  final Icon prefixIcon;
  final bool isObscure;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return CustomStrings.textFieldValidationWarning;
        } else if (value.isNotEmpty) {
          return null;
        }
      },
      autofocus: false,
      obscureText: isObscure,
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        // isDense: true,
        contentPadding: EdgeInsets.symmetric(
          vertical: 12.h,
          // horizontal: 32,
        ),
        // filled: true,
        hintText: hintText,
        hintStyle: CustomStyle.hintTextStyle,
        labelText: labelText,
        labelStyle: CustomStyle.hintTextStyle,
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 25.w, right: 15.w),
          child: SizedBox(
            width: 24.w,
            height: 24.h,
            child: prefixIcon,
          ),
        ),
        suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius),
          borderSide: BorderSide(
            width: 2,
            color: CustomColor.primaryColor.withOpacity(0.5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius),
          borderSide: BorderSide(
            width: 2,
            color: CustomColor.primaryColor.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
