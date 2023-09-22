import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/Config/user_data.dart';
import 'package:hayyak/UI/Screens/home_screen.dart';
import 'package:share/share.dart';

import '../../Dialogs/loading_dialog.dart';
import '../../Dialogs/message_dialog.dart';
import '../../Logic/Services/api_manger.dart';
// import 'package:share/share.dart';

class SecondAppBar extends StatelessWidget {
  SecondAppBar(
      {required this.title,
      required this.shareAndFav,
      required this.backToHome,
      this.eventIsFav,
      this.eventId});

  String title;
  String? eventId;
  bool shareAndFav = false;
  bool? eventIsFav = false;
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
                  localLanguage == 'en'
                      ? 'assets/icon/back.svg'
                      : 'assets/icon/back_ar.svg'),
            ),
          ),
          Text(
            title,
            style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                color: kDarkGreyColor,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          shareAndFav || UserData.token == ''
              ? Row(
                  children: [
                    Padding(
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
                    ),
                    InkWell(
                      onTap: () {
                        if (UserData.id == null) {
                          messageDialog(
                              context,
                              UserData.translation.data?.pleaseLoginFirst
                                      ?.toString() ??
                                  'Please Login to Add to Favourites !');
                        } else {
                          if (eventIsFav ?? false) {
                            loadingDialog(context);
                            ApiManger.removeFromFav(id: eventId.toString())
                                .then((value) {
                              Navigator.pop(context);
                              if (value['success']) {
                                navigator(
                                    context: context,
                                    screen: HomeScreen(),
                                    replacement: true);
                              } else {
                                messageDialog(context, 'An error occurred');
                              }
                            });
                          } else {
                            loadingDialog(context);
                            ApiManger.addToFav(eventId: eventId.toString())
                                .then((value) {
                              Navigator.pop(context);
                              if (value['success']) {
                                navigator(
                                    context: context,
                                    screen: HomeScreen(),
                                    replacement: true);
                              } else {
                                messageDialog(context, 'An Error Occurred');
                              }
                            });
                          }
                        }
                      },
                      child: (eventIsFav ?? false)
                          ? Padding(
                              padding: EdgeInsets.only(left: 1.0, right: 1),
                              child: SvgPicture.asset(
                                  color: kLightGreyColor,
                                  width: 20,
                                  height: 20,
                                  'assets/icon/solid_heart.svg'),
                            )
                          : Padding(
                              padding: EdgeInsets.only(left: 1.0, right: 1),
                              child: SvgPicture.asset(
                                  color: kLightGreyColor,
                                  width: 13,
                                  height: 13,
                                  'assets/icon/Icon feather-heart.svg'),
                            ),
                    )
                  ],
                )
              : const SizedBox(
                  width: 50,
                )
        ],
      ),
    );
  }
}
