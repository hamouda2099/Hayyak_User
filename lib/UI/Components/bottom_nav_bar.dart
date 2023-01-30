import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/user_data.dart';
import 'package:hayyak/UI/Components/Dashboard/screens/dashboard_screen.dart';
import 'package:hayyak/UI/Screens/favourite_list_screen.dart';
import 'package:hayyak/UI/Screens/home_screen.dart';
import 'package:hayyak/UI/Screens/my_tickets_screen.dart';
import 'package:hayyak/UI/Screens/places_screen.dart';
import 'package:hayyak/UI/Screens/search_screen.dart';
import 'package:hayyak/main.dart';

import '../../Config/navigator.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({required this.currentScreen});
  String currentScreen = '';
  Widget sized = SizedBox(
    width: UserData.token == '' ? screenWidth / 10 : screenWidth / 15,
  );
  @override
  Widget build(BuildContext context) {
    print(UserData.token);
    print(UserData.role);
    return Container(
      padding: EdgeInsets.all(10),
      alignment: Alignment.center,
      width: double.infinity,
      height: 70,
      color: kDarkGreyColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {
              navigator(context: context, screen: HomeScreen());
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                    width: 25,
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
                      fontSize: 10),
                ),
              ],
            ),
          ),
          sized,
          InkWell(
            onTap: () {
              navigator(context: context, screen: PlacesScreen());
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                    width: 25,
                    color:
                        currentScreen == 'Visits' ? Colors.blue : Colors.white,
                    'assets/icon/building.svg'),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Visits',
                  style: TextStyle(
                      color: currentScreen == 'Visits'
                          ? Colors.blue
                          : Colors.white,
                      fontSize: 10),
                ),
              ],
            ),
          ),
          UserData.token == ''
              ? SizedBox(
                  width: 0,
                )
              : Padding(
                  padding: EdgeInsets.only(left: screenWidth / 15),
                  child: InkWell(
                    onTap: () {
                      navigator(context: context, screen: MyTicketsScreen());
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                            width: 15,
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
                              fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ),
          UserData.token == ''
              ? const SizedBox(
                  width: 0,
                )
              : Padding(
                  padding: EdgeInsets.only(left: screenWidth / 15),
                  child: InkWell(
                    onTap: () {
                      navigator(context: context, screen: FavListScreen());
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                            width: 25,
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
                              fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ),
          sized,
          InkWell(
            onTap: () {
              navigator(context: context, screen: SearchScreen());
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search,
                  color: currentScreen == 'Search' ? Colors.blue : Colors.white,
                  size: 30,
                ),
                Text(
                  'Search',
                  style: TextStyle(
                      color: currentScreen == 'Search'
                          ? Colors.blue
                          : Colors.white,
                      fontSize: 10),
                ),
              ],
            ),
          ),
          (UserData.role != 'company' && UserData.role != 'employee')
              ? const SizedBox(
                  width: 0,
                )
              : UserData.token == ''
                  ? const SizedBox(
                      width: 0,
                    )
                  : Padding(
                      padding: EdgeInsets.only(left: screenWidth / 15),
                      child: InkWell(
                        onTap: () {
                          navigator(
                              context: context, screen: DashboardScreen());
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.dashboard,
                              color: currentScreen == 'Dashboard'
                                  ? Colors.blue
                                  : Colors.white,
                              size: 25,
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: screenWidth / 8,
                              child: Text(
                                'Visting Requests',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: currentScreen == 'Dashboard'
                                        ? Colors.blue
                                        : Colors.white,
                                    fontSize: 10),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
        ],
      ),
    );
  }
}
