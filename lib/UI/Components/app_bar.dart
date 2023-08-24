import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/UI/Screens/settings_screen.dart';
import 'package:hayyak/main.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () {
              navigator(context: context, screen: SettingsScreen());
            },
            icon: SizedBox(
              width: 20,
              height: 20,
              child: SvgPicture.asset(
                color: kDarkGreyColor,
                'assets/icon/profile.svg',
              ),
            ),
          ),
          Image(
              width: screenWidth / 4,
              image: AssetImage('assets/images/grey_logo.png')),
          SizedBox(
            width: 40,
          ),
        ],
      ),
    );
  }
}
