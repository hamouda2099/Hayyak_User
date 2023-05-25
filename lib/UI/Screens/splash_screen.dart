import 'package:flutter/material.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/Config/user_data.dart';
import 'package:hayyak/Logic/Services/api_manger.dart';
import 'package:hayyak/UI/Screens/home_screen.dart';
import 'package:hayyak/UI/Screens/login_screen.dart';
import 'package:hayyak/UI/Screens/welcome_screen.dart';
import 'package:hayyak/main.dart';

import 'package:hive/hive.dart';

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
    ApiManger.getSettings().then((value){
      UserData.settings = value;
      UserData.settings.data?.forEach((element) {
        if (element.key == 'reservation_timer'){
          UserData.reservationTimer = int.parse(element.value.toString());
        }
        if(element.key == 'vat'){
          UserData.vat = int.parse(element.value.toString());
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
          localLanguage = UserData.language;
          navigator(context: context, screen: HomeScreen(), remove: true);
        } else {
          ApiManger.getTranslationsKeys().then((value) {
            print(value.data!.toJson());
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
