import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/UI/Screens/notifications_screen.dart';
import 'package:hayyak/UI/Screens/settings_screen.dart';
import 'package:hayyak/main.dart';

import 'package:hive/hive.dart';

import '../../Dialogs/logout_dialog.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              navigator(context: context, screen: SettingsScreen());
            },
            icon: SizedBox(
              width: 15,
              height: 15,
              child: SvgPicture.asset(
                color: kDarkGreyColor,
                  'assets/icon/profile.svg',),
            ),
          ),
          Image(
              width: screenWidth / 4,
              image: AssetImage('assets/images/grey_logo.png')),
          IconButton(
            onPressed: () {
              navigator(context: context,screen: NotificationsScreen());
            },
            icon: Icon(Icons.notifications),
            color: kDarkGreyColor,
            iconSize: 20,
          ),
        ],
      ),
    );
  }
}
