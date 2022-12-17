import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/UI/Screens/notifications_screen.dart';
import 'package:hayyak/main.dart';
import 'package:share/share.dart';

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
            icon: SizedBox(
              width: 15,
              height: 15,
              child: SvgPicture.asset(
                  color: kDarkGreyColor,
                  width: 25, height: 25, 'assets/icon/back.svg'),
            ),
          ),
          Text(
            title,
            style: TextStyle(color: kDarkGreyColor, fontSize: 16,fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              InkWell(
                  onTap: () {
                    Share.share(
                        'https://hayyak.net/',
                        subject: title);
                  },
                  child: const Icon(
                    Icons.file_upload_outlined,
                    size: 20,
                    color: kDarkGreyColor,
                  )),
              SizedBox(width: 10,),
              InkWell(
                onTap: (){
                  navigator(context: context, screen: NotificationsScreen());
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
        ],
      ),
    );
  }
}
