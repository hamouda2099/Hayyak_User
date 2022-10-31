import 'package:flutter/material.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/UI/Components/app_bar.dart';
import 'package:hayyak/UI/Components/bottom_nav_bar.dart';
import 'package:hayyak/UI/Components/event_home_component.dart';
import 'package:hayyak/UI/Components/home_slider_component.dart';
import 'package:hayyak/main.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        currentScreen: 'Explore',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(),
              const HomeSlider(),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(' Popular',style: TextStyle(color: kLightGreyColor,fontSize: 16,fontWeight: FontWeight.bold),)),
              ),
              Container(
                width: screenWidth/1,
                height: screenHeight/3,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 11,
                  itemBuilder: (context, index) {
                    return const EventHomeCard();
                  },),
              ),
              const Padding(
                padding:  EdgeInsets.all(8.0),
                child:  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Sport',style: TextStyle(color: kLightGreyColor,fontSize: 16,fontWeight: FontWeight.bold),)),
              ),
              Container(
                width: screenWidth/1,
                height: screenHeight/3,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 11,
                  itemBuilder: (context, index) {
                    return const EventHomeCard();
                  },),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
