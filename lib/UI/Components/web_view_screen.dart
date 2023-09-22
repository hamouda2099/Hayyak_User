import 'package:flutter/material.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  WebViewScreen({required this.link});

  String link;

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  WebViewController controller = WebViewController();

  @override
  void initState() {
    controller.loadRequest(
        Uri.parse(widget.link.isEmpty ? 'https://hayyak.net' : widget.link));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // centerTitle: true,
        // title: Image(
        //     width: screenWidth / 4,
        //     image: AssetImage('assets/images/grey_logo.png')),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: kDarkGreyColor,
            )),
      ),
      body: SafeArea(
        child: WebViewWidget(
          controller: controller,
        ),
      ),
    );
  }
}
