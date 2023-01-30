import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/UI/Screens/event_details_screen.dart';
import 'package:hayyak/UI/Screens/place_details_screen.dart';
import 'package:hayyak/main.dart';

class PlaceCard extends StatelessWidget {
  const PlaceCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigator(context: context, screen: PlaceDetails());
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0,left: 2.5,bottom: 5,right: 5),
        child: Container(
          padding: EdgeInsets.all(5),
          width: screenWidth / 2.5,
          height: screenWidth/2.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: screenWidth / 2,
                height: screenHeight / 5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage('https://testing.hayyak.net/public/upload/image/46760581664472715img-4.jpg'))),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                'Dammos',
                style: TextStyle(color: kDarkGreyColor, fontSize: 14),
              ),
              Text(
                'Main Building',
                style: TextStyle(color: kLightGreyColor.withOpacity(0.5), fontSize: 12),
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_on,
                    size: 20,
                    color: kLightGreyColor,
                  ),
                  Text(
                    'Riyadh',
                    style: TextStyle(color: kLightGreyColor, fontSize: 12),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
