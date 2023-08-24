import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/Config/user_data.dart';
import 'package:hayyak/UI/Screens/home_screen.dart';
import 'package:share/share.dart';
// import 'package:share/share.dart';

class SecondAppBar extends StatelessWidget {
  SecondAppBar(
      {required this.title,
      required this.shareAndFav,
      required this.backToHome,
      this.eventId});

  String title;
  String? eventId;
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
                  localLanguage == 'ar'
                      ? 'assets/icon/back_ar.svg'
                      : 'assets/icon/back.svg'),
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
              ? Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: InkWell(
                      onTap: () {
                        Share.share(
                            'https://hayyak.net/$localLanguage/event/$eventId',
                            subject: title);
                      },
                      child: const Icon(
                        Icons.file_upload_outlined,
                        size: 20,
                        color: kDarkGreyColor,
                      )),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
