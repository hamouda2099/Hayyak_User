import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/date_formatter.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/Dialogs/message_dialog.dart';
import 'package:hayyak/Logic/UI%20Logic/signUp_logic.dart';
import 'package:hayyak/States/providers.dart';
import 'package:hayyak/UI/Components/text_field.dart';
import 'package:hayyak/UI/Screens/home_screen.dart';
import 'package:hayyak/UI/Screens/login_screen.dart';
import 'package:hayyak/main.dart';

import '../../Config/user_data.dart';
import '../Components/box_shadow.dart';

// ignore: must_be_immutable
class SignUpScreen extends StatelessWidget {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  final genderProvider = StateProvider<String?>((ref) => null);
  List gender = ['Male', 'Female'];
  DateTime? selectedDate = DateTime(2018);

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
                        hintText:
                            UserData.translation.data?.firstName?.toString() ??
                                'First',
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
                        hintText:
                            UserData.translation.data?.lastName?.toString() ??
                                'Last',
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
              controller: emailController,
              hintText: UserData.translation.data?.email?.toString() ?? 'Email',
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
                          initialDate: DateTime.now(),
                          //get today's date
                          firstDate: DateTime(2000),
                          //DateTime.now() - not to allow to choose before today.
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
              builder: (context, ref, child) {
                final value = ref.watch(genderProvider);
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
                      ref.refresh(genderProvider.notifier).state =
                          '${newValue}';
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
              width: screenWidth / 1.2,
              controller: passwordController,
              hintText:
                  UserData.translation.data?.password?.toString() ?? 'Password',
              obscure: true,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              width: screenWidth / 1.2,
              controller: confirmPasswordController,
              hintText:
                  UserData.translation.data?.confirmPassword?.toString() ??
                      'Confirm Password',
              obscure: true,
            ),
            Consumer(
              builder: (context, ref, child) {
                final termsAndConditions =
                    ref.watch(termsAndConditionsProvider);
                return Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (termsAndConditions == false) {
                            ref
                                .read(termsAndConditionsProvider.notifier)
                                .state = true;
                          } else {
                            ref
                                .read(termsAndConditionsProvider.notifier)
                                .state = false;
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
                        UserData.translation.data?.acceptAllTermsAndConditions
                                ?.toString() ??
                            'Accept all',
                        style: TextStyle(
                            color: kDarkGreyColor.withOpacity(0.6),
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          UserData.translation.data?.termsAndConditions
                                  ?.toString() ??
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
            Consumer(
              builder: (context, ref, child) {
                return InkWell(
                  onTap: () async {
                    // login function
                    if (ref.read(termsAndConditionsProvider.notifier).state) {
                      SignUpLogic.signUp(
                          context: context,
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          phone: phoneController.text,
                          email: emailController.text,
                          dateOfBirth: dateOfBirthController.text,
                          password: passwordController.text,
                          confirmPassword: confirmPasswordController.text,
                          gender:
                              ref.read(genderProvider.notifier).state == 'Male'
                                  ? '1'
                                  : '2');
                    } else {
                      messageDialog(context, 'Check terms and conditions');
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
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: screenWidth / 1.2,
              margin: const EdgeInsets.only(top: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      SignUpLogic().signUpWithGoogle(context: context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: boxShadow),
                      child: SvgPicture.asset(
                          width: 30,
                          height: 30,
                          'assets/icon/Icon awesome-google.svg'),
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: boxShadow),
                    child: const Icon(
                      Icons.apple,
                      color: Colors.black,
                      size: 40,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: boxShadow),
                    child: SvgPicture.asset(
                        width: 30, height: 30, 'assets/icon/facebook.svg'),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  UserData.translation.data?.alreadyMember?.toString() ??
                      'Already a member',
                  style: TextStyle(
                      color: kDarkGreyColor.withOpacity(0.6),
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () {
                    navigator(
                        context: context,
                        screen: LoginScreen(
                          screen: HomeScreen(),
                        ));
                  },
                  child: Text(
                    UserData.translation.data?.signIn?.toString() ??
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
