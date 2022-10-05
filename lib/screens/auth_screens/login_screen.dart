import 'package:e_attendence_system/constants/constants.dart';
import 'package:e_attendence_system/controller/authentication_controllers/authentication_controller.dart';
import 'package:e_attendence_system/strings/strings.dart';
import 'package:e_attendence_system/styles/custom_color.dart';
import 'package:e_attendence_system/styles/custom_style.dart';
import 'package:e_attendence_system/widgets/buttons/default_button.dart';
import 'package:e_attendence_system/widgets/input_fields/text_input_field.dart';
import 'package:e_attendence_system/widgets/progress_dialog/progress_dialog.dart';
import 'package:e_attendence_system/widgets/toasts/toast_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController pwdController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(CustomStrings.loginButtonText),
          centerTitle: true,
          backgroundColor: CustomColor.primaryColor,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //decoration image
              Image.asset(
                "assets/images/auth_images/login.png",
                width: 1.sw,
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
                    Icons.email,
                    color: CustomColor.primaryColor,
                  ),
                  isObscure: true,
                ),
              ),
              //new user signup button
              TextButton(
                  onPressed: () {
                    //navigating to signup page and deleting current page from stack
                    Get.offNamed("/signup");
                  },
                  child: Text(
                    CustomStrings.newUserSignupButtonText,
                    style: CustomStyle.signupButtonTextStyle,
                  )),
              //login button
              DefaultButton(
                  title: CustomStrings.loginButtonText,
                  onPresssed: () async {
                    if (!formKey.currentState!.validate()) {
                      return;
                    } else {
                      AuthenticationControllers.signInUser(
                          context, emailController.text, pwdController.text);
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
