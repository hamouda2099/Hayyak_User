import 'package:flutter/material.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/main.dart';
import 'package:html_widget/html_widget.dart';

void staticServicesInfoDialog(
    BuildContext context, String service, String info) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
        title: Center(
          child: Text(
            service,
            style: const TextStyle(
              color: kDarkGreyColor,
              fontSize: 14,
            ),
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        content: Container(
          width: screenWidth / 1.5,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: MyHtmlParser.parseHtmlToListOfTextWidgets(info).length,
            itemBuilder: (context, index) {
              return MyHtmlParser.parseHtmlToListOfTextWidgets(info)[index];
            },
          ),
        )),
  );
}
