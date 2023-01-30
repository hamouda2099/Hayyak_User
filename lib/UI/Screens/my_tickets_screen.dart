import 'package:flutter/material.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/UI/Components/seccond_app_bar.dart';
import 'package:hayyak/UI/Components/ticket_card_component.dart';
import 'package:hayyak/main.dart';

import '../Components/bottom_nav_bar.dart';

class MyTicketsScreen extends StatelessWidget {
  const MyTicketsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        currentScreen:'Tickets',
      ),
      body: SafeArea(
        child: Column(
          children: [
            SecondAppBar(title: 'My Tickets',shareAndFav: false),
            Container(
              width: screenWidth/1.2,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: kLightGreyColor,width: 1)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Upcoming',style: TextStyle(color: Colors.blue,fontSize: 12,fontWeight: FontWeight.bold),),
                  Text('|',style: TextStyle(color: kLightGreyColor,fontSize: 14,fontWeight: FontWeight.w400),),
                  Text('Past',style: TextStyle(color: kLightGreyColor,fontSize: 12,fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            Container(
              height: screenHeight/1.5,
              child: ListView.builder(

                itemBuilder: (context, index) {
                return TicketCard();
              },),
            )
          ],
        ),
      ),
    );
  }
}
