import 'package:flutter/material.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/UI/Screens/home_screen.dart';
import 'package:hayyak/UI/Screens/login_screen.dart';

import '../main.dart';

void verifiedAccountDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      content: Container(
        width: screenWidth / 1.5,
        height: screenHeight / 4,
        child: Column(
          children: [
            Icon(
              Icons.verified_user,
              color: Colors.green,
              size: screenWidth / 4,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Your account is verified',
              style: TextStyle(fontSize: 15, color: kLightGreyColor),
            ),
          ],
        ),
      ),
    ),
  );
  Future.delayed(const Duration(seconds: 3), () {
    navigator(context: context, screen: LoginScreen(
       screen: HomeScreen(),
    ));
  });
}
