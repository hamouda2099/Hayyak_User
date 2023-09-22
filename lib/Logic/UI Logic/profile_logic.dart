import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hayyak/Dialogs/message_dialog.dart';
import 'package:hayyak/Logic/Services/api_manger.dart';
import 'package:hayyak/Models/profile_model.dart';

import '../../Config/navigator.dart';
import '../../Dialogs/loading_dialog.dart';
import '../../UI/Screens/edit_account_screen.dart';

class ProfileLogic {
  final formKey = GlobalKey<FormState>();
  late BuildContext context;
  TextEditingController firstNameCnt = TextEditingController();
  TextEditingController lastNameCnt = TextEditingController();
  TextEditingController emailCnt = TextEditingController();
  TextEditingController phoneCnt = TextEditingController();
  TextEditingController passwordCnt = TextEditingController();
  File? imageFile;

  void init(AsyncSnapshot<ProfileModel> snapshot) {
    firstNameCnt.text = snapshot.data?.data?.firstName ?? '';
    lastNameCnt.text = snapshot.data?.data?.lastName ?? '';
    phoneCnt.text = snapshot.data!.data!.phone ?? '';
  }

  void updateProfile() {
    if (firstNameCnt.text.isEmpty ||
        lastNameCnt.text.isEmpty ||
        phoneCnt.text.isEmpty ||
        passwordCnt.text.isEmpty) {
      messageDialog(context, 'Some fields are required!');
    } else {
      loadingDialog(context);
      // ApiManger.uploadProfileMultiPart(
      //         image: imageFile,
      //         firstName: firstNameCnt.text,
      //         lastName: lastNameCnt.text,
      //         password: passwordCnt.text,
      //         mobile: phoneCnt.text)
      //     .then((value) {
      //   print(value);
      // });
      ApiManger.updateProfile(
              image: imageFile,
              firstName: firstNameCnt.text,
              lastName: lastNameCnt.text,
              password: passwordCnt.text,
              mobile: phoneCnt.text)
          .then((value) {
        Navigator.pop(context);
        if (value['success'] == true) {
          navigator(
            context: context,
            screen: EditAccountScreen(),
            replacement: true,
          );
          messageDialog(context, '${value['message'] ?? ''}');
        } else {
          messageDialog(context, '${value['message'] ?? ''}');
        }
      });
    }
  }
}
