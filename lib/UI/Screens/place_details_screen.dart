import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/UI/Components/app_bar.dart';
import 'package:hayyak/UI/Components/bottom_nav_bar.dart';
import 'package:hayyak/UI/Components/seccond_app_bar.dart';
import 'package:hayyak/UI/Screens/event_tickets_screen.dart';
import 'package:hayyak/UI/Screens/place_department_screen.dart';

import '../../main.dart';

class PlaceDetails extends StatelessWidget {
  const PlaceDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(currentScreen: 'Visits'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SecondAppBar(
                title: 'Dammos',
                shareAndFav: false,
                backToHome: false,
              ),
              Container(
                width: screenWidth,
                height: screenHeight / 3.5,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage('https://testing.hayyak.net/public/upload/image/46760581664472715img-4.jpg')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                        color: kDarkGreyColor,
                        width: 25,
                        height: 25,
                        'assets/icon/Icon material-location-on.svg'),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Riyadh Park',
                          style: TextStyle(
                              color: kLightGreyColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: screenWidth / 1.3,
                          child: Text(
                            'Riyadh Park، Northern Ring Branch Rd, Al Aqiq,'
                            'Riyadh',
                            style: TextStyle(
                                color: kLightGreyColor,
                                fontSize: 14,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'View Map',
                          style: TextStyle(color: kPrimaryColor, fontSize: 14),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                        color: kDarkGreyColor,
                        width: 25,
                        height: 25,
                        'assets/icon/Icon material-event.svg'),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sat, Mar 12',
                          style: TextStyle(
                              color: kLightGreyColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '10:00 AM - 2:00 PM',
                          style:
                              TextStyle(color: kLightGreyColor, fontSize: 14),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Add to calender',
                          style: TextStyle(color: kPrimaryColor, fontSize: 14),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.headset_mic_outlined,
                            color: kLightGreyColor,
                          )),
                      Text(
                        'Sales',
                        style: TextStyle(color: kLightGreyColor),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                          onPressed: () {
                            navigator(context: context,screen: PlaceDepartmentScreen());
                          },
                          icon: Icon(
                            Icons.business,
                            color: kLightGreyColor,
                          )),
                      Text(
                        'Customer Services',
                        style: TextStyle(color: kLightGreyColor),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, right: 15, bottom: 5),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Location',
                      style: TextStyle(
                          color: kDarkGreyColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              Container(
                width: screenWidth / 1.2,
                height: screenHeight / 4,
                color: Colors.grey.withOpacity(0.1),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
