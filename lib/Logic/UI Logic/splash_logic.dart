import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import '../../Config/constants.dart';
import '../../Config/navigator.dart';
import '../../Config/user_data.dart';
import '../../UI/Screens/home_screen.dart';
import '../../UI/Screens/welcome_screen.dart';
import '../Services/api_manger.dart';

class SplashLogic {
  void splash(BuildContext context) {
    ApiManger.getSettings().then((value) {
      UserData.settings = value;
      UserData.settings.data?.forEach((element) {
        if (element.key == 'reservation_timer') {
          UserData.reservationTimer = int.parse(element.value.toString());
        }
        if (element.key == 'moyasar_publishable_key') {
          UserData.moyasarPublishableKey = element.value;
        }
        if (element.key == 'moyasar_secret_key') {
          UserData.moyasarSecretKey = element.value;
        }
      });
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
          UserData.language = await Hive.box('user_data').get('lang');
          localLanguage = UserData.language ?? 'en';
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
}
