import 'package:flutter/material.dart';
import 'package:hayyak/Config/user_data.dart';
import 'package:hayyak/Dialogs/message_dialog.dart';
import 'package:hayyak/UI/Screens/home_screen.dart';

import '../../Config/navigator.dart';
import '../Services/api_manger.dart';

class ContactUsLogic {
  late BuildContext context;
  TextEditingController nameCnt = TextEditingController();
  TextEditingController phoneCnt = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  void submitForm() async {
    await ApiManger.contactUs(
            email: emailController.text,
            phone: phoneCnt.text,
            name: nameCnt.text,
            subject: subjectController.text,
            details: detailsController.text)
        .then((value) {
      if (value.statusCode == 200) {
        navigator(context: context, screen: HomeScreen());
        messageDialog(context, "Your feedback sent successfully");
      } else {
        messageDialog(context, "An Error occurred!");
      }
    });
  }
}
