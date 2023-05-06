import 'package:flutter/material.dart';
import 'package:hayyak/Dialogs/loading_screen.dart';
import 'package:hayyak/Logic/Services/api_manger.dart';
import 'package:hayyak/Models/faqs_model.dart';
import 'package:hayyak/UI/Components/faq_component.dart';
import 'package:hayyak/UI/Components/seccond_app_bar.dart';

class FAQsScreen extends StatelessWidget {
  const FAQsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          SecondAppBar(title: 'FAQs', shareAndFav: false, backToHome: true),
          FutureBuilder<FaQsModel>(
            future: ApiManger.getFAQs(),
            builder: (BuildContext context, AsyncSnapshot<FaQsModel> snapShot) {
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
                      child: Column(
                        children: List.generate(
                            snapShot.data!.data!.length,
                            (index) => FAQItem(
                                  question: snapShot.data!.data![index].qName
                                      .toString(),
                                  answer: snapShot.data!.data![index].qAnswer
                                      .toString(),
                                )),
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
