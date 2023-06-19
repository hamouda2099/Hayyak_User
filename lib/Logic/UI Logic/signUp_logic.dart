import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/Dialogs/loading_dialog.dart';
import 'package:hayyak/Dialogs/message_dialog.dart';
import 'package:hayyak/Dialogs/verified_account_dialog.dart';
import 'package:hayyak/Logic/Services/api_manger.dart';
import 'package:hayyak/UI/Screens/verify_otp_code_screen.dart';

class SignUpLogic {
  static String otpCode = '';
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  // final FacebookAuth facebookAuth = FacebookAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  static void signUp({
    required BuildContext context,
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required String dateOfBirth,
    required String password,
    required String confirmPassword,
    required String gender,
  }) {
    if (email.isEmpty ||
        password.isEmpty ||
        firstName.isEmpty ||
        lastName.isEmpty ||
        gender.isEmpty ||
        confirmPassword.isEmpty ||
        dateOfBirth.isEmpty ||
        phone.isEmpty) {
      messageDialog(context, 'Some Fields is required !');
    } else {
      loadingDialog(context);
      ApiManger.registerUser(
              firstName: firstName,
              lastName: lastName,
              email: email,
              phone: phone,
              gender: gender,
              password: password,
              confirmPassword: confirmPassword,
              dateOfBirth: dateOfBirth)
          .then((value) async {
        Navigator.pop(context);
        if (jsonDecode(value.body)['success'] == true &&
            jsonDecode(value.body)['code'] == 200) {
          otpCode = jsonDecode(value.body)['data']['otp'].toString();
          navigator(
              context: context,
              screen: VerifyOtpCodeScreen(
                otpCode: otpCode,
                email: email,
              ),
              remove: true);
        } else {
          messageDialog(context,
              '${jsonDecode(value.body)['error'] ?? jsonDecode(value.body)['code']}');
        }
      });
    }
  }

  static void verifyOtpCode(
      {required BuildContext context,
      required String email,
      required String otp}) {
    loadingDialog(context);
    ApiManger.verifyOtp(email: email, otp: otp).then((value) {
      if (jsonDecode(value.body)['success'] &&
          jsonDecode(value.body)['code'] == 200) {
        Navigator.pop(context);
        verifiedAccountDialog(context, jsonDecode(value.body)['message']);
      } else {
        Navigator.pop(context);
        messageDialog(
            context,
            jsonDecode(value.body)['message'] ??
                jsonDecode(value.body)['code']);
      }
    });
  }

  static void requestOtpCode(
      {required BuildContext context, required String email}) {
    loadingDialog(context);
    ApiManger.requestCode(email: email).then((value) {
      if (jsonDecode(value.body)['success'] == true &&
          jsonDecode(value.body)['code'] == 200) {
        otpCode = jsonDecode(value.body)['data']['otp'].toString();
        Navigator.pop(context);
        messageDialog(context, '${jsonDecode(value.body)['message']}');
      } else {
        Navigator.pop(context);
        messageDialog(context, '${jsonDecode(value.body)['error']}');
      }
    });
  }

  signUpWithGoogle({required BuildContext context}) async {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    final GoogleSignInAuthentication? googleSignInAuthentication =
        await googleSignInAccount?.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken);
    final UserCredential user =
        await firebaseAuth.signInWithCredential(credential);
    print(user.user.toString());
    ApiManger.registerUser(
            firstName: user.user?.displayName ?? '',
            lastName: user.user?.displayName ?? '',
            phone: user.user?.phoneNumber ?? '',
            email: user.user?.email ?? '',
            dateOfBirth: '2000-01-01',
            password: '000',
            confirmPassword: '000',
            gender: 'male')
        .then((value) {
      print(value.body);
    });
    messageDialog(context, "Signed");
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
