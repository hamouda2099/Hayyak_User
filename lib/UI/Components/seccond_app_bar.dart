import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/Config/user_data.dart';
import 'package:hayyak/UI/Screens/home_screen.dart';
import 'package:hayyak/UI/Screens/notifications_screen.dart';
import 'package:hayyak/main.dart';
import 'package:share/share.dart';

class SecondAppBar extends StatelessWidget {
  SecondAppBar(
      {required this.title,
      required this.shareAndFav,
      required this.backToHome});
  String title;
  bool shareAndFav = false;
  late bool backToHome = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              if (backToHome) {
                navigator(context: context, screen: HomeScreen());
              } else {
                Navigator.pop(context);
              }
            },
            icon: SizedBox(
              width: 15,
              height: 15,
              child: SvgPicture.asset(
                  color: kDarkGreyColor,
                  width: 25,
                  height: 25,
                  'assets/icon/back.svg'),
            ),
          ),
          Text(
            title,
            style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                color: kDarkGreyColor,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          shareAndFav || UserData.token == ''
              ? Row(
                  children: [
                    InkWell(
                        onTap: () {
                          Share.share('https://hayyak.net/', subject: title);
                        },
                        child: const Icon(
                          Icons.file_upload_outlined,
                          size: 20,
                          color: kDarkGreyColor,
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        navigator(
                            context: context,
                            screen: const NotificationsScreen());
                      },
                      child: SizedBox(
                        width: 15,
                        height: 15,
                        child: SvgPicture.asset(
                            color: kDarkGreyColor,
                            'assets/icon/Icon feather-heart.svg'),
                      ),
                    ),
                  ],
                )
              : IconButton(
                  onPressed: () {
                    navigator(context: context, screen: const NotificationsScreen());
                  },
                  icon: const Icon(Icons.notifications),
                  color: kDarkGreyColor,
                  iconSize: 25,
                ),
        ],
      ),
    );
  }
}
