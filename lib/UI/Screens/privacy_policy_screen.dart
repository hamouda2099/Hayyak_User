import 'package:flutter/material.dart';
// import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hayyak/Dialogs/loading_screen.dart';
import 'package:hayyak/Logic/Services/api_manger.dart';
import 'package:hayyak/Models/privacy_policy_model.dart';
import 'package:html_widget/html_widget.dart';

import '../../Config/constants.dart';
import '../../Config/user_data.dart';

class PrivacyPolicy extends StatelessWidget {
  List<Widget> _outputHtml = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            UserData.translation.data?.privacyPolicy?.toString() ??
                'Privacy Policy',
            style: TextStyle(
                color: kDarkGreyColor,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: kLightGreyColor,
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              FutureBuilder<PrivacyPolicyModel>(
                future: ApiManger.getPrivacyPolicy(),
                builder: (BuildContext context,
                    AsyncSnapshot<PrivacyPolicyModel> snapShot) {
                  switch (snapShot.connectionState) {
                    case ConnectionState.waiting:
                      {
                        return ScreenLoading();
                      }
                    default:
                      if (snapShot.hasError) {
                        return Text(UserData
                                .translation.data?.noInternetConnection
                                ?.toString() ??
                            'Error: ${snapShot.error}');
                      } else {
                        _outputHtml = MyHtmlParser.parseHtmlToListOfTextWidgets(
                            snapShot.data?.data?.aboutDescription);
                        return Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.all(10),
                            itemCount: _outputHtml.length,
                            itemBuilder: (context, index) {
                              return _outputHtml.elementAt(index);
                            },
                          ),
                        );
                      }
                  }
                },
              ),
            ],
          ),
        ));
  }
}
