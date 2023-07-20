import 'package:flutter/material.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/UI/Screens/contact_us_screen.dart';
import 'package:hayyak/UI/Screens/home_screen.dart';
import 'package:hayyak/UI/Screens/login_screen.dart';
import 'package:hayyak/main.dart';

import '../../Config/user_data.dart';

// ignore: must_be_immutable
class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkGreyColor,
      body: SingleChildScrollView(
        child: Container(
          width: screenWidth,
          height: screenHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHeight / 3,
              ),
              Image(
                width: screenWidth / 1.5,
                image: const AssetImage('assets/images/white_logo.png'),
              ),
              SizedBox(
                height: screenHeight / 4,
              ),
              InkWell(
                onTap: () async {
                  navigator(
                      context: context,
                      screen: LoginScreen(
                        screen: HomeScreen(),
                      ));
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
                    UserData.translation.data?.signIn
                            ?.toString()
                            .toUpperCase() ??
                        'SIGN IN',
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
              InkWell(
                onTap: () async {
                  navigator(context: context, screen: ContactUsScreen());
                },
                child: Container(
                  alignment: Alignment.center,
                  width: screenWidth / 1.2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    UserData.translation.data?.contactUs
                            ?.toString()
                            .toUpperCase() ??
                        'CONTACT US',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: kDarkGreyColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  navigator(
                    context: context,
                    screen: HomeScreen(),
                  );
                },
                child: Text(
                  UserData.translation.data?.skip?.toString() ?? 'Skip',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
