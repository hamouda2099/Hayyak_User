import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/Dialogs/loading_screen.dart';
import 'package:hayyak/Dialogs/message_dialog.dart';
import 'package:hayyak/Logic/Services/api_manger.dart';
import 'package:hayyak/Logic/UI%20Logic/event_tickets_logic.dart';
import 'package:hayyak/Models/event_tickets_model.dart';
import 'package:hayyak/UI/Components/seccond_app_bar.dart';
import 'package:hayyak/UI/Components/ticket_component_tickets_details.dart';
import 'package:hayyak/UI/Screens/checkout_screen.dart';
import 'package:hayyak/main.dart';

import '../../Config/constants.dart';
import '../../Config/date_formatter.dart';
import '../Components/services_component_tickets_details.dart';

final pageProvider = StateProvider<int>((ref) => 1);
List selectedTickets = [];
List selectedServices = [];

class EventTicketsScreen extends StatelessWidget {
  EventTicketsScreen(
      {super.key, required this.selectedDate, required this.eventId});

  EventTicketsLogic logic = EventTicketsLogic();
  String selectedDate = '';
  String eventId = '';
  List cart = [];
  final cartCounterProvider = StateProvider<int>((ref) => 0);
  final tabProvider = StateProvider<String>((ref) => 'tickets');
  final totalPriceProvider = StateProvider<double>((ref) => 0.0);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final page = ref.watch(pageProvider);
        return FutureBuilder<EventTicketsModel>(
          future: ApiManger.getEventTickets(
              page: page,
              date: selectedDate.substring(0, 10),
              eventId: eventId),
          builder: (BuildContext context,
              AsyncSnapshot<EventTicketsModel> snapShot) {
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
                  return Scaffold(
                    bottomNavigationBar: Container(
                      width: screenWidth / 1,
                      height: screenHeight / 10,
                      color: kDarkGreyColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
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
                                padding:
                                    const EdgeInsets.only(top: 5.0, right: 5),
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
                              if (selectedTickets.isEmpty) {
                                messageDialog(context,
                                    'Please select one ticket at least');
                              } else {
                                navigator(
                                    context: context,
                                    screen: CheckoutScreen(
                                      fees: snapShot
                                          .data?.data.event.details.eventFees,
                                      vat:
                                          snapShot.data?.data.event.details.vat,
                                      receitType: 'tickets',
                                      total: totalPriceProvider,
                                      selectedDate: selectedDate,
                                      eventId: eventId,
                                      eventName: snapShot
                                              .data?.data.event.details.name ??
                                          '',
                                      eventDate: dateFormatter(selectedDate),
                                      eventTime: snapShot
                                              .data?.data.event.details.time ??
                                          '',
                                      eventImage: snapShot
                                              .data?.data.event.details.image ??
                                          '',
                                      selectedTickets: selectedTickets ?? [],
                                      selectedServices: selectedServices ?? [],
                                    ));
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: screenWidth / 1.7,
                              height: 50,
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
                        SecondAppBar(
                            title: snapShot.data!.data.event.details.name,
                            shareAndFav: false,
                            backToHome: false),
                        Expanded(
                          child: ListView(
                            children: [
                              Container(
                                width: screenWidth / 1.1,
                                height: screenHeight / 6,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(snapShot
                                          .data!.data.event.details.image)),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(10),
                                width: screenWidth / 1.3,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                            color: kLightGreyColor
                                                .withOpacity(0.3),
                                            width: 10,
                                            height: 15,
                                            'assets/icon/Icon material-event.svg'),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          dateFormatter(selectedDate),
                                          style: const TextStyle(
                                              color: kDarkGreyColor,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.access_time_outlined,
                                          color:
                                              kLightGreyColor.withOpacity(0.3),
                                          size: 20,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          snapShot
                                              .data!.data.event.details.time,
                                          style: const TextStyle(
                                              color: kDarkGreyColor,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              snapShot.data!.data.event.kinds.isEmpty
                                  ? const SizedBox()
                                  : const Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 20.0, top: 10),
                                        child: Text(
                                          'Tickets',
                                          style: TextStyle(
                                              color: kDarkGreyColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                              Column(
                                children: List.generate(
                                    snapShot.data!.data.event.kinds.length,
                                    (index) {
                                  return TicketComponentInTicketDetails(
                                    totalProvider: totalPriceProvider,
                                    logic: logic,
                                    cartProvider: cartCounterProvider,
                                    kind:
                                        snapShot.data!.data.event.kinds[index],
                                  );
                                }),
                              ),
                              Container(
                                width: screenWidth / 1.1,
                                height: 1,
                                color: Colors.grey,
                              ),
                              snapShot.data!.data.event.services.isEmpty
                                  ? const SizedBox(
                                      height: 20,
                                    )
                                  : const Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 20.0, top: 10),
                                        child: Text(
                                          'Services',
                                          style: TextStyle(
                                              color: kDarkGreyColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                              Column(
                                children: List.generate(
                                    snapShot.data!.data.event.services.length,
                                    (index) {
                                  return ServicesComponentInTicketDetails(
                                    totalProvider: totalPriceProvider,
                                    logic: logic,
                                    cartProvider: cartCounterProvider,
                                    service: snapShot
                                        .data!.data.event.services[index],
                                  );
                                }),
                              )
                            ],
                          ),
                        ),
                      ],
                    )),
                  );
                }
            }
          },
        );
      },
    );
  }
}
