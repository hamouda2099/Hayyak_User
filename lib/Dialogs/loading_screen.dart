import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hayyak/Config/constants.dart';

class ScreenLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 20,
          height: 20,
          // TODO maybe need to change cupertino radius.
          child: Platform.isIOS
              ? CupertinoActivityIndicator(
                  radius: 10,
                  color: kPrimaryColor,
                )
              : CircularProgressIndicator(
                  strokeWidth: 2,
                  color: kPrimaryColor,
                ),
        ),
      ],
    );
  }
}
