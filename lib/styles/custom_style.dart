import 'package:e_attendence_system/styles/custom_color.dart';
import 'package:e_attendence_system/styles/dimensions.dart';
import 'package:flutter/material.dart';

class CustomStyle {
  //text field hint style
  static var hintTextStyle = TextStyle(
    fontSize: Dimensions.defaultTextSize,
    fontWeight: FontWeight.normal,
    color: CustomColor.primaryColor,
  );

  //normal text style
  static var normalTextStyle = TextStyle(
    fontSize: Dimensions.mediumTextSize,
    fontWeight: FontWeight.bold,
    color: CustomColor.primaryColor,
  );

  //button text style
  static var buttonTextStyle = TextStyle(
    fontSize: Dimensions.defaultTextSize,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  //signup button text style
  static var signupButtonTextStyle = TextStyle(
    fontSize: Dimensions.defaultTextSize,
    fontWeight: FontWeight.normal,
    color: CustomColor.primaryColor,
  );

  //main menu button text style
  static var mainMenuButtonTextStyle = TextStyle(
      fontSize: Dimensions.mediumTextSize,
      fontWeight: FontWeight.bold,
      color: CustomColor.secondaryColor);

  //list view text styles

  //date text style
  static var dateTextStyle = TextStyle(
      fontSize: Dimensions.smallTextSize,
      fontWeight: FontWeight.normal,
      color: Colors.white);

  //list title text style
  static var listTitleTextStyle = TextStyle(
      fontSize: Dimensions.mediumTextSize,
      fontWeight: FontWeight.bold,
      color: Colors.white);

  //date text style
  static var empIdTextStyle = TextStyle(
      fontSize: Dimensions.smallTextSize,
      fontWeight: FontWeight.bold,
      color: Colors.orange);

  //attendance date text style
  static var attendDateTextStyle = TextStyle(
      fontSize: Dimensions.mediumTextSize,
      fontWeight: FontWeight.bold,
      color: Colors.orange);
}
