import 'package:flutter/material.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Dialogs/loading_screen.dart';
import 'package:hayyak/Logic/Services/api_manger.dart';
import 'package:hayyak/Models/home_model.dart';
import 'package:hayyak/UI/Components/app_bar.dart';
import 'package:hayyak/UI/Components/bottom_nav_bar.dart';
import 'package:hayyak/UI/Components/event_home_component.dart';
import 'package:hayyak/UI/Components/home_slider_component.dart';
import 'package:hayyak/main.dart';

import '../../Config/user_data.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavBar(
        currentScreen: 'Explore',
      ),
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(),
            Expanded(
              child: FutureBuilder<HomeModel>(
                future: ApiManger.getHome(),
                builder:
                    (BuildContext context, AsyncSnapshot<HomeModel> snapShot) {
                  switch (snapShot.connectionState) {
                    case ConnectionState.waiting:
                      {
                        return Center(child: ScreenLoading());
                      }
                    default:
                      if (snapShot.hasError) {
                        return Text(UserData
                                .translation.data?.noInternetConnection
                                ?.toString() ??
                            'Error: ${snapShot.error}');
                      } else {
                        return ListView(
                          primary: true,
                          children: [
                            HomeAds(slider: snapShot.data?.data?.slider ?? []),
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              children: List.generate(
                                  snapShot.data?.data?.categories?.length ?? 0,
                                  (index) {
                                double scrollingVal = 0;
                                ScrollController scrollCnt = ScrollController();
                                num jumps = 0;
                                num actions = 1;
                                if ((snapShot.data?.data?.categories?[index]
                                            .events ??
                                        [])
                                    .length
                                    .isOdd) {
                                  jumps = ((snapShot
                                                      .data
                                                      ?.data
                                                      ?.categories?[index]
                                                      .events ??
                                                  [])
                                              .length +
                                          1) /
                                      2;
                                } else {
                                  jumps = (snapShot.data?.data
                                                  ?.categories?[index].events ??
                                              [])
                                          .length /
                                      2;
                                }

                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Align(
                                          alignment: localLanguage == 'en'
                                              ? Alignment.centerLeft
                                              : Alignment.centerRight,
                                          child: Text(
                                            snapShot.data?.data
                                                    ?.categories?[index].name ??
                                                '',
                                            style: const TextStyle(
                                                color: kDarkGreyColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          )),
                                    ),
                                    ((snapShot.data?.data?.categories?[index]
                                                    .events?.length) ??
                                                0) >
                                            2
                                        ? InkWell(
                                            onTap: () {
                                              if (actions >= jumps) {
                                                actions = 1;
                                                scrollingVal = 0;
                                                scrollCnt.animateTo(
                                                    scrollingVal,
                                                    duration: const Duration(
                                                        seconds: 1),
                                                    curve: Curves.ease);
                                              } else {
                                                scrollingVal = screenWidth;
                                                actions = actions + 1;
                                                scrollCnt.animateTo(
                                                    scrollingVal,
                                                    duration: const Duration(
                                                        seconds: 1),
                                                    curve: Curves.ease);
                                              }
                                              print(snapShot
                                                  .data
                                                  ?.data
                                                  ?.categories?[index]
                                                  .events
                                                  ?.length);
                                              print(jumps);
                                              print(actions);
                                              print(scrollingVal);
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.all(5),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    UserData.translation.data
                                                            ?.seeAll
                                                            ?.toString() ??
                                                        "See All ",
                                                    style: TextStyle(
                                                      color: kPrimaryColor,
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: kPrimaryColor,
                                                    size: 10,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : SizedBox(),
                                    SizedBox(
                                      width: screenWidth,
                                      height: screenHeight / 3.4,
                                      child: ListView.builder(
                                        controller: scrollCnt,
                                        primary: false,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: snapShot
                                                .data
                                                ?.data
                                                ?.categories?[index]
                                                .events
                                                ?.length ??
                                            0,
                                        itemBuilder: (context, i) {
                                          scrollCnt.addListener(
                                            () {
                                              if (scrollCnt.position.atEdge &&
                                                  scrollCnt.position.pixels !=
                                                      0) {
                                                actions = 1;
                                              }
                                            },
                                          );
                                          return EventHomeCard(
                                            action: snapShot
                                                .data
                                                ?.data
                                                ?.categories?[index]
                                                .events?[i]
                                                .action,
                                            id: snapShot
                                                    .data
                                                    ?.data
                                                    ?.categories?[index]
                                                    .events?[i]
                                                    .id ??
                                                0,
                                            eventName: snapShot
                                                    .data
                                                    ?.data
                                                    ?.categories?[index]
                                                    .events?[i]
                                                    .name ??
                                                '',
                                            image: snapShot
                                                    .data
                                                    ?.data
                                                    ?.categories?[index]
                                                    .events?[i]
                                                    .image ??
                                                '',
                                            location: snapShot
                                                    .data
                                                    ?.data
                                                    ?.categories?[index]
                                                    .events?[i]
                                                    .location ??
                                                '',
                                            startDate: snapShot
                                                    .data
                                                    ?.data
                                                    ?.categories?[index]
                                                    .events?[i]
                                                    .start ??
                                                '',
                                            is_favourite: snapShot
                                                    .data
                                                    ?.data
                                                    ?.categories?[index]
                                                    .events?[i]
                                                    .is_favourite ??
                                                false,
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            )
                          ],
                        );
                      }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
