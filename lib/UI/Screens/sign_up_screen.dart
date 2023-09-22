import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/Dialogs/message_dialog.dart';
import 'package:hayyak/Logic/UI%20Logic/signUp_logic.dart';
import 'package:hayyak/States/providers.dart';
import 'package:hayyak/UI/Components/text_field.dart';
import 'package:hayyak/UI/Screens/home_screen.dart';
import 'package:hayyak/UI/Screens/login_screen.dart';
import 'package:hayyak/UI/Screens/terms_and_conditions_screen.dart';
import 'package:hayyak/main.dart';

import '../../Config/user_data.dart';

// ignore: must_be_immutable
class SignUpScreen extends StatelessWidget {
  SignUpLogic logic = SignUpLogic();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          UserData.translation.data?.signUp?.toString() ?? 'SIGN UP',
          style: TextStyle(
              color: kDarkGreyColor, fontWeight: FontWeight.bold, fontSize: 20),
        ),
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
        child: Form(
          key: logic.formKey,
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
                      child: TextFormField(
                        controller: logic.firstNameController,
                        validator: (val) {
                          if (logic.firstNameController.text.isEmpty) {
                            return UserData
                                    .translation.data?.thisFieldIsRequired
                                    ?.toString() ??
                                'This field is required';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: UserData.translation.data?.firstName
                                  ?.toString() ??
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
                      child: TextFormField(
                        validator: (val) {
                          if (logic.lastNameController.text.isEmpty ??
                              ''.isEmpty) {
                            return UserData
                                    .translation.data?.thisFieldIsRequired
                                    ?.toString() ??
                                'This field is required';
                          } else {
                            return null;
                          }
                        },
                        controller: logic.lastNameController,
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
                controller: logic.emailController,
                validator: (val) {
                  Pattern pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regex = RegExp(pattern.toString());
                  if (!regex.hasMatch(val ?? '') &&
                      logic.emailController.text.isNotEmpty) {
                    return UserData.translation.data?.mainVaildation
                            ?.toString() ??
                        'Email should contain @ ex: mail@hayyak.com';
                  } else {
                    return null;
                  }
                },
                hintText:
                    UserData.translation.data?.email?.toString() ?? 'Email',
                obscure: false,
              ),
              const SizedBox(
                height: 10,
              ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Container(
                  width: screenWidth / 1.2,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 0.5,
                      color: kLightGreyColor.withOpacity(0.3),
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        width: screenWidth / 2.5,
                        child: TextFormField(
                          controller: logic.phoneController,
                          validator: (val) {
                            if (logic.phoneController.text.isEmpty ??
                                ''.isEmpty) {
                              return UserData
                                      .translation.data?.thisFieldIsRequired
                                      ?.toString() ??
                                  'This field is required';
                            } else {
                              if ((val ?? "").length < 9) {
                                return UserData.translation.data?.phone
                                        ?.toString() ??
                                    'Phone must be of 9 digit';
                              } else {
                                return null;
                              }
                            }
                          },
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
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime(DateTime.now().year - 18),
                      firstDate: DateTime(DateTime.now().year - 100),
                      lastDate: DateTime(DateTime.now().year - 12));
                  logic.dateOfBirthController.text =
                      '${pickedDate!.day < 10 ? '0' : ''}${pickedDate?.day}-${pickedDate!.month < 10 ? '0' : ''}${pickedDate.month}-${pickedDate?.year}';
                },
                child: Container(
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
                    enabled: false,
                    controller: logic.dateOfBirthController,
                    decoration: InputDecoration(
                      hintText: 'dd-mm-yy',
                      suffixIcon: IconButton(
                        onPressed: () async {},
                        icon: const Icon(
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
              ),
              const SizedBox(
                height: 10,
              ),
              Consumer(
                builder: (context, ref, child) {
                  final value = ref.watch(logic.genderProvider);
                  return Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          width: 0.5,
                          color: kLightGreyColor.withOpacity(0.3),
                        )),
                    width: screenWidth / 1.2,
                    child: DropdownButton(
                      underline: const SizedBox(),
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
                        ref.refresh(logic.genderProvider.notifier).state =
                            '${newValue}';
                      },
                      items: logic.gender.map((location) {
                        return DropdownMenuItem(
                          value: location,
                          child: Text(
                            location == 'Male' && localLanguage == 'ar'
                                ? 'ذكر'
                                : location == 'Female' && localLanguage == 'ar'
                                    ? 'أنثي'
                                    : location.toString(),
                            style: TextStyle(
                                color: kLightGreyColor.withOpacity(0.8),
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
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
                validator: (val) {
                  if (logic.passwordController.text.isEmpty ?? ''.isEmpty) {
                    return UserData.translation.data?.thisFieldIsRequired
                            ?.toString() ??
                        'This field is required';
                  } else {
                    return null;
                  }
                },
                width: screenWidth / 1.2,
                controller: logic.passwordController,
                hintText: UserData.translation.data?.password?.toString() ??
                    'Password',
                obscure: true,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                validator: (val) {
                  if (logic.lastNameController.text.isEmpty ?? ''.isEmpty) {
                    return UserData.translation.data?.thisFieldIsRequired
                            ?.toString() ??
                        'This field is required';
                  } else {
                    return null;
                  }
                },
                width: screenWidth / 1.2,
                controller: logic.confirmPasswordController,
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
                                  color: kPrimaryColor,
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
                        SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () {
                            navigator(
                                context: context,
                                screen: TermsAndConditionsScreen());
                          },
                          child: Text(
                            UserData.translation.data?.termsAndConditions
                                    ?.toString() ??
                                ' terms & conditions',
                            style: const TextStyle(
                                color: kPrimaryColor,
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
                      if (logic.formKey.currentState?.validate() ?? false) {
                        if (ref
                            .read(termsAndConditionsProvider.notifier)
                            .state) {
                          SignUpLogic.signUp(
                              signType: 'normal',
                              context: context,
                              firstName: logic.firstNameController.text,
                              lastName: logic.lastNameController.text,
                              phone: logic.phoneController.text,
                              email: logic.emailController.text,
                              dateOfBirth: logic.dateOfBirthController.text,
                              password: logic.passwordController.text,
                              confirmPassword:
                                  logic.confirmPasswordController.text,
                              gender: ref
                                          .read(logic.genderProvider.notifier)
                                          .state ==
                                      'Male'
                                  ? '1'
                                  : '2');
                        } else {
                          messageDialog(context, 'Check terms and conditions');
                        }
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: screenWidth / 1.2,
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        UserData.translation.data?.signUp?.toString() ??
                            'SIGN UP',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  logic.googleSignUp(context: context);
                },
                child: Container(
                    width: screenWidth / 1.2,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(100)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                            color: Colors.white,
                            width: 30,
                            height: 30,
                            'assets/icon/Icon awesome-google.svg'),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          UserData.translation.data?.signUpWithGoogle
                                  ?.toString() ??
                              'Sign up with google account',
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )
                      ],
                    )),
              ),
              const SizedBox(
                height: 30,
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
                  SizedBox(
                    width: 5,
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
                      style: const TextStyle(
                          color: kPrimaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
