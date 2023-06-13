import 'package:flutter/material.dart';
import 'package:hayyak/main.dart';

import '../../Logic/UI Logic/splash_logic.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SplashLogic().splash(context);
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
          child: Image(
        width: screenWidth / 1.5,
        image: const AssetImage('assets/images/grey_logo.png'),
      )),
    );
  }
}
