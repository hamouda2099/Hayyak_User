import 'package:flutter/material.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/Dialogs/loading_screen.dart';
import 'package:hayyak/Logic/Services/api_manger.dart';
import 'package:hayyak/Models/home_model.dart';
import 'package:hayyak/UI/Components/app_bar.dart';
import 'package:hayyak/UI/Components/bottom_nav_bar.dart';
import 'package:hayyak/UI/Components/event_home_component.dart';
import 'package:hayyak/UI/Components/home_slider_component.dart';
import 'package:hayyak/UI/Screens/event_details_screen.dart';
import 'package:hayyak/main.dart';


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
                        return Text('Error: ${snapShot.error}');
                      } else {
                        return ListView(
                          primary: true,
                          children: [
                            HomeAds(slider: snapShot.data?.data.slider??[]),
                            Column(
                              children: List.generate(snapShot.data!.data.categories.length, (index) => Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          snapShot
                                              .data
                                              ?.data
                                              .categories[index]
                                              .name ??
                                              '',
                                          style: const TextStyle(
                                              color: kDarkGreyColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                  SizedBox(
                                    width: screenWidth,
                                    height: screenHeight / 3.2,
                                    child: ListView.builder(
                                      primary: false,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: snapShot.data?.data
                                          .categories[index].events.length,
                                      itemBuilder: (context, i) {
                                        return EventHomeCard(
                                          id: snapShot
                                              .data
                                              ?.data
                                              .categories[index]
                                              .events[i]
                                              .id ??
                                              0,
                                          eventName: snapShot
                                              .data
                                              ?.data
                                              .categories[index]
                                              .events[i]
                                              .name ??
                                              '',
                                          image: snapShot
                                              .data
                                              ?.data
                                              .categories[index]
                                              .events[i]
                                              .image ??
                                              '',
                                          location: snapShot
                                              .data
                                              ?.data
                                              .categories[index]
                                              .events[i]
                                              .location ??
                                              '',
                                          startDate: snapShot
                                              .data
                                              ?.data
                                              .categories[index]
                                              .events[i]
                                              .start ??
                                              '',
                                          is_favourite: snapShot
                                              .data
                                              ?.data
                                              .categories[index]
                                              .events[i]
                                              .is_favourite ??
                                              false,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              )),
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
