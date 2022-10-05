import 'package:e_attendence_system/controller/app_controllers/date_controller.dart';
import 'package:e_attendence_system/helper_methods/helper_methods.dart';
import 'package:e_attendence_system/models/course_model.dart';
import 'package:e_attendence_system/strings/strings.dart';
import 'package:e_attendence_system/styles/custom_color.dart';
import 'package:e_attendence_system/widgets/app_bars/custom_app_bar.dart';
import 'package:e_attendence_system/widgets/buttons/default_button.dart';
import 'package:e_attendence_system/widgets/input_fields/date_input_text_field.dart';
import 'package:e_attendence_system/widgets/input_fields/text_input_field.dart';
import 'package:e_attendence_system/widgets/progress_dialog/progress_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CreateCourseScreen extends StatelessWidget {
  const CreateCourseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateController dateController = Get.put(DateController());
    TextEditingController degreeNameController = TextEditingController();
    TextEditingController courseNameController = TextEditingController();
    TextEditingController courseCodeController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Scaffold(
        //app bar
        appBar: const CustomAppBar(
            title: CustomStrings.createCourseScreenAppBarText),

        //body
        body: SingleChildScrollView(
          child: Column(
            children: [
              //getting degree name
              Padding(
                padding: EdgeInsets.all(8.0.h),
                child: TextInputField(
                  controller: degreeNameController,
                  hintText: "Enter Degree Name",
                  labelText: "Degree Name",
                  keyboardType: TextInputType.text,
                  prefixIcon: const Icon(
                    Icons.school,
                    color: CustomColor.primaryColor,
                  ),
                  isObscure: false,
                ),
              ),

              //getting course name
              Padding(
                padding: EdgeInsets.all(8.0.h),
                child: TextInputField(
                  controller: courseNameController,
                  hintText: "Enter Course Name",
                  labelText: "Course Name",
                  keyboardType: TextInputType.text,
                  prefixIcon: const Icon(
                    CupertinoIcons.book_fill,
                    color: CustomColor.primaryColor,
                  ),
                  isObscure: false,
                ),
              ),

              //getting course code
              Padding(
                padding: EdgeInsets.all(8.0.h),
                child: TextInputField(
                  controller: courseCodeController,
                  hintText: "Enter Course Code",
                  labelText: "Course Code",
                  keyboardType: TextInputType.text,
                  prefixIcon: const Icon(
                    CupertinoIcons.number,
                    color: CustomColor.primaryColor,
                  ),
                  isObscure: false,
                ),
              ),

              //getting course starting date
              Padding(
                padding: EdgeInsets.all(8.0.h),
                child: const DateInputTextField(
                    hintText: "Select Course Starting Date",
                    prefixIconName: Icon(
                      Icons.date_range,
                      color: CustomColor.primaryColor,
                    )),
              ),

              //submit button
              DefaultButton(
                  title: CustomStrings.submitButtonText,
                  onPresssed: () async {
                    if (!formKey.currentState!.validate()) {
                      return;
                    } else {
                      //calling create course method from controller
                      HelperMethods.createCourse(
                          context: context,
                          degreeName: degreeNameController.text,
                          courseName: courseNameController.text,
                          courseCode: courseCodeController.text,
                          courseStartingDate:
                              dateController.courseDateController.value.text);
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
