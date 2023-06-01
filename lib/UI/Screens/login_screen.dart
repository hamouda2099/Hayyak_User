import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/Logic/UI%20Logic/login_logic.dart';
import 'package:hayyak/States/providers.dart';
import 'package:hayyak/UI/Components/box_shadow.dart';
import 'package:hayyak/UI/Components/text_field.dart';
import 'package:hayyak/UI/Screens/sign_up_screen.dart';
import 'package:hayyak/main.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({required this.screen});

  LoginLogic logic = LoginLogic();
  var screen;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  _back() {}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _back(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: screenHeight / 10,
              ),
              Image(
                width: screenWidth / 2,
                image: const AssetImage('assets/images/grey_logo.png'),
              ),
              SizedBox(
                height: screenHeight / 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35.0, right: 35.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Welcome back!',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                width: screenWidth / 1.2,
                controller: emailController,
                hintText: 'Email',
                obscure: false,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                width: screenWidth / 1.2,
                controller: passwordController,
                hintText: 'Password',
                obscure: true,
              ),
              Consumer(
                builder: (context, ref, child) {
                  logic.ref = ref;
                  final rememberMe = ref.watch(rememberMeProvider);
                  return Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            if (rememberMe == false) {
                              ref.read(rememberMeProvider.notifier).state =
                                  true;
                            } else {
                              ref.read(rememberMeProvider.notifier).state =
                                  false;
                            }
                          },
                          icon: rememberMe == false
                              ? const Icon(
                                  Icons.check_circle_outline,
                                  color: Colors.grey,
                                  size: 18,
                                )
                              : const Icon(
                                  Icons.check_circle,
                                  color: Colors.blue,
                                  size: 18,
                                ),
                        ),
                        Text(
                          'Remember me',
                          style: TextStyle(
                              color: kDarkGreyColor.withOpacity(0.6),
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  );
                },
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 10, left: 35.0, right: 35.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                      onTap: () {},
                      child: const Text(
                        'Forget Password ?',
                        style:
                            const TextStyle(color: Colors.blue, fontSize: 12),
                      )),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Consumer(
                builder: (context, ref, child) {
                  return InkWell(
                    onTap: () async {
                      LoginLogic.login(context,
                          email: emailController.text,
                          password: passwordController.text,
                          screen: screen,
                          ref: ref);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: screenWidth / 1.2,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(15),
                      child: const Text(
                        'SIGN IN',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                width: screenWidth / 1.2,
                child: Row(
                  children: [
                    Container(
                      width: screenWidth / 3.6,
                      height: 1,
                      color: kLightGreyColor,
                    ),
                    const Text(
                      ' Or login with ',
                      style:
                          const TextStyle(color: kLightGreyColor, fontSize: 14),
                    ),
                    Container(
                      width: screenWidth / 3.6,
                      height: 1,
                      color: kLightGreyColor,
                    ),
                  ],
                ),
              ),
              Container(
                width: screenWidth / 1.2,
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: boxShadow),
                      child: SvgPicture.asset(
                          width: 30,
                          height: 30,
                          'assets/icon/Icon awesome-google.svg'),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: boxShadow),
                      child: const Icon(
                        Icons.apple,
                        color: Colors.black,
                        size: 40,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: boxShadow),
                      child: SvgPicture.asset(
                          width: 30, height: 30, 'assets/icon/facebook.svg'),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don\'t have an account?",
                    style: TextStyle(
                      color: kLightGreyColor,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        navigator(context: context, screen: SignUpScreen());
                      },
                      child: const Text(
                        "Create One",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 14,
                        ),
                      )),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
