import 'package:flutter/material.dart';
import 'package:hayyak/Dialogs/message_dialog.dart';
import 'package:hayyak/UI/Screens/home_screen.dart';

import '../../Config/navigator.dart';
import '../../Config/user_data.dart';
import '../Services/api_manger.dart';

class ContactUsLogic {
  late BuildContext context;
  final formKey = GlobalKey<FormState>();
  TextEditingController nameCnt = TextEditingController();
  TextEditingController phoneCnt = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  void submitForm() async {
    if (nameCnt.text.isEmpty ||
        phoneCnt.text.isEmpty ||
        subjectController.text.isEmpty ||
        detailsController.text.isEmpty ||
        emailController.text.isEmpty) {
      messageDialog(
          context,
          UserData.translation.data?.someFieldsAreRequired?.toString() ??
              "Some Fields Are Required");
    } else {
      await ApiManger.contactUs(
              email: emailController.text,
              phone: phoneCnt.text,
              name: nameCnt.text,
              subject: subjectController.text,
              details: detailsController.text)
          .then((value) {
        print(value.body);
        if (value.statusCode == 200) {
          navigator(context: context, screen: HomeScreen());
          messageDialog(
              context,
              UserData.translation.data?.feedbackSentSuccessfully?.toString() ??
                  "Your feedback sent successfully");
        } else {
          messageDialog(
              context,
              UserData.translation.data?.anErrorOccurred?.toString() ??
                  "An Error occurred!");
        }
      });
    }
  }
}
