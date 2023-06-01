import 'package:flutter/material.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/UI/Screens/home_screen.dart';
import 'package:hayyak/UI/Screens/login_screen.dart';
import 'package:hive/hive.dart';

import '../main.dart';

logoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Center(
          child: Text(
            'Do you want to log out ?',
            style: TextStyle(
              color: kDarkGreyColor,
              fontSize: 16,
            ),
          ),
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                Hive.box('user_data').put('logged_in', false);
                navigator(
                    context: context,
                    screen: LoginScreen(
                      screen: HomeScreen(),
                    ),
                    remove: true);
              },
              child: Container(
                alignment: Alignment.center,
                width: screenWidth / 4,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(5),
                child: const Text(
                  'Ok',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                alignment: Alignment.center,
                width: screenWidth / 4,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: kPrimaryColor)),
                padding: const EdgeInsets.all(5),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
