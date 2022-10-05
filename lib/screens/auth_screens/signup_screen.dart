import 'package:e_attendence_system/constants/constants.dart';
import 'package:e_attendence_system/controller/authentication_controllers/authentication_controller.dart';
import 'package:e_attendence_system/models/user_model.dart';
import 'package:e_attendence_system/strings/strings.dart';
import 'package:e_attendence_system/styles/custom_color.dart';
import 'package:e_attendence_system/styles/custom_style.dart';
import 'package:e_attendence_system/widgets/add_spaces/spaces.dart';
import 'package:e_attendence_system/widgets/buttons/default_button.dart';
import 'package:e_attendence_system/widgets/buttons/user_type_selection_button.dart';
import 'package:e_attendence_system/widgets/input_fields/text_input_field.dart';
import 'package:e_attendence_system/widgets/progress_dialog/progress_dialog.dart';
import 'package:e_attendence_system/widgets/text_widgets/text_widgets.dart';
import 'package:e_attendence_system/widgets/toasts/toast_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController pwdController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(CustomStrings.signUpButtonText),
          centerTitle: true,
          backgroundColor: CustomColor.primaryColor,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //decoration image
              Image.asset(
                "assets/images/auth_images/signup.png",
                width: 1.sw,
              ),
              //getting user name
              Padding(
                padding: EdgeInsets.all(8.0.h),
                child: TextInputField(
                  controller: nameController,
                  hintText: "Enter Name",
                  labelText: "Name",
                  keyboardType: TextInputType.text,
                  prefixIcon: const Icon(
                    Icons.person,
                    color: CustomColor.primaryColor,
                  ),
                  isObscure: false,
                ),
              ),
              //getting user email
              Padding(
                padding: EdgeInsets.all(8.0.h),
                child: TextInputField(
                  controller: emailController,
                  hintText: "Enter Email",
                  labelText: "Email",
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(
                    Icons.email,
                    color: CustomColor.primaryColor,
                  ),
                  isObscure: false,
                ),
              ),
              //getting user password
              Padding(
                padding: EdgeInsets.all(8.0.h),
                child: TextInputField(
                  controller: pwdController,
                  hintText: "Enter Password",
                  labelText: "Password",
                  keyboardType: TextInputType.visiblePassword,
                  prefixIcon: const Icon(
                    Icons.password,
                    color: CustomColor.primaryColor,
                  ),
                  isObscure: true,
                ),
              ),
              //asking user type
              Column(
                children: [
                  TextWidgets.userTypeText(),
                  addVerticalSpace(5.h),
                  userTypeButton()
                ],
              ),
              //go to login screen button
              TextButton(
                  onPressed: () {
                    //navigating to login page and deleting current page from stack
                    Get.offNamed("/login");
                  },
                  child: Text(
                    CustomStrings.goToLoginScreenButtonText,
                    style: CustomStyle.signupButtonTextStyle,
                  )),
              //login button
              DefaultButton(
                  title: CustomStrings.signUpButtonText,
                  onPresssed: () async {
                    if (!formKey.currentState!.validate()) {
                      return;
                    } else if (selectedUserType == "") {
                      ToastMessages.showToast(
                          CustomStrings.userTypeValidationWarning);
                    } else {
                      AuthenticationControllers.signUpUser(
                          context,
                          nameController.text,
                          emailController.text,
                          pwdController.text);
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
