import 'package:flutter/material.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Logic/UI%20Logic/contact_us_logic.dart';
import 'package:hayyak/UI/Components/seccond_app_bar.dart';
import 'package:hayyak/UI/Components/text_field.dart';
import 'package:hayyak/main.dart';

import '../../Config/user_data.dart';

class ContactUsScreen extends StatelessWidget {
  ContactUsLogic logic = ContactUsLogic();

  @override
  Widget build(BuildContext context) {
    logic.context = context;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SecondAppBar(
                  title: UserData.translation.data?.contactUs?.toString() ??
                      'Contact Us',
                  shareAndFav: false,
                  backToHome: false),
              CustomTextField(
                width: screenWidth / 1.2,
                controller: logic.nameCnt,
                hintText:
                    UserData.translation.data?.firstName?.toString() ?? 'Name',
                obscure: false,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: screenWidth / 1.2,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.5,
                    color: kLightGreyColor.withOpacity(0.3),
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      width: 50,
                      child: TextField(
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: '  +966',
                          hintStyle: TextStyle(
                              color: kLightGreyColor.withOpacity(0.8),
                              fontWeight: FontWeight.w300,
                              fontSize: 12),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const Text(
                      '|',
                      style: TextStyle(color: kLightGreyColor, fontSize: 14),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      width: screenWidth / 2.5,
                      child: TextField(
                        controller: logic.phoneCnt,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText:
                              UserData.translation.data?.phone?.toString() ??
                                  'Phone',
                          hintStyle: TextStyle(
                              color: kLightGreyColor.withOpacity(0.8),
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                width: screenWidth / 1.2,
                controller: logic.emailController,
                hintText:
                    UserData.translation.data?.email?.toString() ?? 'Email',
                obscure: false,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                width: screenWidth / 1.2,
                controller: logic.subjectController,
                hintText: 'Subject',
                obscure: false,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.5,
                    color: kLightGreyColor.withOpacity(0.3),
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                width: screenWidth / 1.2,
                height: screenHeight / 4.5,
                child: TextField(
                  obscureText: false,
                  controller: logic.detailsController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Details',
                    hintStyle: TextStyle(
                        color: kLightGreyColor.withOpacity(0.8),
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () async {
                  logic.submitForm();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: screenWidth / 1.2,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(15),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.phone,
                        size: 30,
                        color: kLightGreyColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '+92252224',
                        style: TextStyle(color: kLightGreyColor, fontSize: 15),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.language,
                        size: 30,
                        color: kLightGreyColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '+92252224',
                        style: TextStyle(color: kLightGreyColor, fontSize: 15),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 30,
                        color: kLightGreyColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Lorem ipsum',
                        style: TextStyle(color: kLightGreyColor, fontSize: 15),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
