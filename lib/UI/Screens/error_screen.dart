import 'package:flutter/material.dart';
import 'package:hayyak/Config/constants.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhiteColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Image(
              image: AssetImage('assets/images/error.png'),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Page Not Found',
              style: TextStyle(
                color: kDarkGreyColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Slow or no internet connection',
              style: TextStyle(
                color: kDarkGreyColor,
                fontSize: 14,
              ),
            )
          ],
        ));
  }
}
