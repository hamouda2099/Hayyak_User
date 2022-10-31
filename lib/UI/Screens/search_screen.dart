import 'package:flutter/material.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/UI/Components/bottom_nav_bar.dart';
import 'package:hayyak/UI/Components/seccond_app_bar.dart';
import 'package:hayyak/main.dart';

class SearchScreen extends StatelessWidget {
TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(currentScreen: 'Search'),
      body: SafeArea(
        child: Column(
          children: [
            SecondAppBar(title: 'Search'),
            Container(
              width: screenWidth/1.1,
              decoration: BoxDecoration(
                border: Border.all(color: kLightGreyColor.withOpacity(0.5),width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search,color: kLightGreyColor,),
                  hintText: 'Search',
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text('Recently',style: TextStyle(
                  color: kDarkGreyColor,fontSize: 14,fontWeight: FontWeight.bold,
                ),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
