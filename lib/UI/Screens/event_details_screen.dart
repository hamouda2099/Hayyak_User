import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/Dialogs/loading_screen.dart';
import 'package:hayyak/Logic/Services/api_manger.dart';
import 'package:hayyak/Models/event_model.dart';
import 'package:hayyak/UI/Components/app_bar.dart';
import 'package:hayyak/UI/Components/seccond_app_bar.dart';
import 'package:hayyak/UI/Screens/event_tickets_screen.dart';

import '../../main.dart';

class EventDetails extends StatelessWidget {
  EventDetails({required this.eventId});
  num eventId;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<EventModel>(
      future: ApiManger.getEvent(id: eventId.toString()),
      builder: (BuildContext context, AsyncSnapshot<EventModel> snapShot) {
        switch (snapShot.connectionState) {
          case ConnectionState.waiting:
            {
              return Scaffold(
                body: ScreenLoading(),
              );
            }
          default:
            if (snapShot.hasError) {
              return Scaffold(
                  body: Center(child: Text('Error: ${snapShot.error}')));
            } else {
              return Scaffold(
                bottomNavigationBar: Container(
                  width: screenWidth / 1,
                  height: screenHeight / 10,
                  color: kDarkGreyColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapShot?.data?.data?.averageCost ?? '',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          snapShot?.data?.data?.action?.name == null
                              ? const SizedBox()
                              : Row(
                                  children: [
                                    const Icon(
                                      Icons.electric_bolt_rounded,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      snapShot?.data?.data?.action?.name ?? '',
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                  ],
                                )
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          navigator(
                              context: context, screen: EventTicketsScreen());
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: screenWidth / 2,
                          height: 50,
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Tickets',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SecondAppBar(
                          title: snapShot?.data?.data?.name.toString() ?? '',
                        ),
                        Column(
                          children: [
                            Container(
                              width: screenWidth,
                              height: screenHeight / 3.5,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(snapShot
                                            ?.data?.data?.image
                                            .toString() ??
                                        '')),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapShot?.data?.data?.startDate
                                                .toString() ??
                                            '',
                                        style: TextStyle(
                                            color: kLightGreyColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        snapShot?.data?.data?.time ?? '',
                                        style: TextStyle(
                                            color: kLightGreyColor,
                                            fontSize: 14),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Add to calender',
                                        style: TextStyle(
                                            color: kPrimaryColor, fontSize: 14),
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
                                      'assets/icon/Icon material-location-on.svg'),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Address',
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
                                          snapShot?.data?.data?.address ?? '',
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
                                        style: TextStyle(
                                            color: kPrimaryColor, fontSize: 14),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15, bottom: 5),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: const Text(
                                    'About This Event',
                                    style: TextStyle(
                                        color: kDarkGreyColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15.0, right: 15),
                              child: Text(
                                snapShot?.data?.data?.description ?? '',
                                style: TextStyle(
                                    color: kLightGreyColor, fontSize: 14),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15, bottom: 5),
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
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
        }
      },
    );
  }
}
