import 'package:flutter/material.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/Logic/UI%20Logic/signUp_logic.dart';
import 'package:hayyak/UI/Components/text_field.dart';
import 'package:hayyak/UI/Screens/login_screen.dart';
import 'package:hayyak/main.dart';

class VerifyOtpCodeScreen extends StatelessWidget {
  VerifyOtpCodeScreen({required this.otpCode, required this.email});
  String otpCode = '';
  String email = '';
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              navigator(context: context, screen: LoginScreen(), remove: true);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: kDarkGreyColor,
            )),
        elevation: 0,
      ),
      body: Container(
        width: screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Image(
              width: screenWidth / 1.5,
              image: const AssetImage('assets/images/grey_logo.png'),
            ),
            // Container(
            //   margin: EdgeInsets.all(10),
            //   alignment: Alignment.center,
            //   width: screenWidth / 2,
            //   child: Text(
            //     'Please check your mail: ${email} ',
            //     style: TextStyle(
            //       color: kLightGreyColor,
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(5),
              width: screenWidth / 1.5,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 0.5,
                  color: kLightGreyColor.withOpacity(0.3),
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextField(
                controller: controller,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        SignUpLogic.verifyOtpCode(
                            context: context,
                            email: email,
                            otp: controller.text);
                      },
                      icon: const Icon(
                        Icons.send,
                        color: kPrimaryColor,
                      )),
                  hintText: 'Enter Code',
                  hintStyle: TextStyle(
                      color: kLightGreyColor.withOpacity(0.8),
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () {
                SignUpLogic.requestOtpCode(context: context, email: email);
              },
              child: const Text(
                'Resend Code',
                style: TextStyle(color: kPrimaryColor, fontSize: 14),
              ),
            )
          ],
        ),
      ),
    );
  }
}
