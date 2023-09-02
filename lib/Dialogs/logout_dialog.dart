import 'package:flutter/material.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/Config/user_data.dart';
import 'package:hayyak/UI/Screens/home_screen.dart';
import 'package:hayyak/UI/Screens/login_screen.dart';
import 'package:hive/hive.dart';

import '../main.dart';

logoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Center(
          child: Text(
            UserData.translation.data?.doYouWantToLogOut?.toString() ??
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
                UserData.id = null;
                UserData.token = '';
                UserData.email = '';
                UserData.userName = '';
                UserData.phone = '';
                UserData.role = '';
                UserData.imageUrl = '';
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
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(5),
                child: Text(
                  UserData.translation.data?.ok?.toString() ?? 'Ok',
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
                child: Text(
                  UserData.translation.data?.cancel?.toString() ?? 'Cancel',
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
