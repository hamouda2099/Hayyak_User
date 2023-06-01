import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/Config/user_data.dart';
import 'package:hayyak/Dialogs/loading_screen.dart';
import 'package:hayyak/Logic/Services/api_manger.dart';
import 'package:hayyak/Models/event_seats_model.dart';
import 'package:hayyak/UI/Components/image_viewer.dart';
import 'package:hayyak/UI/Components/seat_category_component.dart';
import 'package:hayyak/UI/Screens/checkout_screen.dart';
import 'package:hayyak/UI/Screens/notifications_screen.dart';
import 'package:hayyak/main.dart';
// import 'package:share/share.dart';

final cartCounterProvider = StateProvider<int>((ref) => 0);
final totalPriceProvider = StateProvider<double>((ref) => 0.0);

class EventSeatsScreen extends StatelessWidget {
  EventSeatsScreen({required this.selectedDate, required this.eventId});

  final tabProvider = StateProvider<String>((ref) => 'tickets');
  String selectedDate = '';
  String eventId = '';

  @override
  Widget build(BuildContext context) {
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
                          const Text(
                            'Total Price',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Consumer(
                            builder: (context, ref, child) {
                              ref.watch(totalPriceProvider);
                              return Text(
                                '${ref.read(totalPriceProvider.notifier).state} SAR',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              );
                            },
                          )
                        ],
                      ),
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0, right: 5),
                            child: SvgPicture.asset(
                                color: Colors.white,
                                width: 25,
                                height: 25,
                                'assets/icon/Icon feather-shopping-cart.svg'),
                          ),
                          Consumer(
                            builder: (context, ref, child) {
                              final cartCounter =
                                  ref.watch(cartCounterProvider);
                              return Container(
                                alignment: Alignment.center,
                                width: 15,
                                height: 15,
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  cartCounter.toString(),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 8),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          print(globalSelectedSeats);

                          navigator(
                              context: context,
                              screen: CheckoutScreen(
                                receitType: 'seats',
                                total: totalPriceProvider,
                                selectedDate: selectedDate,
                                eventId: eventId,
                                selectedTickets: globalSelectedSeats,
                                selectedServices: globalSelectedSeatsServices,
                                eventTime:
                                    snapShot.data?.data.event.details.time ??
                                        '',
                                eventDate: snapShot
                                        .data?.data.event.details.startDate ??
                                    '',
                                eventName:
                                    snapShot.data?.data.event.details.name ??
                                        '',
                                eventImage:
                                    snapShot.data?.data.event.details.image ??
                                        '',
                              ));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: screenWidth / 2,
                          height: 35,
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Text(
                            'Checkout',
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
                    Consumer(
                      builder: (context, ref, child) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  ref.read(cartCounterProvider.notifier).state =
                                      0;
                                  ref.read(totalPriceProvider.notifier).state =
                                      0.0;
                                  Navigator.pop(context);
                                },
                                icon: SizedBox(
                                  width: 15,
                                  height: 15,
                                  child: SvgPicture.asset(
                                      color: kDarkGreyColor,
                                      width: 25,
                                      height: 25,
                                      'assets/icon/back.svg'),
                                ),
                              ),
                              const Text(
                                "Seats",
                                style: TextStyle(
                                    color: kDarkGreyColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              UserData.token == ''
                                  ? Row(
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              // Share.share('https://hayyak.net/', subject: 'Seats');
                                            },
                                            child: const Icon(
                                              Icons.file_upload_outlined,
                                              size: 20,
                                              color: kDarkGreyColor,
                                            )),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            navigator(
                                                context: context,
                                                screen:
                                                    const NotificationsScreen());
                                          },
                                          child: SizedBox(
                                            width: 15,
                                            height: 15,
                                            child: SvgPicture.asset(
                                                color: kDarkGreyColor,
                                                'assets/icon/Icon feather-heart.svg'),
                                          ),
                                        ),
                                      ],
                                    )
                                  : IconButton(
                                      onPressed: () {
                                        navigator(
                                            context: context,
                                            screen:
                                                const NotificationsScreen());
                                      },
                                      icon: const Icon(Icons.notifications),
                                      color: kDarkGreyColor,
                                      iconSize: 25,
                                    ),
                            ],
                          ),
                        );
                      },
                    ),
                    Expanded(
                        child: ListView(
                      children: [
                        InkWell(
                          onTap: () {
                            navigator(
                                context: context,
                                screen: ImageViewer(
                                  url: snapShot.data!.data.event.details.image,
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
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.0, top: 10),
                            child: Text(
                              'Tickets',
                              style: TextStyle(
                                  color: kDarkGreyColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Column(
                          children: List.generate(
                              snapShot.data!.data.event.kinds.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: SeatCategoryComponent(
                                seatCategory:
                                    snapShot.data!.data.event.kinds[index],
                              ),
                            );
                          }),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: screenWidth / 1.1,
                          height: 1,
                          color: Colors.grey,
                        ),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.0, top: 10),
                            child: Text(
                              'Services',
                              style: TextStyle(
                                  color: kDarkGreyColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Column(
                          children: List.generate(
                              snapShot.data?.data.event.services?.length ?? 0,
                              (index) {
                            final counterProvider = StateProvider((ref) => 0);
                            return Consumer(
                              builder: (context, ref, child) {
                                final counter = ref.watch(counterProvider);
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 10, bottom: 10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SvgPicture.asset(
                                              color: kDarkGreyColor,
                                              width: 20,
                                              height: 20,
                                              'assets/icon/dinner.svg'),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                snapShot
                                                        .data!
                                                        .data
                                                        .event
                                                        .services![index]
                                                        .name ??
                                                    '',
                                                style: const TextStyle(
                                                    color: kLightGreyColor,
                                                    fontSize: 12),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                snapShot
                                                    .data!
                                                    .data
                                                    .event
                                                    .services![index]
                                                    .costAfterDiscount!,
                                                style: const TextStyle(
                                                    color: kLightGreyColor,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              if (counter != 0) {
                                                ref
                                                    .read(counterProvider
                                                        .notifier)
                                                    .state--;
                                                ref
                                                    .read(cartCounterProvider
                                                        .notifier)
                                                    .state--;
                                                ref
                                                    .read(totalPriceProvider
                                                        .notifier)
                                                    .state = ref
                                                        .read(totalPriceProvider
                                                            .notifier)
                                                        .state -
                                                    snapShot
                                                        .data!
                                                        .data
                                                        .event
                                                        .services![index]
                                                        .finalCost!;
                                                print(snapShot.data!.data.event
                                                    .services![index].id);
                                                globalSelectedSeatsServices
                                                    .removeWhere((element) =>
                                                        element['service']
                                                            ['id'] ==
                                                        snapShot
                                                            .data!
                                                            .data
                                                            .event
                                                            .services![index]
                                                            .id);
                                                if (ref
                                                        .read(counterProvider
                                                            .notifier)
                                                        .state !=
                                                    0) {
                                                  globalSelectedSeatsServices
                                                      .add({
                                                    "service": snapShot
                                                        .data!
                                                        .data
                                                        .event
                                                        .services![index]
                                                        .toJson(),
                                                    "count": ref
                                                        .read(counterProvider
                                                            .notifier)
                                                        .state
                                                  });
                                                }
                                              }
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(5),
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: kLightGreyColor,
                                              ),
                                              child: const Icon(
                                                Icons.remove,
                                                color: Colors.white,
                                                size: 12,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          Text(
                                            counter.toString(),
                                            style: const TextStyle(
                                                color: kLightGreyColor,
                                                fontSize: 14),
                                          ),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              if (counter ==
                                                  snapShot
                                                          .data!
                                                          .data
                                                          .event
                                                          .services![index]
                                                          .countLimit! +
                                                      1) {
                                              } else {
                                                ref
                                                    .read(counterProvider
                                                        .notifier)
                                                    .state++;
                                                ref
                                                    .read(cartCounterProvider
                                                        .notifier)
                                                    .state++;
                                                ref
                                                    .read(totalPriceProvider
                                                        .notifier)
                                                    .state = ref
                                                        .read(totalPriceProvider
                                                            .notifier)
                                                        .state +
                                                    snapShot
                                                        .data!
                                                        .data
                                                        .event
                                                        .services![index]
                                                        .finalCost!;
                                                if (globalSelectedSeatsServices
                                                    .isEmpty) {
                                                  globalSelectedSeatsServices
                                                      .add({
                                                    "service": snapShot
                                                        .data!
                                                        .data
                                                        .event
                                                        .services![index]
                                                        .toJson(),
                                                    "count": ref
                                                        .read(counterProvider
                                                            .notifier)
                                                        .state
                                                  });
                                                } else {
                                                  globalSelectedSeatsServices
                                                      .removeWhere((element) =>
                                                          element['service']
                                                              ['id'] ==
                                                          snapShot
                                                              .data!
                                                              .data
                                                              .event
                                                              .services![index]
                                                              .id);
                                                  if (ref
                                                          .read(counterProvider
                                                              .notifier)
                                                          .state !=
                                                      0) {
                                                    globalSelectedSeatsServices
                                                        .add({
                                                      "service": snapShot
                                                          .data!
                                                          .data
                                                          .event
                                                          .services![index]
                                                          .toJson(),
                                                      "count": ref
                                                          .read(counterProvider
                                                              .notifier)
                                                          .state
                                                    });
                                                  }
                                                }
                                              }
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(5),
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: kPrimaryColor,
                                              ),
                                              child: const Icon(
                                                Icons.add,
                                                color: Colors.white,
                                                size: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          }),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ))
                  ],
                )),
              );
            }
        }
      },
    );
  }
}
