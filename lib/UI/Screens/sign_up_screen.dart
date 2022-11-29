import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/date_formatter.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/Dialogs/message_dialog.dart';
import 'package:hayyak/Logic/UI%20Logic/login_logic.dart';
import 'package:hayyak/Logic/UI%20Logic/signUp_logic.dart';
import 'package:hayyak/States/providers.dart';
import 'package:hayyak/UI/Components/text_field.dart';
import 'package:hayyak/UI/Screens/login_screen.dart';
import 'package:hayyak/main.dart';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class SignUpScreen extends StatelessWidget {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  final genderProvider = StateProvider<String>((ref) => 'Male');
  DateTime? selectedDate = DateTime(2018);
  List gender = ['Male', 'Female'];
  SignUpScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: kLightGreyColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Image(
              width: screenWidth / 2,
              image: const AssetImage('assets/images/grey_logo.png'),
            ),
            const SizedBox(
              height: 20,
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
                    width: screenWidth / 2.5,
                    child: TextField(
                      controller: firstNameController,
                      decoration: InputDecoration(
                        hintText: 'First',
                        hintStyle: TextStyle(
                            color: kLightGreyColor.withOpacity(0.8),
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
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
                      controller: lastNameController,
                      decoration: InputDecoration(
                        hintText: 'Last',
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
              controller: emailController,
              hintText: 'Email',
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
                      controller: phoneController,
                      decoration: InputDecoration(
                        hintText: 'Phone',
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
            Container(
              padding: const EdgeInsets.all(5),
              width: screenWidth / 1.2,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 0.5,
                  color: kLightGreyColor.withOpacity(0.3),
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextField(
                controller: dateOfBirthController,
                decoration: InputDecoration(
                  hintText: 'dd/mm/yy',
                  suffixIcon: IconButton(
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(), //get today's date
                          firstDate: DateTime(
                              2000), //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2101));
                      dateOfBirthController.text =
                          dateFormatter(pickedDate.toString());
                    },
                    icon: Icon(
                      Icons.calendar_month,
                      color: kLightGreyColor,
                    ),
                  ),
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
            Consumer(
              builder: (context, watch, child) {
                final value = watch(genderProvider).state;
                return Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        width: 0.5,
                        color: kLightGreyColor.withOpacity(0.3),
                      )),
                  width: screenWidth / 1.2,
                  child: DropdownButton(
                    underline: SizedBox(),
                    isExpanded: true,
                    iconSize: 20,
                    icon: Icon(
                      Icons.arrow_drop_down_circle_rounded,
                      color: Colors.black.withOpacity(0.5),
                    ),
                    value: value,
                    hint: const Text(
                      'Select Gender',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    onChanged: (newValue) {
                      context.refresh(genderProvider).state = '${newValue}';
                    },
                    items: gender.map((location) {
                      return DropdownMenuItem(
                        child: Text(
                          location,
                          style: TextStyle(
                              color: kLightGreyColor.withOpacity(0.8),
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        value: location,
                      );
                    }).toList(),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              controller: passwordController,
              hintText: 'Password',
              obscure: true,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              controller: confirmPasswordController,
              hintText: 'Confirm Password',
              obscure: true,
            ),
            Consumer(
              builder: (context, watch, child) {
                final termsAndConditions =
                    watch(termsAndConditionsProvider).state;
                return Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (termsAndConditions == false) {
                            context.read(termsAndConditionsProvider).state =
                                true;
                          } else {
                            context.read(termsAndConditionsProvider).state =
                                false;
                          }
                        },
                        icon: termsAndConditions == false
                            ? const Icon(
                                Icons.check_box_outline_blank_sharp,
                                color: Colors.grey,
                                size: 18,
                              )
                            : const Icon(
                                Icons.check_box,
                                color: Colors.blue,
                                size: 18,
                              ),
                      ),
                      Text(
                        'Accept all',
                        style: TextStyle(
                            color: kDarkGreyColor.withOpacity(0.6),
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                      InkWell(
                        onTap: () {},
                        child: const Text(
                          ' terms & conditions',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () async {
                // login function
                bool result = await InternetConnectionChecker().hasConnection;
                if (result == true) {
                  if (context.read(termsAndConditionsProvider).state) {
                    SignUpLogic.signUp(
                        context: context,
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        phone: phoneController.text,
                        email: emailController.text,
                        dateOfBirth: dateOfBirthController.text,
                        password: passwordController.text,
                        confirmPassword: confirmPasswordController.text,
                        gender: context.read(genderProvider).state == 'Male'
                            ? '1'
                            : '2');
                  } else {
                    messageDialog(context, 'Check terms and conditions');
                  }
                } else {
                  messageDialog(context, 'Check Internet Connection !');
                }
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
                  'SIGN UP',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already a member',
                  style: TextStyle(
                      color: kDarkGreyColor.withOpacity(0.6),
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () {
                    navigator(context: context, screen: LoginScreen());
                  },
                  child: const Text(
                    ' Sign in.',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
