import 'package:flutter/material.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/main.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewer extends StatelessWidget {
  ImageViewer({required this.url});

  String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: kDarkGreyColor,
            )),
      ),
      body: SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: PhotoView(
          backgroundDecoration: const BoxDecoration(color: Colors.white),
          imageProvider: NetworkImage(url),
        ),
      ),
    );
  }
}
