import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/user_data.dart';
import 'package:hayyak/UI/Components/Dashboard/screens/dashboard_screen.dart';
import 'package:hayyak/UI/Screens/favourite_list_screen.dart';
import 'package:hayyak/UI/Screens/home_screen.dart';
import 'package:hayyak/UI/Screens/login_screen.dart';
import 'package:hayyak/UI/Screens/my_tickets_screen.dart';
import 'package:hayyak/UI/Screens/places_screen.dart';
import 'package:hayyak/UI/Screens/search_screen.dart';
import 'package:hayyak/main.dart';

import '../../Config/navigator.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({required this.currentScreen});
  String currentScreen = '';
  @override
  Widget build(BuildContext context) {
    print(currentScreen);
    return Container(
      padding: EdgeInsets.all(10),
      alignment: Alignment.center,
      width: double.infinity,
      height: 70,
      color: kDarkGreyColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {
              navigator(context: context, screen: HomeScreen());
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,

              children: [
                SvgPicture.asset(
                    width: 20,
                    color:
                        currentScreen == 'Explore' ? Colors.blue : Colors.white,
                    'assets/icon/explore.svg'),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Explore',
                  style: TextStyle(
                      color: currentScreen == 'Explore'
                          ? Colors.blue
                          : Colors.white,
                      fontSize: 9),
                ),
              ],
            ),
          ),
          InkWell(
                onTap: () {
                  if (UserData.token == ''){
                    navigator(context: context,screen: LoginScreen(
                      screen: MyTicketsScreen(),
                    ));
                  } else {
                    navigator(context: context, screen: MyTicketsScreen());
                  }                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SvgPicture.asset(
                        width: 12,
                        color: currentScreen == 'Tickets'
                            ? Colors.blue
                            : Colors.white,
                        'assets/icon/blue-ticket.svg'),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Tickets',
                      style: TextStyle(
                          color: currentScreen == 'Tickets'
                              ? Colors.blue
                              : Colors.white,
                          fontSize: 9),
                    ),
                  ],
                ),
              ),
         InkWell(
                onTap: () {
                  if (UserData.token == ''){
                    navigator(context: context,screen: LoginScreen(
                      screen: FavListScreen(),
                    ));
                  } else {
                    navigator(context: context, screen: FavListScreen());
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SvgPicture.asset(
                        width: 20,
                        color: currentScreen == 'Favourites'
                            ? Colors.blue
                            : Colors.white,
                        'assets/icon/Icon feather-heart.svg'),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Favourites',
                      style: TextStyle(
                          color: currentScreen == 'Favourites'
                              ? Colors.blue
                              : Colors.white,
                          fontSize: 9),
                    ),
                  ],
                ),
              ),
          InkWell(
            onTap: () {
              navigator(context: context, screen: SearchScreen());
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset(
                    width: 20,
                    color: currentScreen == 'Search'
                        ? Colors.blue
                        : Colors.white,
                    'assets/icon/Icon feather-search.svg'),
                SizedBox(height: 5,),
                Text(
                  'Search',
                  style: TextStyle(
                      color: currentScreen == 'Search'
                          ? Colors.blue
                          : Colors.white,
                      fontSize: 9),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
