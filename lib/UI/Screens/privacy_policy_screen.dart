import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hayyak/Dialogs/loading_screen.dart';
import 'package:hayyak/Logic/Services/api_manger.dart';
import 'package:hayyak/Models/faqs_model.dart';
import 'package:hayyak/Models/privacy_policy_model.dart';
import 'package:hayyak/UI/Components/faq_component.dart';
import 'package:hayyak/UI/Components/seccond_app_bar.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              SecondAppBar(title: 'Privacy Policy', shareAndFav: false, backToHome: false),
              FutureBuilder<PrivacyPolicyModel>(
                future: ApiManger.getPrivacyPolicy(),
                builder: (BuildContext context, AsyncSnapshot<PrivacyPolicyModel> snapShot) {
                  switch (snapShot.connectionState) {
                    case ConnectionState.waiting:
                      {
                        return ScreenLoading();
                      }
                    default:
                      if (snapShot.hasError) {
                        return Text('Error: ${snapShot.error}');
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: HtmlWidget(

                              snapShot.data?.data?.aboutDescription ??
                                  '')
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
