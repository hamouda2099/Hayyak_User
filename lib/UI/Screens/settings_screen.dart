import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/Config/user_data.dart';
import 'package:hayyak/Dialogs/loading_dialog.dart';
import 'package:hayyak/UI/Components/box_shadow.dart';
import 'package:hayyak/UI/Screens/account_screen.dart';
import 'package:hayyak/UI/Screens/contact_us_screen.dart';
import 'package:hayyak/UI/Screens/faqs_screen.dart';
import 'package:hayyak/UI/Screens/home_screen.dart';
import 'package:hayyak/UI/Screens/login_screen.dart';
import 'package:hayyak/UI/Screens/privacy_policy_screen.dart';
import 'package:hayyak/UI/Screens/terms_and_conditions_screen.dart';
import 'package:hayyak/main.dart';
import 'package:hive/hive.dart';

import '../../Dialogs/logout_dialog.dart';
import '../../Logic/Services/api_manger.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          UserData.translation.data?.settings?.toString() ?? 'Settings',
          style: const TextStyle(
              color: kDarkGreyColor, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        leading: IconButton(
          onPressed: () {
            navigator(context: context, screen: HomeScreen());
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: kLightGreyColor,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: screenWidth / 5,
                    height: screenWidth / 5,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: kLightGreyColor, width: 1),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(UserData.imageUrl ?? '')),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(UserData.userName ?? '',
                          style: const TextStyle(
                              color: kDarkGreyColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold)),
                      Text(UserData.email ?? '',
                          style: const TextStyle(
                              color: kDarkGreyColor, fontSize: 12)),
                    ],
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  navigator(context: context, screen: const AccountScreen());
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  width: screenWidth / 1.1,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: boxShadow),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          UserData.translation.data?.account?.toString() ??
                              'Account',
                          style: TextStyle(
                              color: kLightGreyColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold)),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: kDarkGreyColor,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  loadingDialog(context);
                  if (localLanguage == 'en') {
                    localLanguage = 'ar';
                    UserData.language = "ar";
                    context.setLocale(const Locale('ar'));
                    textDirection = ui.TextDirection.rtl;
                    Hive.box('user_data').put('lang', "ar");
                    ApiManger.getTranslationsKeys().then((value) async {
                      Navigator.pop(context);
                      if (value.success ?? false) {
                        UserData.translation = value;
                        navigator(
                          context: context,
                          replacement: true,
                          screen: HomeScreen(),
                        );
                      } else {
                        UserData.translation =
                            await Hive.box('user_data').get('translation');
                      }
                    });
                  } else {
                    localLanguage = 'en';
                    UserData.language = "en";
                    context.setLocale(const Locale('en'));
                    textDirection = ui.TextDirection.ltr;
                    Hive.box('user_data').put('lang', "en");
                    ApiManger.getTranslationsKeys().then((value) async {
                      Navigator.pop(context);
                      if (value.success ?? false) {
                        UserData.translation = value;
                        navigator(
                          context: context,
                          replacement: true,
                          screen: HomeScreen(),
                        );
                      } else {
                        UserData.translation =
                            await Hive.box('user_data').get('translation');
                      }
                    });
                  }
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  width: screenWidth / 1.1,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: boxShadow),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(localLanguage == 'ar' ? "English" : 'العربية',
                          style: const TextStyle(
                              color: kLightGreyColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold)),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: kDarkGreyColor,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  navigator(context: context, screen: const FAQsScreen());
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  width: screenWidth / 1.1,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: boxShadow),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          UserData.translation.data?.faqs?.toString() ?? 'FAQs',
                          style: TextStyle(
                              color: kLightGreyColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold)),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: kDarkGreyColor,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  navigator(context: context, screen: PrivacyPolicy());
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  width: screenWidth / 1.1,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: boxShadow),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          UserData.translation.data?.privacyPolicy
                                  ?.toString() ??
                              'Privacy & Policy',
                          style: TextStyle(
                              color: kLightGreyColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold)),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: kDarkGreyColor,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  navigator(
                      context: context, screen: TermsAndConditionsScreen());
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  width: screenWidth / 1.1,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: boxShadow),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          UserData.translation.data?.termsAndConditions
                                  ?.toString() ??
                              'Terms & Conditions',
                          style: TextStyle(
                              color: kLightGreyColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold)),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: kDarkGreyColor,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  navigator(context: context, screen: ContactUsScreen());
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  width: screenWidth / 1.1,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: boxShadow),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          UserData.translation.data?.contactUs?.toString() ??
                              'Contact us',
                          style: TextStyle(
                              color: kLightGreyColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold)),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: kDarkGreyColor,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
              UserData.token == ''
                  ? InkWell(
                      onTap: () {
                        navigator(
                            context: context,
                            screen: LoginScreen(screen: SettingsScreen()));
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        width: screenWidth / 1.1,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: kLightGreyColor, width: 1)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.login,
                              color: kDarkGreyColor,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                                UserData.translation.data?.signIn?.toString() ??
                                    'Log In Now',
                                style: const TextStyle(
                                    color: kLightGreyColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        logoutDialog(context);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        width: screenWidth / 1.1,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: kLightGreyColor, width: 1)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                UserData.translation.data?.logOut?.toString() ??
                                    'Log out',
                                style: const TextStyle(
                                    color: kLightGreyColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                            const Icon(
                              Icons.logout_rounded,
                              color: kDarkGreyColor,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
