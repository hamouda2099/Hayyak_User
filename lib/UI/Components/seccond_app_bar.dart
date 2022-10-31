import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/UI/Screens/notifications_screen.dart';
import 'package:hayyak/main.dart';

class SecondAppBar extends StatelessWidget {
  SecondAppBar({required this.title});
  String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset(
                color: kDarkGreyColor,
                width: 25, height: 25, 'assets/icon/back.svg'),
          ),
          Text(
            title,
            style: TextStyle(color: kDarkGreyColor, fontSize: 16),
          ),
          IconButton(
            onPressed: () {
              navigator(context: context, screen: NotificationsScreen());
            },
            icon: Icon(Icons.notifications),
            color: kDarkGreyColor,
            iconSize: 30,
          ),
        ],
      ),
    );
  }
}
