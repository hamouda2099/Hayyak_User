import 'package:flutter/material.dart';
// import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hayyak/Dialogs/loading_screen.dart';
import 'package:hayyak/Logic/Services/api_manger.dart';
import 'package:hayyak/Models/privacy_policy_model.dart';
import 'package:hayyak/UI/Components/seccond_app_bar.dart';
import 'package:html_widget/html_widget.dart';

import '../../Config/user_data.dart';

class PrivacyPolicy extends StatelessWidget {
  List<Widget> _outputHtml = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          SecondAppBar(
              title: UserData.translation.data?.privacyPolicy?.toString() ??
                  'Privacy Policy',
              shareAndFav: false,
              backToHome: false),
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
                    return Text('Error: ${snapShot.error}');
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
