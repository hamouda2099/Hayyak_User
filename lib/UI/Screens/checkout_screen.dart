import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/Config/user_data.dart';
import 'package:hayyak/Logic/UI%20Logic/checkout_logic.dart';
import 'package:hayyak/Models/static_services_model.dart';
import 'package:hayyak/States/providers.dart';
import 'package:hayyak/UI/Components/custom_app_bar.dart';
import 'package:hayyak/UI/Components/seccond_app_bar.dart';
import 'package:hayyak/UI/Screens/event_seats_screen.dart';
import 'package:hayyak/main.dart';
import 'package:urwaypayment/urwaypayment.dart';

import '../../Dialogs/loading_screen.dart';
import '../../Logic/Services/api_manger.dart';
import '../../Models/aviable_for_sale_model.dart';

class CheckoutScreen extends StatelessWidget {
  CheckoutScreen(
      {required this.eventName,
      required this.eventImage,
      required this.eventDate,
      required this.eventTime,
      required this.selectedTickets,
      required this.selectedServices,
      required this.eventId,
      required this.selectedDate,
      required this.total});
  CheckoutLogic logic = CheckoutLogic();
  late String eventName,
      eventImage,
      eventDate,
      eventTime,
      eventId,
      selectedDate;
  List selectedTickets = [];
  List selectedServices = [];
  StateProvider total;
  CountDownController countDownController = CountDownController();
  @override
  Widget build(BuildContext context) {
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
                Row(
                  children: const [
                    Text(
                      'Total',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '(Incl. VAT)',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Consumer(
                  builder: (context, watch, child) {
                    watch(total).state;
                    watch(logic.totalAfterCoupon);
                    return Text(
                      context.read(logic.totalAfterCoupon).state == 0
                          ? '${context.read(total).state} SAR'
                          : '${context.read(logic.totalAfterCoupon).state} SAR',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    );
                  },
                )
              ],
            ),
            CircularCountDownTimer(
              controller: countDownController,
              width: 40,
              height: 40,
              duration: UserData.reservationTimer.toInt(),
              autoStart: true,
              isReverse: true,
              textStyle: const TextStyle(color: Colors.white, fontSize: 12),
              fillColor: kPrimaryColor,
              ringColor: kLightGreyColor,
              textFormat: CountdownTextFormat.MM_SS,
            ),
            InkWell(
              onTap: () {
                logic.onlinePayment(context: context);
              },
              child: Container(
                alignment: Alignment.center,
                width: screenWidth / 2,
                height: 50,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Text(
                  'Pay',
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
                title: 'Checkout', shareAndFav: false, backToHome: false),
            FutureBuilder(
              future: logic.initDataToCheckAvailable(
                  selectedTickets: selectedTickets,
                  selectedServices: selectedServices),
              builder: (BuildContext context, snapShot) {
                switch (snapShot.connectionState) {
                  case ConnectionState.waiting:
                    {
                      return Center(child: ScreenLoading());
                    }
                  default:
                    if (snapShot.hasError) {
                      return Text('Error: ${snapShot.error}');
                    } else {
                      return FutureBuilder<AvailableTicketsForSaleModel>(
                        future: ApiManger.getAvailableTicketsForSale(
                            eventId: eventId,
                            services: logic.services,
                            tickets: logic.tickets,
                            date: selectedDate),
                        builder: (BuildContext context,
                            AsyncSnapshot<AvailableTicketsForSaleModel>
                                snapShot) {
                          switch (snapShot.connectionState) {
                            case ConnectionState.waiting:
                              {
                                return Center(child: ScreenLoading());
                              }
                            default:
                              if (snapShot.hasError) {
                                print(snapShot);
                                return Text('Error: ${snapShot.error}');
                              } else {
                                print(snapShot.data?.toJson());
                                return SizedBox(
                                  width: screenWidth,
                                  height: screenHeight / 1.3,
                                  child: ListView(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 20, right: 20),
                                        width: screenWidth / 1.2,
                                        height: screenHeight / 7,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(eventImage)),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.all(10),
                                        width: screenWidth / 1.2,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(eventName,
                                                style: const TextStyle(
                                                    color: kDarkGreyColor,
                                                    fontSize: 12)),
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                    color: kDarkGreyColor,
                                                    width: 15,
                                                    height: 15,
                                                    'assets/icon/Icon material-event.svg'),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  eventDate,
                                                  style: const TextStyle(
                                                      color: kDarkGreyColor,
                                                      fontSize: 12),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.access_time_outlined,
                                                  color: kDarkGreyColor,
                                                  size: 15,
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  eventTime,
                                                  style: const TextStyle(
                                                      color: kDarkGreyColor,
                                                      fontSize: 12),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: List.generate(
                                            snapShot.data?.data?.ticketsInvoice
                                                    ?.length ??
                                                0,
                                            (index) => Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15.0,
                                                          left: 20.0,
                                                          right: 20),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            '${snapShot.data?.data?.ticketsInvoice?[index].count ?? ''}x',
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  kPrimaryColor,
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 20,
                                                          ),
                                                          Text(
                                                            snapShot
                                                                    .data
                                                                    ?.data
                                                                    ?.ticketsInvoice?[
                                                                        index]
                                                                    .name ??
                                                                '',
                                                            style: const TextStyle(
                                                                color:
                                                                    kDarkGreyColor,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          )
                                                        ],
                                                      ),
                                                      Text(
                                                        (snapShot
                                                                    .data
                                                                    ?.data
                                                                    ?.ticketsInvoice?[
                                                                        index]
                                                                    .finalCost
                                                                    .toString() ??
                                                                '') +
                                                            (snapShot
                                                                    .data
                                                                    ?.data
                                                                    ?.ticketsInvoice?[
                                                                        index]
                                                                    .currancy
                                                                    .toString() ??
                                                                ''),
                                                        style: const TextStyle(
                                                            color:
                                                                kDarkGreyColor,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    ],
                                                  ),
                                                )),
                                      ),
                                      Column(
                                        children: List.generate(
                                            snapShot.data?.data?.servicesInvoice
                                                    ?.length ??
                                                0,
                                            (index) => Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15.0,
                                                          left: 20.0,
                                                          right: 20),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            '${snapShot.data?.data?.servicesInvoice?[index].count ?? ''}x',
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  kPrimaryColor,
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 20,
                                                          ),
                                                          Text(
                                                            snapShot
                                                                    .data
                                                                    ?.data
                                                                    ?.servicesInvoice?[
                                                                        index]
                                                                    .serviceName ??
                                                                '',
                                                            style: const TextStyle(
                                                                color:
                                                                    kDarkGreyColor,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          )
                                                        ],
                                                      ),
                                                      Text(
                                                        '${snapShot.data?.data?.servicesInvoice?[index].cost} ${snapShot.data?.data?.servicesInvoice?[index].currancy}',
                                                        style: const TextStyle(
                                                            color:
                                                                kDarkGreyColor,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    ],
                                                  ),
                                                )),
                                      ),
                                      Consumer(
                                        builder: (context, watch, child) {
                                          final termsAndConditions =
                                              watch(termsAndConditionsProvider)
                                                  .state;
                                          return Row(
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  if (termsAndConditions ==
                                                      false) {
                                                    context
                                                        .read(
                                                            termsAndConditionsProvider)
                                                        .state = true;
                                                  } else {
                                                    context
                                                        .read(
                                                            termsAndConditionsProvider)
                                                        .state = false;
                                                  }
                                                },
                                                icon:
                                                    termsAndConditions == false
                                                        ? const Icon(
                                                            Icons
                                                                .check_box_outline_blank_sharp,
                                                            color: Colors.grey,
                                                            size: 18,
                                                          )
                                                        : const Icon(
                                                            Icons.check_box,
                                                            color: Colors.blue,
                                                            size: 18,
                                                          ),
                                              ),
                                              const Text(
                                                'I accept the',
                                                style: TextStyle(
                                                    color: kLightGreyColor,
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              InkWell(
                                                onTap: () {},
                                                child: const Text(
                                                  ' terms & conditions',
                                                  style: TextStyle(
                                                      color: kLightGreyColor,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: const Padding(
                                          padding: EdgeInsets.only(
                                              left: 20.0,
                                              right: 20,
                                              top: 10,
                                              bottom: 10),
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Terms And Conditions',
                                                style: TextStyle(
                                                  color: kPrimaryColor,
                                                  fontSize: 12,
                                                ),
                                              )),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            top: 20, right: 20, left: 20),
                                        width: screenWidth / 1.2,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: kLightGreyColor
                                                    .withOpacity(0.2),
                                                width: 1)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: screenWidth / 2,
                                              alignment: Alignment.center,
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: TextField(
                                                controller: logic.couponCnt,
                                                decoration:
                                                    const InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText:
                                                            'Enter Promo Code',
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                bottom: 10),
                                                        hintStyle: TextStyle(
                                                            color:
                                                                kLightGreyColor,
                                                            fontSize: 12)),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                logic.applyCoupon(
                                                    total: context
                                                        .read(total)
                                                        .state,
                                                    context: context);
                                              },
                                              child: Container(
                                                width: screenWidth / 4,
                                                padding:
                                                    const EdgeInsets.all(10),
                                                alignment: Alignment.center,
                                                decoration: const BoxDecoration(
                                                    color: kPrimaryColor,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(10),
                                                      bottomRight:
                                                          Radius.circular(10),
                                                    )),
                                                child: const Text(
                                                  'Apply',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      // const Padding(
                                      //   padding: EdgeInsets.only(
                                      //       left: 30.0, right: 30, top: 20, bottom: 10),
                                      //   child: Align(
                                      //       alignment: Alignment.centerLeft,
                                      //       child: Text(
                                      //         'Payment Method',
                                      //         style: TextStyle(
                                      //             color: kDarkGreyColor,
                                      //             fontSize: 14,
                                      //             fontWeight: FontWeight.bold),
                                      //       )),
                                      // ),
                                      // Container(
                                      //   margin: const EdgeInsets.all(20),
                                      //   padding: const EdgeInsets.all(10),
                                      //   decoration: BoxDecoration(
                                      //     borderRadius: BorderRadius.circular(15),
                                      //     border: Border.all(
                                      //         color: kLightGreyColor.withOpacity(0.5), width: 1),
                                      //   ),
                                      //   child: Column(
                                      //     crossAxisAlignment: CrossAxisAlignment.start,
                                      //     children: [
                                      //       Row(
                                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //         children: [
                                      //           Row(
                                      //             children: [
                                      //               Container(
                                      //                 width: 20,
                                      //                 height: 20,
                                      //                 decoration: BoxDecoration(
                                      //                     border: Border.all(
                                      //                         color:
                                      //                             kLightGreyColor.withOpacity(0.5),
                                      //                         width: 1),
                                      //                     shape: BoxShape.circle),
                                      //                 child: const Icon(
                                      //                   Icons.circle,
                                      //                   color: Colors.blue,
                                      //                   size: 10,
                                      //                 ),
                                      //               ),
                                      //               const SizedBox(
                                      //                 width: 10,
                                      //               ),
                                      //               const Text(
                                      //                 'Card',
                                      //                 style: TextStyle(
                                      //                     color: kDarkGreyColor, fontSize: 14),
                                      //               ),
                                      //             ],
                                      //           ),
                                      //           Row(
                                      //             children: const [
                                      //               Image(
                                      //                 width: 30,
                                      //                 image: NetworkImage(
                                      //                     'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMB6KwAcMDUZz3BiN7DD3vNksHmhiHlwQ8Qg&usqp=CAU'),
                                      //               ),
                                      //               Image(
                                      //                 width: 30,
                                      //                 image: NetworkImage(
                                      //                     'https://logoeps.com/wp-content/uploads/2011/08/mastercard-logo.png'),
                                      //               ),
                                      //               Image(
                                      //                 width: 30,
                                      //                 image: NetworkImage(
                                      //                     'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/Visa_Inc._logo.svg/1000px-Visa_Inc._logo.svg.png'),
                                      //               ),
                                      //             ],
                                      //           )
                                      //         ],
                                      //       ),
                                      //       // Container(
                                      //       //   margin: const EdgeInsets.only(top: 10, left: 5),
                                      //       //   padding: const EdgeInsets.only(left: 10, right: 10),
                                      //       //   width: screenWidth / 1.2,
                                      //       //   decoration: BoxDecoration(
                                      //       //     borderRadius: BorderRadius.circular(5),
                                      //       //     border: Border.all(
                                      //       //         color: kLightGreyColor.withOpacity(0.5),
                                      //       //         width: 1),
                                      //       //   ),
                                      //       //   child: const TextField(
                                      //       //     decoration: InputDecoration(
                                      //       //         hintText: 'Card Number',
                                      //       //         border: InputBorder.none,
                                      //       //         hintStyle: TextStyle(fontSize: 12)),
                                      //       //   ),
                                      //       // ),
                                      //       // Row(
                                      //       //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //       //   children: [
                                      //       //     Container(
                                      //       //       margin: const EdgeInsets.only(top: 10, left: 5),
                                      //       //       padding: const EdgeInsets.only(left: 10, right: 10),
                                      //       //       width: screenWidth / 4,
                                      //       //       decoration: BoxDecoration(
                                      //       //         borderRadius: BorderRadius.circular(5),
                                      //       //         border: Border.all(
                                      //       //             color: kLightGreyColor.withOpacity(0.5),
                                      //       //             width: 1),
                                      //       //       ),
                                      //       //       child: const TextField(
                                      //       //         decoration: InputDecoration(
                                      //       //             hintText: 'Expiry month',
                                      //       //             border: InputBorder.none,
                                      //       //             hintStyle: TextStyle(fontSize: 12)),
                                      //       //       ),
                                      //       //     ),
                                      //       //     Container(
                                      //       //       margin: const EdgeInsets.only(top: 10, left: 5),
                                      //       //       padding: const EdgeInsets.only(left: 10, right: 10),
                                      //       //       width: screenWidth / 4,
                                      //       //       decoration: BoxDecoration(
                                      //       //         borderRadius: BorderRadius.circular(5),
                                      //       //         border: Border.all(
                                      //       //             color: kLightGreyColor.withOpacity(0.5),
                                      //       //             width: 1),
                                      //       //       ),
                                      //       //       child: const TextField(
                                      //       //         decoration: InputDecoration(
                                      //       //             border: InputBorder.none,
                                      //       //             hintText: 'Expiry year',
                                      //       //             hintStyle: TextStyle(fontSize: 12)),
                                      //       //       ),
                                      //       //     ),
                                      //       //     Container(
                                      //       //       margin: const EdgeInsets.only(top: 10, left: 5),
                                      //       //       padding: const EdgeInsets.only(left: 10, right: 10),
                                      //       //       width: screenWidth / 4,
                                      //       //       decoration: BoxDecoration(
                                      //       //         borderRadius: BorderRadius.circular(5),
                                      //       //         border: Border.all(
                                      //       //             color: kLightGreyColor.withOpacity(0.5),
                                      //       //             width: 1),
                                      //       //       ),
                                      //       //       child: const TextField(
                                      //       //         decoration: InputDecoration(
                                      //       //             border: InputBorder.none,
                                      //       //             hintText: 'CVV',
                                      //       //             hintStyle: TextStyle(fontSize: 12)),
                                      //       //       ),
                                      //       //     ),
                                      //       //   ],
                                      //       // ),
                                      //       // Consumer(
                                      //       //   builder: (context, watch, child) {
                                      //       //     final saveMyCardDetails =
                                      //       //         watch(saveMyCardDetailsProvider).state;
                                      //       //     return Row(
                                      //       //       children: [
                                      //       //         IconButton(
                                      //       //           onPressed: () {
                                      //       //             if (saveMyCardDetails == false) {
                                      //       //               context
                                      //       //                   .read(saveMyCardDetailsProvider)
                                      //       //                   .state = true;
                                      //       //             } else {
                                      //       //               context
                                      //       //                   .read(saveMyCardDetailsProvider)
                                      //       //                   .state = false;
                                      //       //             }
                                      //       //           },
                                      //       //           icon: saveMyCardDetails == false
                                      //       //               ? const Icon(
                                      //       //                   Icons.check_box_outline_blank_sharp,
                                      //       //                   color: Colors.grey,
                                      //       //                   size: 18,
                                      //       //                 )
                                      //       //               : const Icon(
                                      //       //                   Icons.check_box,
                                      //       //                   color: Colors.blue,
                                      //       //                   size: 18,
                                      //       //                 ),
                                      //       //         ),
                                      //       //         Text(
                                      //       //           'Save my card details',
                                      //       //           style: TextStyle(
                                      //       //               color: kDarkGreyColor.withOpacity(0.6),
                                      //       //               fontSize: 12,
                                      //       //               fontWeight: FontWeight.w400),
                                      //       //         ),
                                      //       //       ],
                                      //       //     );
                                      //       //   },
                                      //       // ),
                                      //     ],
                                      //   ),
                                      // ),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            left: 20.0,
                                            right: 20,
                                            top: 10,
                                            bottom: 10),
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Additional services',
                                              style: TextStyle(
                                                  color: kDarkGreyColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                      ),
                                      FutureBuilder<StaticServices>(
                                        future: ApiManger.getStaticServices(
                                            eventId: eventId),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<StaticServices>
                                                snapShot) {
                                          switch (snapShot.connectionState) {
                                            case ConnectionState.waiting:
                                              {
                                                return Center(
                                                    child: ScreenLoading());
                                              }
                                            default:
                                              if (snapShot.hasError) {
                                                print(snapShot);
                                                return Text(
                                                    'Error: ${snapShot.error}');
                                              } else {
                                                print(snapShot.data?.toJson());
                                                logic.initStaticServices(
                                                    snapShot: snapShot,
                                                    context: context);
                                                return Column(
                                                  children: [
                                                    snapShot.data?.data
                                                                ?.refund ==
                                                            null
                                                        ? const SizedBox()
                                                        : Consumer(
                                                            builder: (context,
                                                                watch, child) {
                                                              final refundGuarantee =
                                                                  watch(refundGuaranteeProvider)
                                                                      .state;
                                                              return Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            20.0,
                                                                        right:
                                                                            20,
                                                                        bottom:
                                                                            10),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            if (refundGuarantee ==
                                                                                false) {
                                                                              context.read(refundGuaranteeProvider).state = true;
                                                                            } else {
                                                                              context.read(refundGuaranteeProvider).state = false;
                                                                            }
                                                                          },
                                                                          child: refundGuarantee == false
                                                                              ? const Icon(
                                                                                  Icons.check_box_outline_blank_sharp,
                                                                                  color: Colors.grey,
                                                                                  size: 18,
                                                                                )
                                                                              : const Icon(
                                                                                  Icons.check_box,
                                                                                  color: Colors.blue,
                                                                                  size: 18,
                                                                                ),
                                                                        ),
                                                                        const Text(
                                                                          'Refund Guarantee',
                                                                          style: TextStyle(
                                                                              color: kDarkGreyColor,
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.w400),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    InkWell(
                                                                      onTap:
                                                                          () {},
                                                                      child:
                                                                          const Icon(
                                                                        Icons
                                                                            .info,
                                                                        color:
                                                                            kDarkGreyColor,
                                                                        size:
                                                                            20,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                    snapShot.data?.data?.sms ==
                                                            null
                                                        ? const SizedBox()
                                                        : Consumer(
                                                            builder: (context,
                                                                watch, child) {
                                                              final sendMeTicketsVisSms =
                                                                  watch(sendMeTicketsVisSmsProvider)
                                                                      .state;
                                                              return Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            20.0,
                                                                        right:
                                                                            20,
                                                                        bottom:
                                                                            10),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            if (sendMeTicketsVisSms ==
                                                                                false) {
                                                                              context.read(sendMeTicketsVisSmsProvider).state = true;
                                                                            } else {
                                                                              context.read(sendMeTicketsVisSmsProvider).state = false;
                                                                            }
                                                                          },
                                                                          child: sendMeTicketsVisSms == false
                                                                              ? const Icon(
                                                                                  Icons.check_box_outline_blank_sharp,
                                                                                  color: Colors.grey,
                                                                                  size: 18,
                                                                                )
                                                                              : const Icon(
                                                                                  Icons.check_box,
                                                                                  color: Colors.blue,
                                                                                  size: 18,
                                                                                ),
                                                                        ),
                                                                        const Text(
                                                                          'Send me tickets vis sms',
                                                                          style: TextStyle(
                                                                              color: kDarkGreyColor,
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.w400),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    const Icon(
                                                                      Icons
                                                                          .info,
                                                                      color:
                                                                          kDarkGreyColor,
                                                                      size: 20,
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                    snapShot.data?.data
                                                                ?.whatsapp ==
                                                            null
                                                        ? const SizedBox()
                                                        : Consumer(
                                                            builder: (context,
                                                                watch, child) {
                                                              final sendMeTicketsVisWhatsapp =
                                                                  watch(sendMeTicketsVisWhatsappProvider)
                                                                      .state;
                                                              return Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            20.0,
                                                                        right:
                                                                            20,
                                                                        bottom:
                                                                            10),
                                                                child: Row(
                                                                  children: [
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        if (sendMeTicketsVisWhatsapp ==
                                                                            false) {
                                                                          context
                                                                              .read(sendMeTicketsVisWhatsappProvider)
                                                                              .state = true;
                                                                        } else {
                                                                          context
                                                                              .read(sendMeTicketsVisWhatsappProvider)
                                                                              .state = false;
                                                                        }
                                                                      },
                                                                      child: sendMeTicketsVisWhatsapp ==
                                                                              false
                                                                          ? const Icon(
                                                                              Icons.check_box_outline_blank_sharp,
                                                                              color: Colors.grey,
                                                                              size: 18,
                                                                            )
                                                                          : const Icon(
                                                                              Icons.check_box,
                                                                              color: Colors.blue,
                                                                              size: 18,
                                                                            ),
                                                                    ),
                                                                    const Text(
                                                                      'Send me tickets vis Whatsapp',
                                                                      style: TextStyle(
                                                                          color:
                                                                              kDarkGreyColor,
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.w400),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                  ],
                                                );
                                              }
                                          }
                                        },
                                      ),

                                      const Padding(
                                        padding: EdgeInsets.only(
                                            left: 20.0,
                                            right: 20,
                                            top: 10,
                                            bottom: 10),
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Summary',
                                              style: TextStyle(
                                                  color: kDarkGreyColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0,
                                            right: 20,
                                            top: 5,
                                            bottom: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Tickets',
                                              style: TextStyle(
                                                  color: kDarkGreyColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                              '${logic.countTicketsPrice(tickets: snapShot?.data?.data?.ticketsInvoice ?? [])} SAR',
                                              style: const TextStyle(
                                                  color: kDarkGreyColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0,
                                            right: 20,
                                            top: 5,
                                            bottom: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Services',
                                              style: TextStyle(
                                                  color: kDarkGreyColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                              '${logic.countServicesPrice(services: snapShot?.data?.data?.servicesInvoice ?? [])} SAR',
                                              style: const TextStyle(
                                                  color: kDarkGreyColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Consumer(
                                        builder: (context, watch, child) {
                                          watch(logic.couponApplied).state;
                                          return !context
                                                  .read(logic.couponApplied)
                                                  .state
                                              ? const SizedBox()
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20.0,
                                                          right: 20,
                                                          top: 5,
                                                          bottom: 5),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Text(
                                                        'Coupon Discount',
                                                        style: TextStyle(
                                                            color:
                                                                kDarkGreyColor,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                      Text(
                                                        '- ${context.read(total).state - context.read(logic.totalAfterCoupon).state} SAR',
                                                        style: const TextStyle(
                                                            color:
                                                                kDarkGreyColor,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                        },
                                      ),
                                      Consumer(
                                        builder: (context, watch, child) {
                                          watch(refundGuaranteeProvider).state;
                                          return !context
                                                  .read(refundGuaranteeProvider)
                                                  .state
                                              ? const SizedBox()
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20.0,
                                                          right: 20,
                                                          top: 5,
                                                          bottom: 5),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Text(
                                                        'Refund Gurarantee',
                                                        style: TextStyle(
                                                            color:
                                                                kDarkGreyColor,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                      Text(
                                                        '${logic.refundServiceValue} SAR',
                                                        style: const TextStyle(
                                                            color:
                                                                kDarkGreyColor,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                        },
                                      ),
                                      Consumer(
                                        builder: (context, watch, child) {
                                          watch(sendMeTicketsVisSmsProvider)
                                              .state;
                                          return !context
                                                  .read(
                                                      sendMeTicketsVisSmsProvider)
                                                  .state
                                              ? const SizedBox()
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20.0,
                                                          right: 20,
                                                          top: 5,
                                                          bottom: 5),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Text(
                                                        'Send me tickets vis sms',
                                                        style: TextStyle(
                                                            color:
                                                                kDarkGreyColor,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                      Text(
                                                        '${logic.smsServiceValue} SAR',
                                                        style: const TextStyle(
                                                            color:
                                                                kDarkGreyColor,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                        },
                                      ),

                                      Consumer(
                                        builder: (context, watch, child) {
                                          watch(sendMeTicketsVisWhatsappProvider)
                                              .state;
                                          return !context
                                                  .read(
                                                      sendMeTicketsVisWhatsappProvider)
                                                  .state
                                              ? const SizedBox()
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20.0,
                                                          right: 20,
                                                          top: 5,
                                                          bottom: 5),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Text(
                                                        'Send me tickets vis Whatsapp',
                                                        style: TextStyle(
                                                            color:
                                                                kDarkGreyColor,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                      Text(
                                                        '${logic.whatsAppServiceValue} SAR',
                                                        style: const TextStyle(
                                                            color:
                                                                kDarkGreyColor,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                        },
                                      ),

                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        width: screenWidth / 1.2,
                                        child: const Divider(
                                          height: 1,
                                          color: kLightGreyColor,
                                        ),
                                      ),
                                      Consumer(
                                        builder: (context, watch, child) {
                                          watch(total).state;
                                          watch(logic.totalAfterCoupon);
                                          watch(
                                              sendMeTicketsVisWhatsappProvider);
                                          watch(sendMeTicketsVisSmsProvider);
                                          watch(refundGuaranteeProvider);
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0,
                                                right: 20,
                                                top: 5,
                                                bottom: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Total excl. VAT',
                                                  style: TextStyle(
                                                      color: kDarkGreyColor,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                Text(
                                                  logic.countTotalExclVat(
                                                      totalNet: context
                                                          .read(total)
                                                          .state,
                                                      totalAfterCoupon: context
                                                          .read(logic
                                                              .totalAfterCoupon)
                                                          .state,
                                                      refund: context.read(refundGuaranteeProvider).state ? logic.refundServiceValue : 0.0,
                                                      sms: context.read(sendMeTicketsVisSmsProvider).state ? logic.smsServiceValue : 0.0,
                                                      whatsapp: context.read(sendMeTicketsVisWhatsappProvider).state ? logic.whatsAppServiceValue : 0.0,
                                                  ),
                                                  style: TextStyle(
                                                      color: kDarkGreyColor,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0,
                                            right: 20,
                                            top: 5,
                                            bottom: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children:  [
                                            Text(
                                              'VAT ${UserData.vat}%',
                                              style: const TextStyle(
                                                  color: kDarkGreyColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                              '${logic.countVatValue(
                                                totalNet: context
                                                    .read(total)
                                                    .state,
                                                totalAfterCoupon: context
                                                    .read(logic
                                                    .totalAfterCoupon)
                                                    .state,
                                                refund: context.read(refundGuaranteeProvider).state ? logic.refundServiceValue : 0,
                                                sms: context.read(sendMeTicketsVisSmsProvider).state ? logic.smsServiceValue : 0,
                                                whatsapp: context.read(sendMeTicketsVisWhatsappProvider).state ? logic.whatsAppServiceValue : 0,
                                              )} SAR',
                                              style: TextStyle(
                                                  color: kDarkGreyColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                          }
                        },
                      );
                    }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
