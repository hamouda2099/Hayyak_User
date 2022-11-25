import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/main.dart';

class AppBarCustom extends AppBar {
  AppBarCustom({required this.pageName, required this.context});
  String pageName;
  BuildContext context;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        pageName,
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: SvgPicture.asset(
            color: kDarkGreyColor,
            width: 25,
            height: 25,
            'assets/icon/back.svg'),
      ),
    );
  }
}
