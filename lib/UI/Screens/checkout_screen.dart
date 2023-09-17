import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/user_data.dart';
import 'package:hayyak/Logic/UI%20Logic/checkout_logic.dart';
import 'package:hayyak/States/providers.dart';
import 'package:hayyak/UI/Components/seccond_app_bar.dart';
import 'package:hayyak/UI/Screens/event_details_screen.dart';
import 'package:hayyak/UI/Screens/payment_method_screen.dart';
import 'package:hayyak/UI/Screens/terms_and_conditions_screen.dart';
import 'package:hayyak/main.dart';

import '../../Config/navigator.dart';
import '../../Dialogs/loading_screen.dart';
import '../../Dialogs/message_dialog.dart';
import '../../Dialogs/static_services_info_dialog.dart';
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
      required this.total,
      required this.receitType,
      required this.vat,
      required this.fees});

  CheckoutLogic logic = CheckoutLogic();
  late String eventName,
      eventImage,
      eventDate,
      eventTime,
      eventId,
      receitType,
      selectedDate;
  List selectedTickets = [];
  List selectedServices = [];
  StateProvider total;
  num? vat, fees;
  num totalReceipt = 0.0;
  CountDownController countDownController = CountDownController();

  @override
  Widget build(BuildContext context) {
    logic.context = context;
    logic.vat = vat;
    logic.fees = fees;
    logic.eventId = eventId;
    return FutureBuilder(
      future: logic.initDataToCheckAvailable(
          receiptType: receitType,
          selectedTickets: selectedTickets,
          selectedServices: selectedServices),
      builder: (BuildContext context, snapShot) {
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
                  child: Text('Error: ${snapShot.error}'),
                ),
              );
            } else {
              return FutureBuilder<AvailableTicketsForSaleModel>(
                future: ApiManger.getAvailableTicketsForSale(
                    eventId: eventId,
                    services: logic.services,
                    tickets: logic.tickets,
                    date: selectedDate),
                builder: (BuildContext context,
                    AsyncSnapshot<AvailableTicketsForSaleModel> snapShot) {
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
                          child: Text('Error: ${snapShot.error}'),
                        ));
                      } else {
                        logic.init(snapShot);
                        return Consumer(builder: (context, ref, child) {
                          ref.watch(total);
                          ref.watch(logic.totalAfterCoupon);
                          ref.watch(logic.couponApplied);
                          ref.watch(logic.refresh);
                          final whats =
                              ref.watch(sendMeTicketsVisWhatsappProvider);
                          final sms = ref.watch(sendMeTicketsVisSmsProvider);
                          final refund = ref.watch(refundGuaranteeProvider);
                          final termsAndConditions =
                              ref.watch(termsAndConditionsProvider);
                          return Scaffold(
                            bottomNavigationBar: Container(
                              width: screenWidth / 1,
                              height: screenHeight / 10,
                              color: kDarkGreyColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            UserData.translation.data?.total
                                                    ?.toString() ??
                                                'Total',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            UserData.translation.data?.inclVat
                                                    ?.toString() ??
                                                '(Incl. VAT)',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '${logic.countReceipt(sms, whats, refund)?.toStringAsFixed(2)}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  CircularCountDownTimer(
                                    controller: countDownController,
                                    width: 40,
                                    height: 40,
                                    duration: UserData.reservationTimer.toInt(),
                                    autoStart: true,
                                    isReverse: true,
                                    onComplete: () {
                                      navigator(
                                          context: context,
                                          screen: EventDetails(
                                              eventId: num.parse(
                                                  logic.eventId ?? '')));
                                    },
                                    textStyle: const TextStyle(
                                        color: Colors.white, fontSize: 12),
                                    fillColor: kPrimaryColor,
                                    ringColor: kLightGreyColor,
                                    textFormat: CountdownTextFormat.MM_SS,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (snapShot.data?.data?.ticketsInvoice ==
                                          []) {
                                        messageDialog(
                                            context, 'No Ticket Available');
                                      } else {
                                        logic.createOrder(
                                            eventId: eventId,
                                            sms: 'on',
                                            refund: 'on',
                                            whatsapp: 'on',
                                            amount: logic
                                                .countReceipt(
                                                    sms, whats, refund)!
                                                .toStringAsFixed(2)
                                                .toString(),
                                            date: selectedDate,
                                            couponId: '');
                                      }
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: screenWidth / 1.8,
                                      height: 50,
                                      margin: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF1fde1f),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text(
                                        UserData.translation.data?.pay
                                                ?.toString() ??
                                            'Pay',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
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
                                      title: UserData.translation.data?.checkout
                                              ?.toString() ??
                                          'Checkout',
                                      shareAndFav: false,
                                      backToHome: false),
                                  Expanded(
                                      child: ListView(
                                    children: [
                                      SizedBox(
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
                                                    image: NetworkImage(
                                                        eventImage)),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.all(10),
                                              width: screenWidth / 1.2,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
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
                                                            color:
                                                                kDarkGreyColor,
                                                            fontSize: 12),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .access_time_outlined,
                                                        color: kDarkGreyColor,
                                                        size: 15,
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        eventTime,
                                                        style: const TextStyle(
                                                            color:
                                                                kDarkGreyColor,
                                                            fontSize: 12),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Column(
                                              children: List.generate(
                                                  snapShot
                                                          .data
                                                          ?.data
                                                          ?.ticketsInvoice
                                                          ?.length ??
                                                      0,
                                                  (index) => Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
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
                                                                    fontSize:
                                                                        12,
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
                                                                      fontSize:
                                                                          12,
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
                                                                          .currancy ??
                                                                      ' SAR'),
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
                                                  snapShot
                                                          .data
                                                          ?.data
                                                          ?.servicesInvoice
                                                          ?.length ??
                                                      0,
                                                  (index) => Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
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
                                                                    fontSize:
                                                                        12,
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
                                                                      fontSize:
                                                                          12,
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
                                            Row(
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    if (termsAndConditions ==
                                                        false) {
                                                      ref
                                                          .read(
                                                              termsAndConditionsProvider
                                                                  .notifier)
                                                          .state = true;
                                                    } else {
                                                      ref
                                                          .read(
                                                              termsAndConditionsProvider
                                                                  .notifier)
                                                          .state = false;
                                                    }
                                                  },
                                                  icon: termsAndConditions ==
                                                          false
                                                      ? const Icon(
                                                          Icons
                                                              .check_box_outline_blank_sharp,
                                                          color: Colors.grey,
                                                          size: 18,
                                                        )
                                                      : const Icon(
                                                          Icons.check_box,
                                                          color: kPrimaryColor,
                                                          size: 18,
                                                        ),
                                                ),
                                                Text(
                                                  UserData.translation.data
                                                          ?.acceptAllTermsAndConditions
                                                          ?.toString() ??
                                                      'I accept the',
                                                  style: const TextStyle(
                                                      color: kLightGreyColor,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                InkWell(
                                                  onTap: () {},
                                                  child: Text(
                                                    UserData.translation.data
                                                            ?.termsAndConditions
                                                            ?.toString() ??
                                                        ' terms & conditions',
                                                    style: const TextStyle(
                                                        color: kLightGreyColor,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            InkWell(
                                              onTap: () {
                                                navigator(
                                                    context: context,
                                                    screen:
                                                        TermsAndConditionsScreen());
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20.0,
                                                    right: 20,
                                                    top: 10,
                                                    bottom: 10),
                                                child: Align(
                                                    alignment: localLanguage ==
                                                            'en'
                                                        ? Alignment.centerLeft
                                                        : Alignment.centerRight,
                                                    child: Text(
                                                      UserData.translation.data
                                                              ?.termsAndConditions
                                                              ?.toString() ??
                                                          'Terms And Conditions',
                                                      style: const TextStyle(
                                                        color: kPrimaryColor,
                                                        fontSize: 12,
                                                      ),
                                                    )),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0,
                                                  right: 20,
                                                  top: 10,
                                                  bottom: 10),
                                              child: Align(
                                                  alignment: localLanguage ==
                                                          'en'
                                                      ? Alignment.centerLeft
                                                      : Alignment.centerRight,
                                                  child: Text(
                                                    UserData.translation.data
                                                            ?.additionalServices
                                                            ?.toString() ??
                                                        'Additional services',
                                                    style: const TextStyle(
                                                        color: kDarkGreyColor,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                            ),
                                            logic.staticServices?.data
                                                        ?.refund ==
                                                    null
                                                ? const SizedBox()
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20.0,
                                                            right: 20,
                                                            bottom: 10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                if (refund ==
                                                                    false) {
                                                                  ref
                                                                      .read(refundGuaranteeProvider
                                                                          .notifier)
                                                                      .state = true;
                                                                } else {
                                                                  ref
                                                                      .read(refundGuaranteeProvider
                                                                          .notifier)
                                                                      .state = false;
                                                                }
                                                              },
                                                              child: refund ==
                                                                      false
                                                                  ? const Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              5.0),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .check_box_outline_blank_sharp,
                                                                        color: Colors
                                                                            .grey,
                                                                        size:
                                                                            18,
                                                                      ),
                                                                    )
                                                                  : const Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              5.0),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .check_box,
                                                                        color: Colors
                                                                            .blue,
                                                                        size:
                                                                            18,
                                                                      ),
                                                                    ),
                                                            ),
                                                            Text(
                                                              UserData
                                                                      .translation
                                                                      .data
                                                                      ?.refundGuarantee
                                                                      ?.toString() ??
                                                                  'Refund Guarantee',
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
                                                        InkWell(
                                                          onTap: () {
                                                            staticServicesInfoDialog(
                                                                context,
                                                                UserData
                                                                        .translation
                                                                        .data
                                                                        ?.refundGuarantee
                                                                        ?.toString() ??
                                                                    'Refund Guarantee',
                                                                localLanguage ==
                                                                        'en'
                                                                    ? logic
                                                                            .staticServices
                                                                            ?.data
                                                                            ?.refund
                                                                            ?.descriptionEn
                                                                            .toString() ??
                                                                        ''
                                                                    : logic
                                                                            .staticServices
                                                                            ?.data
                                                                            ?.refund
                                                                            ?.descriptionAr
                                                                            .toString() ??
                                                                        '');
                                                          },
                                                          child: const Icon(
                                                            Icons.info,
                                                            color:
                                                                kDarkGreyColor,
                                                            size: 20,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                            logic.staticServices?.data?.sms ==
                                                    null
                                                ? const SizedBox()
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20.0,
                                                            right: 20,
                                                            bottom: 10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                if (sms ==
                                                                    false) {
                                                                  ref
                                                                      .read(sendMeTicketsVisSmsProvider
                                                                          .notifier)
                                                                      .state = true;
                                                                } else {
                                                                  ref
                                                                      .read(sendMeTicketsVisSmsProvider
                                                                          .notifier)
                                                                      .state = false;
                                                                }
                                                              },
                                                              child: sms ==
                                                                      false
                                                                  ? const Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              5.0),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .check_box_outline_blank_sharp,
                                                                        color: Colors
                                                                            .grey,
                                                                        size:
                                                                            18,
                                                                      ),
                                                                    )
                                                                  : const Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              5.0),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .check_box,
                                                                        color: Colors
                                                                            .blue,
                                                                        size:
                                                                            18,
                                                                      ),
                                                                    ),
                                                            ),
                                                            Text(
                                                              UserData
                                                                      .translation
                                                                      .data
                                                                      ?.sendMeTicketsViaSms
                                                                      ?.toString() ??
                                                                  'Send me tickets vis sms',
                                                              style: TextStyle(
                                                                  color:
                                                                      kDarkGreyColor,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                          ],
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            staticServicesInfoDialog(
                                                                context,
                                                                'SMS',
                                                                localLanguage ==
                                                                        'en'
                                                                    ? logic
                                                                            .staticServices
                                                                            ?.data
                                                                            ?.sms
                                                                            ?.descriptionEn
                                                                            .toString() ??
                                                                        ''
                                                                    : logic
                                                                            .staticServices
                                                                            ?.data
                                                                            ?.sms
                                                                            ?.descriptionAr
                                                                            .toString() ??
                                                                        '');
                                                          },
                                                          child: const Icon(
                                                            Icons.info,
                                                            color:
                                                                kDarkGreyColor,
                                                            size: 20,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                            logic.staticServices?.data
                                                        ?.whatsapp ==
                                                    null
                                                ? const SizedBox()
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20.0,
                                                            right: 20,
                                                            bottom: 10),
                                                    child: Row(
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            if (whats ==
                                                                false) {
                                                              ref
                                                                  .read(sendMeTicketsVisWhatsappProvider
                                                                      .notifier)
                                                                  .state = true;
                                                            } else {
                                                              ref
                                                                  .read(sendMeTicketsVisWhatsappProvider
                                                                      .notifier)
                                                                  .state = false;
                                                            }
                                                          },
                                                          child: whats == false
                                                              ? const Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              5.0),
                                                                  child: Icon(
                                                                    Icons
                                                                        .check_box_outline_blank_sharp,
                                                                    color: Colors
                                                                        .grey,
                                                                    size: 18,
                                                                  ),
                                                                )
                                                              : const Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              5.0),
                                                                  child: Icon(
                                                                    Icons
                                                                        .check_box,
                                                                    color: Colors
                                                                        .blue,
                                                                    size: 18,
                                                                  ),
                                                                ),
                                                        ),
                                                        Text(
                                                          UserData
                                                                  .translation
                                                                  .data
                                                                  ?.sendMeTicketsViaWhatsApp
                                                                  ?.toString() ??
                                                              'Send me tickets vis Whatsapp',
                                                          style: TextStyle(
                                                              color:
                                                                  kDarkGreyColor,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                      ],
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    width: screenWidth / 2,
                                                    alignment: Alignment.center,
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: TextField(
                                                      controller:
                                                          logic.couponCnt,
                                                      decoration: InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          hintText: UserData
                                                                  .translation
                                                                  .data
                                                                  ?.enterPromoCode
                                                                  ?.toString() ??
                                                              'Enter Promo Code',
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                                  bottom: 10,
                                                                  right: 5,
                                                                  left: 5),
                                                          hintStyle: TextStyle(
                                                              color:
                                                                  kLightGreyColor,
                                                              fontSize: 12)),
                                                    ),
                                                  ),
                                                  Consumer(
                                                    builder:
                                                        (context, ref, child) {
                                                      return InkWell(
                                                        onTap: () {
                                                          logic.applyCoupon(
                                                              ref: ref,
                                                              total: ref
                                                                  .read(total
                                                                      .notifier)
                                                                  .state,
                                                              context: context);
                                                        },
                                                        child: Container(
                                                          width:
                                                              screenWidth / 4,
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          alignment:
                                                              Alignment.center,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  kPrimaryColor,
                                                              borderRadius: BorderRadius.only(
                                                                  topRight: localLanguage ==
                                                                          'en'
                                                                      ? Radius.circular(
                                                                          10)
                                                                      : Radius.circular(
                                                                          0),
                                                                  topLeft: localLanguage ==
                                                                          'ar'
                                                                      ? Radius.circular(
                                                                          10)
                                                                      : Radius.circular(
                                                                          0),
                                                                  bottomRight: localLanguage ==
                                                                          'en'
                                                                      ? Radius.circular(
                                                                          10)
                                                                      : Radius.circular(
                                                                          0),
                                                                  bottomLeft: localLanguage ==
                                                                          'ar'
                                                                      ? Radius.circular(10)
                                                                      : Radius.circular(0))),
                                                          child: Text(
                                                            UserData.translation
                                                                    .data?.apply
                                                                    ?.toString() ??
                                                                'Apply',
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0,
                                                  right: 20,
                                                  top: 10,
                                                  bottom: 10),
                                              child: Align(
                                                  alignment: localLanguage ==
                                                          'en'
                                                      ? Alignment.centerLeft
                                                      : Alignment.centerRight,
                                                  child: Text(
                                                    UserData.translation.data
                                                            ?.summery
                                                            ?.toString() ??
                                                        'Summary',
                                                    style: const TextStyle(
                                                        color: kDarkGreyColor,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    UserData.translation.data
                                                            ?.tickets
                                                            ?.toString() ??
                                                        'Tickets',
                                                    style: const TextStyle(
                                                        color: kDarkGreyColor,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  Text(
                                                    '${logic.totalTickets} SAR',
                                                    style: const TextStyle(
                                                        color: kDarkGreyColor,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400),
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    UserData.translation.data
                                                            ?.services
                                                            ?.toString() ??
                                                        'Services',
                                                    style: const TextStyle(
                                                        color: kDarkGreyColor,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  Text(
                                                    '${logic.totalServices} SAR',
                                                    style: const TextStyle(
                                                        color: kDarkGreyColor,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            !ref
                                                    .read(
                                                        refundGuaranteeProvider
                                                            .notifier)
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
                                                        Text(
                                                          UserData
                                                                  .translation
                                                                  .data
                                                                  ?.refundGuarantee
                                                                  ?.toString() ??
                                                              'Refund Gurarantee',
                                                          style: const TextStyle(
                                                              color:
                                                                  kDarkGreyColor,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                        Text(
                                                          '${(logic.refundServiceValue)} SAR',
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
                                                  ),
                                            !ref
                                                    .read(
                                                        sendMeTicketsVisSmsProvider
                                                            .notifier)
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
                                                        Text(
                                                          UserData
                                                                  .translation
                                                                  .data
                                                                  ?.sendMeTicketsViaSms
                                                                  ?.toString() ??
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
                                                  ),
                                            !ref
                                                    .read(
                                                        sendMeTicketsVisWhatsappProvider
                                                            .notifier)
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
                                                        Text(
                                                          UserData
                                                                  .translation
                                                                  .data
                                                                  ?.sendMeTicketsViaWhatsApp
                                                                  ?.toString() ??
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
                                                  ),
                                            Container(
                                              padding: const EdgeInsets.all(5),
                                              width: screenWidth / 1.2,
                                              child: const Divider(
                                                height: 1,
                                                color: kLightGreyColor,
                                              ),
                                            ),
                                            !ref
                                                    .read(logic
                                                        .couponApplied.notifier)
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
                                                          '- ${(logic.totalTickets + logic.totalServices) - ref.read(logic.totalAfterCoupon.notifier).state} SAR',
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
                                                  ),
                                            Padding(
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
                                                    UserData.translation.data
                                                            ?.totalExclVat
                                                            ?.toString() ??
                                                        'Total excl. VAT',
                                                    style: const TextStyle(
                                                        color: kDarkGreyColor,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  Text(
                                                    logic
                                                        .countTotalExclVat(
                                                          refund: ref
                                                              .read(
                                                                  refundGuaranteeProvider
                                                                      .notifier)
                                                              .state,
                                                          sms: ref
                                                              .read(
                                                                  sendMeTicketsVisSmsProvider
                                                                      .notifier)
                                                              .state,
                                                          whatsapp: ref
                                                              .read(
                                                                  sendMeTicketsVisWhatsappProvider
                                                                      .notifier)
                                                              .state,
                                                        )
                                                        .toString(),
                                                    style: const TextStyle(
                                                        color: kDarkGreyColor,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400),
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    '${UserData.translation.data?.fees?.toString() ?? 'Fees'} $fees%',
                                                    style: const TextStyle(
                                                        color: kDarkGreyColor,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  Text(
                                                    '${logic.countFeesValue(
                                                          fees: fees ?? 0,
                                                          refund: ref
                                                              .read(
                                                                  refundGuaranteeProvider
                                                                      .notifier)
                                                              .state,
                                                          sms: ref
                                                              .read(
                                                                  sendMeTicketsVisSmsProvider
                                                                      .notifier)
                                                              .state,
                                                          whatsapp: ref
                                                              .read(
                                                                  sendMeTicketsVisWhatsappProvider
                                                                      .notifier)
                                                              .state,
                                                        ).toStringAsFixed(2)} SAR',
                                                    style: const TextStyle(
                                                        color: kDarkGreyColor,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400),
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    '${UserData.translation.data?.vat?.toString() ?? 'VAT'} $vat%',
                                                    style: const TextStyle(
                                                        color: kDarkGreyColor,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  Text(
                                                    '${logic.countVatValue(
                                                          vat: vat,
                                                          fees: logic
                                                              .countFeesValue(
                                                            fees: fees ?? 0,
                                                            refund: ref
                                                                .read(refundGuaranteeProvider
                                                                    .notifier)
                                                                .state,
                                                            sms: ref
                                                                .read(sendMeTicketsVisSmsProvider
                                                                    .notifier)
                                                                .state,
                                                            whatsapp: ref
                                                                .read(sendMeTicketsVisWhatsappProvider
                                                                    .notifier)
                                                                .state,
                                                          ),
                                                          refund: ref
                                                              .read(
                                                                  refundGuaranteeProvider
                                                                      .notifier)
                                                              .state,
                                                          sms: ref
                                                              .read(
                                                                  sendMeTicketsVisSmsProvider
                                                                      .notifier)
                                                              .state,
                                                          whatsapp: ref
                                                              .read(
                                                                  sendMeTicketsVisWhatsappProvider
                                                                      .notifier)
                                                              .state,
                                                        ).toStringAsFixed(2)} SAR',
                                                    style: const TextStyle(
                                                        color: kDarkGreyColor,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ))
                                ],
                              ),
                            ),
                          );
                        });
                      }
                  }
                },
              );
            }
        }
      },
    );
    ;
  }
}
