import 'package:flutter/material.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/UI/Screens/ticket_details_screen.dart';
import 'package:hayyak/main.dart';

class TicketCard extends StatelessWidget {
  const TicketCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        navigator(context: context,screen: TicketDetails());
      },
      child: Container(
        width: screenWidth/1.2,
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              width: screenWidth / 3,
              height: screenWidth / 3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  fit: BoxFit.cover,
                    image: AssetImage('assets/images/amr-diab-promo.jpg')),
              ),
            ),
            SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('AmrDiab',style: TextStyle(color: kDarkGreyColor,fontSize: 14),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on,size: 20,color: kLightGreyColor,),
                    Text('Riyadh Park، Northern Ring',style: TextStyle(color: Colors.blue,fontSize: 10),),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.calendar_month_outlined,size: 20,color: kLightGreyColor,),
                    Text('SAT, 19 MAR 7:00 - 10:00 PM',style: TextStyle(color: Colors.blue,fontSize: 10),),

                  ],
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
}
