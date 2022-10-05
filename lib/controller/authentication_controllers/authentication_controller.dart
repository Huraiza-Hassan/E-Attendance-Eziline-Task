import 'dart:collection';
import 'dart:convert';

import 'package:e_attendence_system/constants/constants.dart';
import 'package:e_attendence_system/models/user_model.dart';
import 'package:e_attendence_system/strings/strings.dart';
import 'package:e_attendence_system/widgets/progress_dialog/progress_dialog.dart';
import 'package:e_attendence_system/widgets/toasts/toast_messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthenticationControllers {
  //sign up method
  static Future<String> createUserOnFirebase(
      String emailAddress, String password) async {
    final UserCredential credential;
    try {
      credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      //getting user's unique id from firebase
      userFirebaseId = credential.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
    } catch (e) {
      return '$e';
    }
    return 'Success';
  }

  //sign in method
  static Future<String> signInUserFromFirebase(
      String emailAddress, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      userFirebaseId = credential.user!.uid;
      //getting user type from firebase
      await getUserType();
      //getting user profile data from firebase
      await getUserData();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
    }
    return 'Success';
  }

  //get user type method
  static Future<void> getUserType() async {
    //initializing source of the user data from firebase
    DatabaseReference userTypeRef =
        FirebaseDatabase.instance.ref('Users/User_Types');

    //getting user type
    await userTypeRef.child(userFirebaseId).once().then((value) {
      final snap = value.snapshot;
      if (snap.value != null) {
        userTypeForLoggingIn = snap.value.toString();
      }
    });
  }

  //get user data method
  static Future<void> getUserData() async {
    final ref = FirebaseDatabase.instance.ref();
    //initializing source of the user data from firebase
    final snapshot =
        await ref.child('Users/$userTypeForLoggingIn/$userFirebaseId').get();
    if (snapshot.exists) {
      //converting snapshot to json format
      final userDataMap =
          json.decode(json.encode(snapshot.value)) as Map<dynamic, dynamic>;

      //initializing user model with user attributes got from firebase
      userModel = UserModel.fromJson(userDataMap);
    } else {
      print("No data available");
    }
  }

  //get screen route according to user type method
  static String getUserScreenRoute() {
    if (userTypeForLoggingIn.isNotEmpty) {
      if (userTypeForLoggingIn == "Admin") {
        return "adminHomeScreen";
      } else if (userTypeForLoggingIn == "Student") {
        return "studentHomeScreen";
      } else if (userTypeForLoggingIn == "Faculty Member") {
        return "facultyHomeScreen";
      } else if (userTypeForLoggingIn == "Head of Department") {
        return "hodHomeScreen";
      } else {
        return "contExamHomeScreen";
      }
    } else {
      return "login";
    }
  }

  //save user data method
  static Future<void> saveUserDataOnFirebase(
      String userType, Map<String, dynamic> userInfoMap) async {
    //creating an instance of database reference at a specific location to store user entire data
    DatabaseReference userDataRef =
        FirebaseDatabase.instance.ref("Users/$userType");

    //creating an instance of database reference at a specific location to store user type
    DatabaseReference userTypeRef =
        FirebaseDatabase.instance.ref("Users/User_Types");

    //saving user type to firebase
    await userTypeRef.child(userFirebaseId).set(selectedUserType);

    //saving user data to firebase
    await userDataRef.child(userFirebaseId).set(userInfoMap);
  }

  //sign in button method
  static void signInUser(BuildContext context, String email, String pwd) async {
    //showing progress indicator
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => WillPopScope(
            onWillPop: () => Future.value(false),
            child: const ProgressDialog(msg: CustomStrings.waitText)));
    //requesting to sign in user from firebase
    var resp =
        await AuthenticationControllers.signInUserFromFirebase(email, pwd);
    //popping progress indicator
    Navigator.pop(context);
    //checking if the user authentication was successful
    if (resp == "Success") {
      //grtting screen name according to particular user
      var userScreenRoute = AuthenticationControllers.getUserScreenRoute();

      //checking if the user model contains data
      if (userModel != null) {
        ToastMessages.showToast(CustomStrings.authenticatedUserMsg);
        Get.offNamed("/$userScreenRoute");
      } else {
        ToastMessages.showToast(CustomStrings.tryAgainMsg);
      }
    }
    //displaying user the issue
    else {
      ToastMessages.showToast(resp);
    }
  }

  //sign up button method
  static void signUpUser(
      BuildContext context, String name, String email, String password) async {
    //filling user data to push on firebase
    UserModel userModel =
        UserModel(name: name, userType: selectedUserType, userEmail: email);
    //showing progress indicator
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => WillPopScope(
            onWillPop: () => Future.value(false),
            child: const ProgressDialog(msg: CustomStrings.waitText)));
    //requesting to create a user account on firebase
    var resp =
        await AuthenticationControllers.createUserOnFirebase(email, password);
    //popping progress indicator
    Navigator.pop(context);
    //checking if the account creation was successful
    if (resp == "Success") {
      ToastMessages.showToast(CustomStrings.userCreatedMsg);
      await AuthenticationControllers.saveUserDataOnFirebase(
          selectedUserType, userModel.toMap());
    } else {
      ToastMessages.showToast(resp);
    }
  }

  //sign out user method
  static Future<void> signOutFirebaseUser() async {
    //siging out user
    await FirebaseAuth.instance.signOut();
    //returning to login screen
    Get.offNamed('/login');
  }
}
