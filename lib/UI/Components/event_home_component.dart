import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/UI/Screens/event_details_screen.dart';
import 'package:hayyak/main.dart';

class EventHomeCard extends StatelessWidget {
  const EventHomeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        navigator(context: context,screen: EventDetails());
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          padding: EdgeInsets.all(5),
          width: screenWidth/2,
          height: screenHeight/4,
          child: Column(
            children: [
              Container(
                width: screenWidth/2,
                height: screenHeight/5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/amr-diab-promo.jpg'))
                ),
              ),
              SizedBox(height: 4,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Amr Diab',style: TextStyle(color: kLightGreyColor,fontSize: 14),),
                  Row(
                    children: [
                      InkWell(
                          onTap: (){

                          },
                          child: Icon(Icons.file_upload_outlined,size: 20,color: kLightGreyColor,)),
                      InkWell(
                        onTap: (){

                        },
                        child: SvgPicture.asset(
                          color: kLightGreyColor,
                            width: 15, height: 15, 'assets/icon/Icon feather-heart.svg'),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 4,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                  Icon(Icons.location_on,size: 20,color: kLightGreyColor,),
                      Text('Riyadh',style: TextStyle(color: kLightGreyColor,fontSize: 12),),

                    ],
                  ),
                  SizedBox(width: 20,),
                  Text('19 Mars',style: TextStyle(color: Colors.blue,fontSize: 12),),

                ],
              )

            ],

          ),
        ),
      ),
    );
  }
}
