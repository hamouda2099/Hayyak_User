import 'package:flutter/material.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/UI/Components/box_shadow.dart';
import 'package:hayyak/UI/Components/seccond_app_bar.dart';
import 'package:hayyak/UI/Screens/account_screen.dart';
import 'package:hayyak/UI/Screens/contact_us_screen.dart';
import 'package:hayyak/main.dart';

import '../../Dialogs/logout_dialog.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SecondAppBar(title: 'Settings'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: screenWidth/5,
                    height: screenWidth/5,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(

                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/amr-diab-promo.jpg')),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Ensa Karem',style: TextStyle(color: kDarkGreyColor,fontSize: 14,fontWeight: FontWeight.bold)),
                      const Text('enasss12@gmail.com',style: TextStyle(color: kDarkGreyColor,fontSize: 12)),

                    ],
                  ),
                ],
              ),
              InkWell(
                onTap: (){
                  navigator(context: context, screen: AccountScreen());
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  width: screenWidth/1.1,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: boxShadow
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Account',style: TextStyle(color: kLightGreyColor,fontSize: 14,fontWeight: FontWeight.bold)),
                      Icon(Icons.arrow_forward_ios,color: kDarkGreyColor,size: 20,),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: (){

                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  width: screenWidth/1.1,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: boxShadow
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('??????????????',style: TextStyle(color: kLightGreyColor,fontSize: 14,fontWeight: FontWeight.bold)),
                      Icon(Icons.arrow_forward_ios,color: kDarkGreyColor,size: 20,),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: (){

                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  width: screenWidth/1.1,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: boxShadow
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('FAQs',style: TextStyle(color: kLightGreyColor,fontSize: 14,fontWeight: FontWeight.bold)),
                      Icon(Icons.arrow_forward_ios,color: kDarkGreyColor,size: 20,),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: (){

                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  width: screenWidth/1.1,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: boxShadow
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Privacy & Policy',style: TextStyle(color: kLightGreyColor,fontSize: 14,fontWeight: FontWeight.bold)),
                      Icon(Icons.arrow_forward_ios,color: kDarkGreyColor,size: 20,),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: (){

                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  width: screenWidth/1.1,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: boxShadow
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Terms & Conditions',style: TextStyle(color: kLightGreyColor,fontSize: 14,fontWeight: FontWeight.bold)),
                      Icon(Icons.arrow_forward_ios,color: kDarkGreyColor,size: 20,),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  navigator(context: context,screen: ContactUsScreen());
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  width: screenWidth/1.1,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: boxShadow
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Contact us',style: TextStyle(color: kLightGreyColor,fontSize: 14,fontWeight: FontWeight.bold)),
                      Icon(Icons.arrow_forward_ios,color: kDarkGreyColor,size: 20,),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  logoutDialog(
                    context
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  width: screenWidth/1.1,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: kLightGreyColor,width: 1)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Log out',style: TextStyle(color: kLightGreyColor,fontSize: 14,fontWeight: FontWeight.bold)),
                      Icon(Icons.logout_rounded,color: kDarkGreyColor,size: 20,),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
