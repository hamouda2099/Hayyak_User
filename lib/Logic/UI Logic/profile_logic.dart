import 'package:flutter/material.dart';
import 'package:hayyak/Dialogs/message_dialog.dart';
import 'package:hayyak/Models/profile_model.dart';

class ProfileLogic {
  late BuildContext context;
  TextEditingController firstNameCnt = TextEditingController();
  TextEditingController lastNameCnt = TextEditingController();
  TextEditingController emailCnt = TextEditingController();
  TextEditingController phoneCnt = TextEditingController();
  TextEditingController passwordCnt = TextEditingController();

  void init(AsyncSnapshot<ProfileModel> snapshot){
    firstNameCnt.text = snapshot.data!.data.firstName;
    lastNameCnt.text = snapshot.data!.data.lastName;
    emailCnt.text = snapshot.data!.data.email;
    phoneCnt.text = snapshot.data!.data.phone;
  }

  void updateProfile(){
    if (
    firstNameCnt.text.isEmpty || lastNameCnt.text.isEmpty||
        phoneCnt.text.isEmpty || emailCnt.text.isEmpty || passwordCnt.text.isEmpty ) {
    messageDialog(
      context,'Some fields are required!'
    );
    } else {

    }
  }
}