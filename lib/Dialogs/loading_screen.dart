import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                )
              : CircularProgressIndicator(
                  strokeWidth: 2,
                ),
        ),
        SizedBox(
          width: 10,
        ),
        Text('برجاء الإنتظار...'),
      ],
    );
  }
}
