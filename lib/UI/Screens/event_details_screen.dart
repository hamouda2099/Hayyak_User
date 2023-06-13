import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/Dialogs/loading_screen.dart';
import 'package:hayyak/Logic/Services/api_manger.dart';
import 'package:hayyak/Models/event_model.dart';
import 'package:hayyak/UI/Components/map_view_screen.dart';
import 'package:hayyak/UI/Components/seccond_app_bar.dart';
import 'package:hayyak/UI/Screens/date_picker_screen.dart';
import 'package:html_widget/html_widget.dart';

import '../../Config/user_data.dart';
import '../../main.dart';

class EventDetails extends StatelessWidget {
  EventDetails({required this.eventId});

  num eventId;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  DateTime? endDatePicker;
  GoogleMapController? controller;
  Set<Marker> marker = Set();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<EventModel>(
      future: ApiManger.getEvent(id: eventId.toString()),
      builder: (BuildContext context, AsyncSnapshot<EventModel> snapShot) {
        switch (snapShot.connectionState) {
          case ConnectionState.waiting:
            {
              return Scaffold(
                body: Center(child: ScreenLoading()),
              );
            }
          default:
            if (snapShot.hasError) {
              return Scaffold(
                  body: Center(child: Text('Error: ${snapShot.error}')));
            } else {
              double? lat = double.tryParse(snapShot.data!.data.latLng
                  .substring(0, snapShot.data?.data.latLng.indexOf(','))
                  .toString());
              double? lng = double.tryParse(snapShot.data!.data.latLng
                  .substring(snapShot.data!.data.latLng.indexOf(',') + 1,
                      snapShot.data!.data.latLng.length));
              marker.add(
                Marker(
                  markerId: const MarkerId('Location'),
                  position: LatLng(lat!, lng!),
                  infoWindow: InfoWindow(
                    title: snapShot.data!.data.name,
                    snippet: snapShot.data!.data.description,
                  ),
                ),
              );

              return Scaffold(
                backgroundColor: Colors.white,
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
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          snapShot?.data?.data?.action?.name == null
                              ? const SizedBox()
                              : Row(
                                  children: [
                                    Icon(
                                      Icons.electric_bolt_rounded,
                                      color: snapShot.data!.data.action.color ==
                                              ''
                                          ? Colors.transparent
                                          : Color(int.parse(
                                              '0xFF${snapShot.data!.data.action.color.toString().substring(1)}')),
                                      size: 20,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      snapShot?.data?.data?.action?.name ?? '',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: snapShot
                                                    .data!.data.action.color ==
                                                ''
                                            ? Colors.transparent
                                            : Color(int.parse(
                                                '0xFF${snapShot.data!.data.action.color.toString().substring(1)}')),
                                      ),
                                    ),
                                  ],
                                )
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          if ((snapShot.data?.data.pickerStartDate ?? '') ==
                              (snapShot.data?.data.prickerEndDate ?? '')) {
                            endDatePicker = snapShot.data!.data.prickerEndDate
                                .add(const Duration(seconds: 1));
                          } else {
                            endDatePicker = snapShot.data!.data.prickerEndDate;
                          }
                          if (snapShot.data!.data.seats == 'seats') {
                            navigator(
                                context: context,
                                screen: DatePickerScreen(
                                  navigateScreen: 'seats',
                                  eventId: snapShot.data!.data.id.toString(),
                                  startDate: snapShot.data?.data.pickerStartDate
                                          .toString() ??
                                      '',
                                  endDate: endDatePicker.toString() ?? '',
                                ));
                          } else if (snapShot.data!.data.seats == 'tickets') {
                            navigator(
                                context: context,
                                screen: DatePickerScreen(
                                  navigateScreen: 'tickets',
                                  eventId: snapShot.data!.data.id.toString(),
                                  startDate: snapShot.data?.data.pickerStartDate
                                          .toString() ??
                                      '',
                                  endDate: endDatePicker.toString() ?? '',
                                ));
                          } else {
                            // navigator(
                            //     context: context,
                            //     screen: WebViewScreen(
                            //       link: snapShot.data!.data.seats.toString(),
                            //     ));
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: screenWidth / 2,
                          height: 50,
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            UserData.translation.data?.tickets?.toString() ??
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
                  child: Column(
                    children: [
                      SecondAppBar(
                        title: snapShot.data?.data.name.toString() ?? '',
                        shareAndFav: true,
                        backToHome: false,
                      ),
                      Expanded(
                        child: ListView(
                          children: [
                            Container(
                              width: screenWidth,
                              height: screenHeight / 3.5,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fill,
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
                                  const SizedBox(
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
                                        style: const TextStyle(
                                            color: kDarkGreyColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        snapShot?.data?.data?.time ?? '',
                                        style: const TextStyle(
                                            color: kLightGreyColor,
                                            fontSize: 14),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          final Event event = Event(
                                            title: snapShot.data!.data.name,
                                            description:
                                                snapShot.data!.data.description,
                                            location:
                                                snapShot.data!.data.address,
                                            startDate: snapShot
                                                .data!.data.pickerStartDate,
                                            endDate: snapShot
                                                .data!.data.prickerEndDate,
                                          );
                                          Add2Calendar.addEvent2Cal(event);
                                        },
                                        child: Text(
                                          UserData.translation.data
                                                  ?.addToCalender
                                                  ?.toString() ??
                                              'Add to calender',
                                          style: TextStyle(
                                              color: kPrimaryColor,
                                              fontSize: 14),
                                        ),
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
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        UserData.translation.data?.address
                                                ?.toString() ??
                                            'Address',
                                        style: TextStyle(
                                            color: kDarkGreyColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        width: screenWidth / 1.3,
                                        child: Text(
                                          snapShot?.data?.data?.address ?? '',
                                          style: const TextStyle(
                                              color: kLightGreyColor,
                                              fontSize: 14,
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          navigator(
                                              context: context,
                                              screen: MapViewScreen(
                                                lat: lat!,
                                                lng: lng!,
                                                title: snapShot.data!.data.name,
                                                desc: snapShot
                                                    .data!.data.description,
                                              ));
                                        },
                                        child: Text(
                                          UserData.translation.data?.viewMap
                                                  ?.toString() ??
                                              'View Map',
                                          style: TextStyle(
                                              color: kPrimaryColor,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                  left: 15.0, right: 15, bottom: 5),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'About This Event',
                                    style: TextStyle(
                                        color: kDarkGreyColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15),
                                child: Opacity(
                                  opacity: 0.7,
                                  child:
                                      MyHtmlParser.parseHtmlToListOfTextWidgets(
                                          snapShot.data?.data.description ??
                                              '')[0],
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 15.0, right: 15, bottom: 5),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    UserData.translation.data?.location
                                            ?.toString() ??
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
                              child: GoogleMap(
                                mapType: MapType.normal,
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(lat!, lng!),
                                  zoom: 14.4746,
                                ),
                                markers: marker,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
        }
      },
    );
  }
}
