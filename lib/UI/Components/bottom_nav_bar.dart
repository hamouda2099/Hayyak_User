import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/user_data.dart';
import 'package:hayyak/UI/Screens/favourite_list_screen.dart';
import 'package:hayyak/UI/Screens/home_screen.dart';
import 'package:hayyak/UI/Screens/login_screen.dart';
import 'package:hayyak/UI/Screens/my_tickets_screen.dart';
import 'package:hayyak/UI/Screens/search_screen.dart';

import '../../Config/navigator.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({required this.currentScreen});

  String currentScreen = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      alignment: Alignment.center,
      width: double.infinity,
      height: 60,
      color: kDarkGreyColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                    color: currentScreen == 'Explore'
                        ? kPrimaryColor
                        : Colors.white,
                    'assets/icon/explore.svg'),
                SizedBox(
                  height: 5,
                ),
                Text(
                  UserData.translation.data?.explore?.toString() ?? 'Explore',
                  style: TextStyle(
                      color: currentScreen == 'Explore'
                          ? kPrimaryColor
                          : Colors.white,
                      fontSize: 9),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              if (UserData.token == '') {
                navigator(
                    context: context,
                    screen: LoginScreen(
                      screen: MyTicketsScreen(),
                    ));
              } else {
                navigator(context: context, screen: MyTicketsScreen());
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset(
                    width: 12,
                    color: currentScreen == 'Tickets'
                        ? kPrimaryColor
                        : Colors.white,
                    'assets/icon/blue-ticket.svg'),
                SizedBox(
                  height: 5,
                ),
                Text(
                  UserData.translation.data?.tickets?.toString() ?? 'Tickets',
                  style: TextStyle(
                      color: currentScreen == 'Tickets'
                          ? kPrimaryColor
                          : Colors.white,
                      fontSize: 9),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              if (UserData.token == '') {
                navigator(
                    context: context,
                    screen: LoginScreen(
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
                        ? kPrimaryColor
                        : Colors.white,
                    'assets/icon/Icon feather-heart.svg'),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  UserData.translation.data?.favourites?.toString() ??
                      'Favourites',
                  style: TextStyle(
                      color: currentScreen == 'Favourites'
                          ? kPrimaryColor
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
                        ? kPrimaryColor
                        : Colors.white,
                    'assets/icon/Icon feather-search.svg'),
                SizedBox(
                  height: 5,
                ),
                Text(
                  UserData.translation.data?.search?.toString() ?? 'Search',
                  style: TextStyle(
                      color: currentScreen == 'Search'
                          ? kPrimaryColor
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
