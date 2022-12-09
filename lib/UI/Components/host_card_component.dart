import 'package:flutter/material.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/UI/Screens/send_visit_order_screen.dart';
import 'package:hayyak/main.dart';

class HostCardComponent extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        navigator(context: context,screen: VisitOrderScreen() );
      },
      child: Column(
        children: [
          Container(
            width: screenWidth/3,
            height: screenWidth/3,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage('https://www.shutterstock.com/image-photo/young-handsome-man-beard-wearing-260nw-1768126784.jpg'))
            ),
          ),
          SizedBox(height: 5,),
          const Text('Employee Name',style: TextStyle(
              color: kDarkGreyColor,
              fontSize: 14
          ),)
        ],
      ),
    );
  }
}
