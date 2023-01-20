import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/Dialogs/loading_screen.dart';
import 'package:hayyak/Logic/Services/api_manger.dart';
import 'package:hayyak/Models/event_tickets_model.dart';
import 'package:hayyak/UI/Components/seccond_app_bar.dart';
import 'package:hayyak/UI/Screens/checkout_screen.dart';
import 'package:hayyak/main.dart';

import '../../Config/constants.dart';
import '../../Config/date_formatter.dart';

class EventTicketsScreen extends StatelessWidget {
  EventTicketsScreen({required this.selectedDate, required this.eventId});
  String selectedDate = '';
  String eventId = '';
  List cart = [];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<EventTicketsModel>(
      future: ApiManger.getEventTickets(
          date: selectedDate.substring(0, 10), eventId: eventId),
      builder:
          (BuildContext context, AsyncSnapshot<EventTicketsModel> snapShot) {
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
                        children: const [
                          Text(
                            'Total Price',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '201.0 SAR',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          // showDialog(
                          //   context: context,
                          //   builder: (context) {
                          //     return AlertDialog(
                          //       title: const Text(
                          //         'Cart',
                          //         style: TextStyle(color: kDarkGreyColor),
                          //       ),
                          //       content: Container(
                          //         width: screenWidth / 1.2,
                          //         height: screenHeight / 1.5,
                          //         child: ListView.builder(
                          //           itemCount: cart.length,
                          //           itemBuilder: (context, index) {
                          //             return Container(
                          //               child: Row(
                          //                 crossAxisAlignment:
                          //                 CrossAxisAlignment.start,
                          //                 mainAxisAlignment:
                          //                 MainAxisAlignment.spaceBetween,
                          //                 children: [
                          //                   Row(
                          //                     crossAxisAlignment:
                          //                     CrossAxisAlignment.start,
                          //                     children: [
                          //                       SvgPicture.asset(
                          //                           color: Color(int.parse(
                          //                               '0xFF${snapShot.data!.data.event.kinds[index].color.toString().substring(1)}')),
                          //                           width: 25,
                          //                           height: 25,
                          //                           'assets/icon/ticket.svg'),
                          //                       const SizedBox(
                          //                         width: 10,
                          //                       ),
                          //                       Column(
                          //                         crossAxisAlignment:
                          //                         CrossAxisAlignment.start,
                          //                         children: [
                          //                           Container(
                          //                             width:screenWidth/3,
                          //                             child: Text(
                          //                               cart[index],
                          //                               style: TextStyle(
                          //                                   color: Color(int.parse(
                          //                                       '0xFF${snapShot.data!.data.event.kinds[index].color.toString().substring(1)}')),
                          //                                   fontSize: 14),
                          //                             ),
                          //                           ),
                          //                           const SizedBox(
                          //                             width: 20,
                          //                           ),
                          //                           Text(
                          //                             snapShot
                          //                                 .data!
                          //                                 .data
                          //                                 .event
                          //                                 .kinds[index]
                          //                                 .costAfterDiscount,
                          //                             style: const TextStyle(
                          //                                 color: kLightGreyColor,
                          //                                 fontSize: 14,
                          //                                 fontWeight:
                          //                                 FontWeight.bold),
                          //                           )
                          //                         ],
                          //                       ),
                          //                     ],
                          //                   ),
                          //                   Row(
                          //                     children: [
                          //                       Text(
                          //                         'counter',
                          //                         style: const TextStyle(
                          //                             color: kLightGreyColor,
                          //                             fontSize: 16),
                          //                       ),
                          //                       const SizedBox(
                          //                         width: 12,
                          //                       ),
                          //                       InkWell(
                          //                         onTap: () {
                          //                           cart.removeAt(cart[index]);
                          //                         },
                          //                         child: Container(
                          //                           padding: const EdgeInsets.all(5),
                          //                           decoration: const BoxDecoration(
                          //                             shape: BoxShape.circle,
                          //                             color: Colors.red,
                          //                           ),
                          //                           child: const Icon(
                          //                             Icons.remove,
                          //                             color: Colors.white,
                          //                             size: 20,
                          //                           ),
                          //                         ),
                          //                       ),
                          //                     ],
                          //                   ),
                          //                 ],
                          //               ),
                          //             );
                          //           },
                          //         ),
                          //       ),
                          //     );
                          //   },
                          // );
                        },
                        child: SvgPicture.asset(
                            color: Colors.white,
                            width: 25,
                            height: 25,
                            'assets/icon/Icon feather-shopping-cart.svg'),
                      ),
                      InkWell(
                        onTap: () {
                          navigator(
                              context: context, screen: const CheckoutScreen());
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
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SecondAppBar(
                          title: snapShot.data!.data.event.details.name),
                      Container(
                        width: screenWidth / 1.2,
                        height: screenHeight / 5,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                  snapShot.data!.data.event.details.image)),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        width: screenWidth / 1.3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                    color: kDarkGreyColor,
                                    width: 10,
                                    height: 15,
                                    'assets/icon/Icon material-event.svg'),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  dateFormatter(selectedDate),
                                  style: const TextStyle(
                                      color: kLightGreyColor, fontSize: 14),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.access_time_outlined,
                                  color: kDarkGreyColor,
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  snapShot.data!.data.event.details.time,
                                  style: const TextStyle(
                                      color: kLightGreyColor, fontSize: 14),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                            left: 30.0, right: 30, top: 10, bottom: 10),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Tickets',
                              style: TextStyle(
                                  color: kLightGreyColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                      Container(
                        padding: const EdgeInsets.all(15),
                        height: screenHeight / 3.5,
                        child: ListView.builder(
                          itemCount: snapShot.data!.data.event.kinds.length,
                          itemBuilder: (context, index) {
                            final counterProvider = StateProvider((ref) => 0);
                            final submittedProvider =
                                StateProvider<bool>((ref) => false);
                            return Consumer(
                              builder: (context, watch, child) {
                                final counter = watch(counterProvider).state;
                                final submitted =
                                    watch(submittedProvider).state;
                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: submitted
                                      ? Row(
                                          children: [
                                            SvgPicture.asset(
                                                color: Color(int.parse(
                                                    '0xFF${snapShot.data!.data.event.kinds[index].color.toString().substring(1)}')),
                                                width: 25,
                                                height: 25,
                                                'assets/icon/ticket.svg'),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Tickets Added to Cart',
                                              style: TextStyle(
                                                color: Color(int.parse(
                                                    '0xFF${snapShot.data!.data.event.kinds[index].color.toString().substring(1)}')),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Row(
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
                                                    color: Color(int.parse(
                                                        '0xFF${snapShot.data!.data.event.kinds[index].color.toString().substring(1)}')),
                                                    width: 25,
                                                    height: 25,
                                                    'assets/icon/ticket.svg'),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: screenWidth / 3,
                                                      child: Text(
                                                        snapShot
                                                            .data!
                                                            .data
                                                            .event
                                                            .kinds[index]
                                                            .name,
                                                        style: TextStyle(
                                                            color: Color(int.parse(
                                                                '0xFF${snapShot.data!.data.event.kinds[index].color.toString().substring(1)}')),
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 20,
                                                    ),
                                                    Text(
                                                      snapShot
                                                          .data!
                                                          .data
                                                          .event
                                                          .kinds[index]
                                                          .costAfterDiscount,
                                                      style: const TextStyle(
                                                          color:
                                                              kLightGreyColor,
                                                          fontSize: 14,
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
                                                      context
                                                          .read(counterProvider)
                                                          .state--;
                                                    }
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    decoration:
                                                        const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: kLightGreyColor,
                                                    ),
                                                    child: const Icon(
                                                      Icons.remove,
                                                      color: Colors.white,
                                                      size: 20,
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
                                                      fontSize: 16),
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
                                                            .kinds[index]
                                                            .countLimit) {
                                                    } else {
                                                      context
                                                          .read(counterProvider)
                                                          .state++;
                                                    }
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    decoration:
                                                        const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.blue,
                                                    ),
                                                    child: const Icon(
                                                      Icons.add,
                                                      color: Colors.white,
                                                      size: 20,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 12,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    cart.add({
                                                      "item": snapShot
                                                          .data!
                                                          .data
                                                          .event
                                                          .kinds[index],
                                                      "count": counter,
                                                      "type": "ticket"
                                                    });
                                                    context
                                                        .read(submittedProvider)
                                                        .state = true;
                                                    print(cart);
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    decoration:
                                                        const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.green,
                                                    ),
                                                    child: const Icon(
                                                      Icons
                                                          .add_shopping_cart_rounded,
                                                      color: Colors.white,
                                                      size: 20,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      Container(
                        width: screenWidth / 1.3,
                        height: 1,
                        color: Colors.grey,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                            left: 30.0, right: 30, top: 10, bottom: 10),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Services',
                              style: TextStyle(
                                  color: kLightGreyColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                      Container(
                        padding: const EdgeInsets.all(15),
                        height: screenHeight / 3.5,
                        child: ListView.builder(
                          itemCount: snapShot.data!.data.event.services.length,
                          itemBuilder: (context, index) {
                            final counterProvider = StateProvider((ref) => 0);
                            final submittedProvider =
                                StateProvider<bool>((ref) => false);
                            return Consumer(
                              builder: (context, watch, child) {
                                final counter = watch(counterProvider).state;
                                final submitted =
                                    watch(submittedProvider).state;
                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: submitted
                                      ? Row(
                                          children: [
                                            SvgPicture.asset(
                                                color: Colors.grey,
                                                width: 25,
                                                height: 25,
                                                'assets/icon/ticket.svg'),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            const Text(
                                              'Services Added to Cart',
                                              style: TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        )
                                      : Row(
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
                                                    width: 25,
                                                    height: 25,
                                                    'assets/icon/dinner.svg'),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      snapShot.data!.data.event
                                                          .services[index].name,
                                                      style: const TextStyle(
                                                          color:
                                                              kLightGreyColor,
                                                          fontSize: 16),
                                                    ),
                                                    const SizedBox(
                                                      width: 20,
                                                    ),
                                                    Text(
                                                      snapShot
                                                          .data!
                                                          .data
                                                          .event
                                                          .services[index]
                                                          .costAfterDiscount,
                                                      style: const TextStyle(
                                                          color:
                                                              kLightGreyColor,
                                                          fontSize: 14,
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
                                                      context
                                                          .read(counterProvider)
                                                          .state--;
                                                    }
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    decoration:
                                                        const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: kLightGreyColor,
                                                    ),
                                                    child: const Icon(
                                                      Icons.remove,
                                                      color: Colors.white,
                                                      size: 20,
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
                                                      fontSize: 16),
                                                ),
                                                const SizedBox(
                                                  width: 12,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    context
                                                        .read(counterProvider)
                                                        .state++;
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    decoration:
                                                        const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.blue,
                                                    ),
                                                    child: const Icon(
                                                      Icons.add,
                                                      color: Colors.white,
                                                      size: 20,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 12,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    cart.add({
                                                      "item": snapShot
                                                          .data!
                                                          .data
                                                          .event
                                                          .services[index],
                                                      "count": counter,
                                                      "type": "service"
                                                    });
                                                    context
                                                        .read(submittedProvider)
                                                        .state = true;
                                                    print(cart);
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    decoration:
                                                        const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.green,
                                                    ),
                                                    child: const Icon(
                                                      Icons
                                                          .add_shopping_cart_rounded,
                                                      color: Colors.white,
                                                      size: 20,
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
                          },
                        ),
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
