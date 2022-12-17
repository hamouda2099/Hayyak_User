import 'package:flutter/material.dart';
import 'package:hayyak/Config/test_static_data.dart';
import 'package:hayyak/UI/Components/bottom_nav_bar.dart';
import 'package:hayyak/UI/Components/chair_component.dart';
import 'package:hayyak/UI/Components/seat_category_component.dart';
import 'package:hayyak/UI/Components/seccond_app_bar.dart';
import 'package:hayyak/main.dart';

class EventSeatsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        currentScreen: 'Seats',
      ),
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          children: [
            SecondAppBar(title: 'Seats'),
            Container(
              width: double.infinity,
              height: screenHeight/4,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/amr-diab-promo.jpg'))
              ),
            ),
           Container(
             width: double.infinity,
             height: screenHeight/2,
             child: ListView.builder(
               itemCount: TestDate().seatsCategory.length,
               itemBuilder: (context, index) {
               return SeatCategoryComponent(
                 seatCategory: TestDate().seatsCategory[index],
               );
             },),
           ),
            SizedBox(height: 20,),
            InkWell(
              onTap: (){

              },
              child: Container(
                alignment: Alignment.center,
                width: screenWidth/1.1,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text('Checkout',style: TextStyle(color: Colors.white),),
              ),
            ),
            SizedBox(height: 20,),

          ],
        ),
      )),
    );
  }
}
