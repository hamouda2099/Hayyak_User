import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/Config/user_data.dart';
import 'package:hayyak/Dialogs/loading_screen.dart';
import 'package:hayyak/Dialogs/message_dialog.dart';
import 'package:hayyak/Logic/Services/api_manger.dart';
import 'package:hayyak/Models/event_seats_model.dart';
import 'package:hayyak/UI/Components/image_viewer.dart';
import 'package:hayyak/UI/Components/seat_category_component.dart';
import 'package:hayyak/UI/Screens/checkout_screen.dart';
import 'package:hayyak/main.dart';

import '../../Dialogs/loading_dialog.dart';
import 'home_screen.dart';

final cartCounterProvider = StateProvider<int>((ref) => 0);
final totalPriceProvider = StateProvider<double>((ref) => 0.0);

class EventSeatsScreen extends StatelessWidget {
  EventSeatsScreen(
      {required this.selectedDate, required this.eventId, this.eventIsFav});

  final tabProvider = StateProvider<String>((ref) => 'tickets');
  String selectedDate = '';
  String eventId = '';
  bool? eventIsFav;

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
              return Scaffold(
                  body: Center(
                      child: Text(UserData
                              .translation.data?.noInternetConnection
                              ?.toString() ??
                          'Error: ${snapShot.error}')));
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
                            UserData.translation.data?.totalPrice?.toString() ??
                                'Total Price',
                            style: const TextStyle(
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
                          if (globalSelectedSeats.isEmpty) {
                            messageDialog(
                                context,
                                UserData.translation.data
                                        ?.pleaseChooseTheCurrentSeat
                                        ?.toString() ??
                                    "Please select seats");
                          } else {
                            navigator(
                                context: context,
                                screen: CheckoutScreen(
                                  vat: snapShot.data?.data?.event?.details?.vat,
                                  fees: snapShot
                                      .data?.data?.event?.details?.eventFees,
                                  receitType: 'seats',
                                  total: totalPriceProvider,
                                  selectedDate: selectedDate,
                                  eventId: eventId,
                                  selectedTickets: globalSelectedSeats,
                                  selectedServices: globalSelectedSeatsServices,
                                  eventTime: snapShot
                                          .data?.data?.event?.details?.time ??
                                      '',
                                  eventDate: snapShot.data?.data?.event?.details
                                          ?.startDate ??
                                      '',
                                  eventName: snapShot
                                          .data?.data?.event?.details?.name ??
                                      '',
                                  eventImage: snapShot
                                          .data?.data?.event?.details?.image ??
                                      '',
                                ));
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: screenWidth / 1.5,
                          height: 50,
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            UserData.translation.data?.checkout?.toString() ??
                                'Checkout',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
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
                                      localLanguage == 'en'
                                          ? 'assets/icon/back.svg'
                                          : 'assets/icon/back_ar.svg'),
                                ),
                              ),
                              Text(
                                UserData.translation.data?.seats?.toString() ??
                                    "Seats",
                                style: TextStyle(
                                    color: kDarkGreyColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              InkWell(
                                onTap: () {
                                  if (UserData.id == null) {
                                    messageDialog(
                                        context,
                                        UserData.translation.data
                                                ?.pleaseLoginFirst
                                                ?.toString() ??
                                            'Please Login to Add to Favourites !');
                                  } else {
                                    if (eventIsFav ?? false) {
                                      loadingDialog(context);
                                      ApiManger.removeFromFav(
                                              id: eventId.toString())
                                          .then((value) {
                                        Navigator.pop(context);
                                        if (value['success']) {
                                          navigator(
                                              context: context,
                                              screen: HomeScreen(),
                                              replacement: true);
                                        } else {
                                          messageDialog(
                                              context, 'An error occurred');
                                        }
                                      });
                                    } else {
                                      loadingDialog(context);
                                      ApiManger.addToFav(
                                              eventId: eventId.toString())
                                          .then((value) {
                                        Navigator.pop(context);
                                        if (value['success']) {
                                          navigator(
                                              context: context,
                                              screen: HomeScreen(),
                                              replacement: true);
                                        } else {
                                          messageDialog(
                                              context, 'An Error Occurred');
                                        }
                                      });
                                    }
                                  }
                                },
                                child: (eventIsFav ?? false)
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            left: 1.0, right: 1),
                                        child: SvgPicture.asset(
                                            color: kLightGreyColor,
                                            width: 20,
                                            height: 20,
                                            'assets/icon/solid_heart.svg'),
                                      )
                                    : Padding(
                                        padding: EdgeInsets.only(
                                            left: 1.0, right: 1),
                                        child: SvgPicture.asset(
                                            color: kLightGreyColor,
                                            width: 13,
                                            height: 13,
                                            'assets/icon/Icon feather-heart.svg'),
                                      ),
                              )
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
                                    url: snapShot.data!.data?.event?.details
                                            ?.seatsMapImage ??
                                        '',
                                  ));
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: Image(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(snapShot.data?.data
                                              ?.event?.details?.seatsMapImage ??
                                          '')),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.zoom_in,
                                    color: Colors.black.withOpacity(0.4),
                                    size: screenWidth / 4,
                                  ),
                                )
                              ],
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: screenWidth / 15, right: screenWidth / 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                UserData.translation.data?.tickets
                                        ?.toString() ??
                                    'Bookings',
                                style: const TextStyle(
                                    color: kDarkGreyColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                UserData.translation.data?.price?.toString() ??
                                    'Price',
                                style: TextStyle(
                                    color: kDarkGreyColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: List.generate(
                              snapShot.data!.data!.event!.kinds!.length,
                              (index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: SeatCategoryComponent(
                                seatCategory:
                                    snapShot.data!.data!.event!.kinds![index],
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
                        snapShot.data?.data?.event?.services?.length == 0
                            ? SizedBox()
                            : Align(
                                alignment: localLanguage == 'en'
                                    ? Alignment.topLeft
                                    : Alignment.topRight,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: screenWidth / 15,
                                      right: screenWidth / 15),
                                  child: Text(
                                    UserData.translation.data?.services
                                            ?.toString() ??
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
                              snapShot.data?.data?.event?.services?.length ?? 0,
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
                                                        .data!
                                                        .event!
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
                                                    .data!
                                                    .event!
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
                                                        .data!
                                                        .event!
                                                        .services![index]
                                                        .finalCost!;
                                                globalSelectedSeatsServices
                                                    .removeWhere((element) =>
                                                        element['service']
                                                            ['id'] ==
                                                        snapShot
                                                            .data!
                                                            .data!
                                                            .event!
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
                                                        .data!
                                                        .event!
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
                                                          .data!
                                                          .event!
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
                                                        .data!
                                                        .event!
                                                        .services![index]
                                                        .finalCost!;
                                                if (globalSelectedSeatsServices
                                                    .isEmpty) {
                                                  globalSelectedSeatsServices
                                                      .add({
                                                    "service": snapShot
                                                        .data!
                                                        .data!
                                                        .event!
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
                                                              .data!
                                                              .event!
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
                                                          .data!
                                                          .event!
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
