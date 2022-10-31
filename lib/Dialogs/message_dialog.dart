import 'package:flutter/material.dart';
import 'package:hayyak/Config/constants.dart';



import '../main.dart';

void messageDialog(BuildContext context, String message) {
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

      content:
        InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            Navigator.pop(context);
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
            child: const Text(
              'Ok',
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
