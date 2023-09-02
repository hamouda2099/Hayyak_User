import 'package:flutter/material.dart';
import 'package:hayyak/Config/constants.dart';

import '../Config/user_data.dart';
import '../main.dart';

void messageDialog(BuildContext context, String message, {Function? function}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Center(
        child: Text(
          message,
          style: const TextStyle(
            color: kDarkGreyColor,
            fontSize: 14,
          ),
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      content: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: function == null
            ? () {
                Navigator.pop(context);
              }
            : () {
                function();
              },
        child: Container(
          alignment: Alignment.center,
          width: screenWidth / 1,
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
    ),
  );
}
