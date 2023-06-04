import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/UI/Screens/home_screen.dart';
import 'package:hayyak/main.dart';

import '../Config/constants.dart';

void orderCreatedSuccessfully({required BuildContext context}){
  showDialog(context: context, builder: (context){
    return AlertDialog(
      content: Container(
        width: screenWidth/1.5,
        height: screenHeight/2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text('Order Created Successfully',style: TextStyle(color: Colors.black),),
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                navigator(context: context,screen: HomeScreen(),remove: true);
              },
              child: Container(
                alignment: Alignment.center,
                width: screenWidth / 2,
                height: 40,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(5),
                child: const Text(
                  'Ok',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  });
}