import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hayyak/UI/Screens/welcome_screen.dart';
import 'package:hayyak/main.dart';
import 'package:hive/hive.dart';

import '../../Config/constants.dart';
import '../../Config/navigator.dart';
import '../../Config/user_data.dart';
import '../../Logic/Services/api_manger.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ApiManger.getSettings().then((value) async {
      UserData.settings = value;
      UserData.settings.data?.forEach((element) {
        if (element.key == 'reservation_timer') {
          UserData.reservationTimer = int.parse(element.value.toString());
        }
      });
      UserData.language = await Hive.box('user_data').get('lang') ?? 'en';
      localLanguage = UserData.language ?? 'en';
      ApiManger.getTranslationsKeys().then((value) async {
        if (value.success ?? false) {
          UserData.translation = value;
        } else {
          UserData.translation = await Hive.box('user_data').get('translation');
        }
      });
      Future.delayed(const Duration(seconds: 4), () async {
        if (await Hive.box('user_data').get('logged_in') == true) {
          UserData.token = await Hive.box('user_data').get('token');
          UserData.id = await Hive.box('user_data').get('id');
          UserData.phone = await Hive.box('user_data').get('phone').toString();
          UserData.email = await Hive.box('user_data').get('email');
          UserData.userName = await Hive.box('user_data').get('name');
          UserData.imageUrl = await Hive.box('user_data').get('image');
          UserData.role = await Hive.box('user_data').get('role');

          if (localLanguage == 'en') {
            textDirection = ui.TextDirection.ltr;
            localLanguage = 'en';
            context.setLocale(Locale('en'));
          } else {
            textDirection = ui.TextDirection.rtl;
            localLanguage = 'ar';
            context.setLocale(const Locale('ar'));
          }
          navigator(context: context, screen: HomeScreen(), remove: true);
        } else {
          ApiManger.getTranslationsKeys().then((value) {
            UserData.translation = value;
            navigator(context: context, screen: WelcomeScreen(), remove: true);
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
          child: Image(
        width: screenWidth / 1.5,
        image: const AssetImage('assets/images/grey_logo.png'),
      )),
    );
  }
}
