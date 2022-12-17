import 'package:flutter/material.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/date_formatter.dart';
import 'package:hayyak/Dialogs/loading_screen.dart';
import 'package:hayyak/Logic/Services/api_manger.dart';
import 'package:hayyak/Models/home_model.dart';
import 'package:hayyak/UI/Components/app_bar.dart';
import 'package:hayyak/UI/Components/bottom_nav_bar.dart';
import 'package:hayyak/UI/Components/event_home_component.dart';
import 'package:hayyak/UI/Components/home_slider_component.dart';
import 'package:hayyak/main.dart';

import '../../Dialogs/loading_dialog.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavBar(
        currentScreen: 'Explore',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(),
              FutureBuilder<HomeModel>(
                future: ApiManger.getHome(),
                builder:
                    (BuildContext context, AsyncSnapshot<HomeModel> snapShot) {
                  switch (snapShot.connectionState) {
                    case ConnectionState.waiting:
                      {
                        return ScreenLoading();
                      }
                    default:
                      if (snapShot.hasError) {
                        return Text('Error: ${snapShot.error}');
                      } else {
                        var fetchedOrder = snapShot.data;
                        return Column(
                          children: [
                            Container(
                              width: screenWidth / 1,
                              height: screenHeight / 3.2,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapShot?.data?.data.slider.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {},
                                    child: Container(
                                      margin: EdgeInsets.only(top: 5,bottom: 20,left: 5,right: 5),
                                      width: screenWidth / 1.2,
                                      height: screenHeight / 5,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(snapShot
                                                      ?.data
                                                      ?.data
                                                      ?.slider[index]
                                                      ?.image ??
                                                  ''))),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Container(
                              height: screenHeight / 2,
                              child: ListView.builder(
                                itemCount:
                                    snapShot?.data?.data.categories.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              snapShot
                                                      ?.data
                                                      ?.data
                                                      ?.categories[index]
                                                      .name ??
                                                  '',
                                              style: TextStyle(
                                                  color: kDarkGreyColor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                      ),
                                      Container(
                                        width: screenWidth,
                                        height: screenHeight / 3.2,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: snapShot?.data?.data
                                              .categories[index].events.length,
                                          itemBuilder: (context, i) {
                                            return EventHomeCard(
                                              id: snapShot
                                                      ?.data
                                                      ?.data
                                                      .categories[index]
                                                      ?.events[i]
                                                      ?.id ??
                                                  0,
                                              eventName: snapShot
                                                      ?.data
                                                      ?.data
                                                      .categories[index]
                                                      ?.events[i]
                                                      ?.name ??
                                                  '',
                                              image: snapShot
                                                      ?.data
                                                      ?.data
                                                      .categories[index]
                                                      ?.events[i]
                                                      ?.image ??
                                                  '',
                                              location: snapShot
                                                      ?.data
                                                      ?.data
                                                      .categories[index]
                                                      .events[i]
                                                      .location ??
                                                  '',
                                              startDate: snapShot
                                                      ?.data
                                                      ?.data
                                                      .categories[index]
                                                      .events[i]
                                                      .start ??
                                                  '',
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            )
                          ],
                        );
                      }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
