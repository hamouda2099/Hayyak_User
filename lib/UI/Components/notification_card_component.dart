import 'package:flutter/material.dart';
import 'package:hayyak/main.dart';

import '../../Config/constants.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      width: screenWidth / 1.2,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: kPrimaryColor.withOpacity(
            0.2,
          ),
          spreadRadius: 1,
          blurRadius: 2,
        ),
      ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: screenWidth / 1.5,
            child: Text(
              'The big night for Amr Diab The big night for Amr Diab '
              ' The big night for Amr Diab',
              maxLines: 5,
              style: TextStyle(
                color: kDarkGreyColor,
                fontSize: 10,
              ),
            ),
          ),
          Container(
            width: screenWidth / 5,
            height: screenWidth / 5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                  image: AssetImage('assets/images/amr-diab-promo.jpg')),
            ),
          ),
        ],
      ),
    );
  }
}
