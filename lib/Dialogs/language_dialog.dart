import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/Dialogs/loading_dialog.dart';
import 'package:hayyak/main.dart';
import 'package:hive/hive.dart';

import '../Config/user_data.dart';

void languageDialog({
  required BuildContext context,
  required Widget screen,
}) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      backgroundColor: Colors.white,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Change Language'.tr(),
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
              fontSize: screenWidth / 15,
            ),
          ),
          SizedBox(
            height: screenHeight / 20,
            child: const Divider(color: kPrimaryColor),
          ),
          InkWell(
            onTap: () async {
              loadingDialog(context);
              Hive.box('user_data').put('lang', 'en');
              localLanguage = 'en';
              context.setLocale(const Locale('en'));
              Navigator.pop(context);
              navigator(
                context: context,
                replacement: true,
                screen: screen,
              );
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                children: [
                  Text(
                    'English'.tr(),
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: screenWidth / 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: screenHeight / 30,
          ),
          InkWell(
            onTap: () async {
              loadingDialog(context);
              Hive.box('user_data').put('lang', 'ar');
              localLanguage = 'ar';
              context.setLocale(const Locale('ar'));
              Navigator.pop(context);
              navigator(
                context: context,
                replacement: true,
                screen: screen,
              );
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 10,
              ),
              child: Row(
                children: [
                  Text(
                    'Arabic'.tr(),
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: screenWidth / 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
