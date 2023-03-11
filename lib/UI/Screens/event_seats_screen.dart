import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/Config/test_static_data.dart';
import 'package:hayyak/Dialogs/loading_screen.dart';
import 'package:hayyak/Logic/Services/api_manger.dart';
import 'package:hayyak/Models/event_seats_model.dart';
import 'package:hayyak/UI/Components/bottom_nav_bar.dart';
import 'package:hayyak/UI/Components/chair_component.dart';
import 'package:hayyak/UI/Components/image_viewer.dart';
import 'package:hayyak/UI/Components/seat_category_component.dart';
import 'package:hayyak/UI/Components/seccond_app_bar.dart';
import 'package:hayyak/main.dart';
import 'package:photo_view/photo_view.dart';

class EventSeatsScreen extends StatelessWidget {
  EventSeatsScreen({required this.selectedDate, required this.eventId});
  final tabProvider = StateProvider<String>((ref) => 'tickets');
  String selectedDate = '';
  String eventId = '';
  @override
  Widget build(BuildContext context) {
    print(eventId);
    print(selectedDate);
    return FutureBuilder<EventSeatsModel>(
      future: ApiManger.getEventSeats(
          date: selectedDate.substring(0, 10), eventId: eventId),
      builder: (BuildContext context, AsyncSnapshot<EventSeatsModel> snapShot) {
        switch (snapShot.connectionState) {
          case ConnectionState.waiting:
            {
              return Scaffold(
                body: Center(child: ScreenLoading()),
              );
            }
          default:
            if (snapShot.hasError) {
              print(snapShot);
              return Scaffold(
                  body: Center(child: Text('Error: ${snapShot.error}')));
            } else {
              print(snapShot.data!.data.event.kinds[0].tickets["A"][0]);
              return Scaffold(
                body: SafeArea(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SecondAppBar(title: 'Seats', shareAndFav: false),
                      InkWell(
                        onTap: () {
                         navigator(context: context,screen: ImageViewer(
                           url: snapShot
                               .data!.data.event.details.image ,
                         ));
                        },
                        child: Container(
                          width: double.infinity,
                          height: screenHeight / 4,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(snapShot
                                      .data!.data.event.details.image))),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Consumer(
                        builder: (context, watch, child) {
                          final tab = watch(tabProvider).state;
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        context.read(tabProvider).state =
                                            'tickets';
                                      },
                                      child: Text(
                                        'Tickets',
                                        style: TextStyle(
                                            color: tab == 'tickets'
                                                ? Colors.blue
                                                : kLightGreyColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        context.read(tabProvider).state =
                                            'services';
                                      },
                                      child: Text(
                                        'Services',
                                        style: TextStyle(
                                            color: tab == 'services'
                                                ? Colors.blue
                                                : kLightGreyColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: screenWidth / 1.3,
                                height: 1,
                                color: Colors.grey,
                              ),
                              tab == 'tickets'
                                  ? Column(
                                      children: List.generate(
                                          snapShot.data!.data.event.kinds
                                              .length, (index) {
                                        return SeatCategoryComponent(
                                          seatCategory: snapShot
                                              .data!.data.event.kinds[index],
                                        );
                                      }),
                                    )
                                  : Column(
                                      children: List.generate(
                                          TestDate().seatsCategory.length,
                                          (index) {
                                        final counterProvider =
                                            StateProvider((ref) => 0);
                                        return SeatCategoryComponent(
                                          seatCategory: snapShot
                                              .data!.data.event.kinds[index],
                                        );
                                      }),
                                    ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          alignment: Alignment.center,
                          width: screenWidth / 1.1,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'Checkout',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )),
              );
            }
        }
      },
    );
  }
}
