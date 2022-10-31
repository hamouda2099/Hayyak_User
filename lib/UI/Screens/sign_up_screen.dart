import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/Dialogs/message_dialog.dart';
import 'package:hayyak/Logic/UI%20Logic/login_logic.dart';
import 'package:hayyak/States/providers.dart';
import 'package:hayyak/UI/Components/text_field.dart';
import 'package:hayyak/UI/Screens/login_screen.dart';
import 'package:hayyak/main.dart';



import 'package:internet_connection_checker/internet_connection_checker.dart';

// ignore: must_be_immutable
class SignUpScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  SignUpScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,color: kLightGreyColor,),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Image(
              width: screenWidth / 2,
              image: const AssetImage('assets/images/grey_logo.png'),
            ),
            SizedBox(height: 20,),
            Container(
              width: screenWidth/1.2,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 0.5,
                  color: kLightGreyColor.withOpacity(0.3),
                ),
                borderRadius: BorderRadius.circular(5),

              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    width: screenWidth/2.5,
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(

                        hintText: 'First',
                        hintStyle:  TextStyle(color: kLightGreyColor.withOpacity(0.8),fontWeight: FontWeight.bold,fontSize: 14),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Text('|',style: TextStyle(color: kLightGreyColor,fontSize: 14),),
                  Container(
                    padding: const EdgeInsets.all(5),
                    width: screenWidth/2.5,
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(

                        hintText: 'Last',
                        hintStyle:  TextStyle(color: kLightGreyColor.withOpacity(0.8),fontWeight: FontWeight.bold,fontSize: 14),
                        border: InputBorder.none,
                      ),
                    ),
                  ),


                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(controller: emailController, hintText: 'Email',obscure: false,),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: screenWidth/1.2,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 0.5,
                  color: kLightGreyColor.withOpacity(0.3),
                ),
                borderRadius: BorderRadius.circular(5),

              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    width: 50,
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: '  +966',
                        hintStyle:  TextStyle(color: kLightGreyColor.withOpacity(0.8),fontWeight: FontWeight.w300,fontSize: 12),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Text('|',style: TextStyle(color: kLightGreyColor,fontSize: 14),),
                  Container(
                    padding: const EdgeInsets.all(5),
                    width: screenWidth/2.5,
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(

                        hintText: 'Phone',
                        hintStyle:  TextStyle(color: kLightGreyColor.withOpacity(0.8),fontWeight: FontWeight.bold,fontSize: 14),
                        border: InputBorder.none,
                      ),
                    ),
                  ),


                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(controller: emailController, hintText: 'dd/mm/year',obscure: false,),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(controller: emailController, hintText: 'Gender',obscure: false,),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              controller: passwordController, hintText: 'Password',obscure: true,),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              controller: passwordController, hintText: 'Confirm Password',obscure: true,),
            Consumer(
              builder: (context, watch, child) {
                final termsAndConditions = watch(termsAndConditionsProvider).state;
                return Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (termsAndConditions == false) {
                            context.read(termsAndConditionsProvider).state = true;
                          } else {
                            context.read(termsAndConditionsProvider).state = false;
                          }
                        },
                        icon: termsAndConditions == false
                            ? const Icon(
                          Icons.check_box_outline_blank_sharp,
                          color: Colors.grey,
                          size: 18,
                        )
                            : const Icon(
                          Icons.check_box,
                          color: Colors.blue,
                          size: 18,
                        ),
                      ),
                      Text(
                        'Accept all',
                        style: TextStyle(
                            color: kDarkGreyColor.withOpacity(0.6),
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                      InkWell(
                        onTap:(){},
                        child: Text(
                          ' terms & conditions',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 20,),
            InkWell(
              onTap: () async {
                // login function
                bool result = await InternetConnectionChecker().hasConnection;
                if(result == true) {
                  // LoginLogic.login(context,
                  //     email: emailController.text,
                  //     password: passwordController.text);
                } else {
                  messageDialog(context, 'Check Internet Connection !');
                }

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
                  'SIGN UP',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already a member',
                  style: TextStyle(
                      color: kDarkGreyColor.withOpacity(0.6),
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap:(){
                    navigator(context: context,
                    screen: LoginScreen());
                  },
                  child: Text(
                    ' Sign in.',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
