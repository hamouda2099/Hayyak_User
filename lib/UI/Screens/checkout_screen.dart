import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/user_data.dart';
import 'package:hayyak/Logic/UI%20Logic/checkout_logic.dart';
import 'package:hayyak/Models/static_services_model.dart';
import 'package:hayyak/States/providers.dart';
import 'package:hayyak/UI/Components/seccond_app_bar.dart';
import 'package:hayyak/main.dart';
import '../../Dialogs/loading_screen.dart';
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
  CountDownController countDownController = CountDownController();

  @override
  Widget build(BuildContext context) {
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
              return Text('Error: ${snapShot.error}');
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
                        return Text('Error: ${snapShot.error}');
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
                                    const Row(
                                      children: [
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
                                      builder: (context, ref, child) {
                                        ref.watch(total);
                                        ref.watch(logic.totalAfterCoupon);
                                        ref.watch(
                                            sendMeTicketsVisWhatsappProvider);
                                        ref.watch(sendMeTicketsVisSmsProvider);
                                        ref.watch(refundGuaranteeProvider);
                                        return Text(
                                          '${(double.parse(logic.countTotalExclVat(
                                                totalNet: (logic.countTicketsPrice(
                                                        tickets: snapShot
                                                                .data
                                                                ?.data
                                                                ?.ticketsInvoice ??
                                                            []) +
                                                    logic.countServicesPrice(
                                                        services: snapShot
                                                                .data
                                                                ?.data
                                                                ?.servicesInvoice ??
                                                            [])),
                                                totalAfterCoupon: ref
                                                    .read(logic.totalAfterCoupon
                                                        .notifier)
                                                    .state,
                                                refund: ref
                                                        .read(
                                                            refundGuaranteeProvider
                                                                .notifier)
                                                        .state
                                                    ? logic.refundServiceValue
                                                    : 0.0,
                                                sms: ref
                                                        .read(
                                                            sendMeTicketsVisSmsProvider
                                                                .notifier)
                                                        .state
                                                    ? logic.smsServiceValue
                                                    : 0.0,
                                                whatsapp: ref
                                                        .read(
                                                            sendMeTicketsVisWhatsappProvider
                                                                .notifier)
                                                        .state
                                                    ? logic.whatsAppServiceValue
                                                    : 0.0,
                                              )) + logic.countFeesValue(
                                                vat: fees,
                                                totalNet: (logic.countTicketsPrice(
                                                        tickets: snapShot
                                                                .data
                                                                ?.data
                                                                ?.ticketsInvoice ??
                                                            []) +
                                                    logic.countServicesPrice(
                                                        services: snapShot
                                                                .data
                                                                ?.data
                                                                ?.servicesInvoice ??
                                                            [])),
                                                totalAfterCoupon: ref
                                                    .read(logic.totalAfterCoupon
                                                        .notifier)
                                                    .state,
                                                refund: ref
                                                        .read(
                                                            refundGuaranteeProvider
                                                                .notifier)
                                                        .state
                                                    ? logic.refundServiceValue
                                                    : 0,
                                                sms: ref
                                                        .read(
                                                            sendMeTicketsVisSmsProvider
                                                                .notifier)
                                                        .state
                                                    ? logic.smsServiceValue
                                                    : 0,
                                                whatsapp: ref
                                                        .read(
                                                            sendMeTicketsVisWhatsappProvider
                                                                .notifier)
                                                        .state
                                                    ? logic.whatsAppServiceValue
                                                    : 0,
                                              ) + logic.countVatValue(
                                                vat: vat,
                                                fees: logic.countFeesValue(
                                                  vat: fees,
                                                  totalNet: (logic
                                                          .countTicketsPrice(
                                                              tickets: snapShot
                                                                      .data
                                                                      ?.data
                                                                      ?.ticketsInvoice ??
                                                                  []) +
                                                      logic.countServicesPrice(
                                                          services: snapShot
                                                                  .data
                                                                  ?.data
                                                                  ?.servicesInvoice ??
                                                              [])),
                                                  totalAfterCoupon: ref
                                                      .read(logic
                                                          .totalAfterCoupon
                                                          .notifier)
                                                      .state,
                                                  refund: ref
                                                          .read(
                                                              refundGuaranteeProvider
                                                                  .notifier)
                                                          .state
                                                      ? logic.refundServiceValue
                                                      : 0,
                                                  sms: ref
                                                          .read(
                                                              sendMeTicketsVisSmsProvider
                                                                  .notifier)
                                                          .state
                                                      ? logic.smsServiceValue
                                                      : 0,
                                                  whatsapp: ref
                                                          .read(
                                                              sendMeTicketsVisWhatsappProvider
                                                                  .notifier)
                                                          .state
                                                      ? logic
                                                          .whatsAppServiceValue
                                                      : 0,
                                                ),
                                                totalNet: (logic.countTicketsPrice(
                                                        tickets: snapShot
                                                                .data
                                                                ?.data
                                                                ?.ticketsInvoice ??
                                                            []) +
                                                    logic.countServicesPrice(
                                                        services: snapShot
                                                                .data
                                                                ?.data
                                                                ?.servicesInvoice ??
                                                            [])),
                                                totalAfterCoupon: ref
                                                    .read(logic.totalAfterCoupon
                                                        .notifier)
                                                    .state,
                                                refund: ref
                                                        .read(
                                                            refundGuaranteeProvider
                                                                .notifier)
                                                        .state
                                                    ? logic.refundServiceValue
                                                    : 0,
                                                sms: ref
                                                        .read(
                                                            sendMeTicketsVisSmsProvider
                                                                .notifier)
                                                        .state
                                                    ? logic.smsServiceValue
                                                    : 0,
                                                whatsapp: ref
                                                        .read(
                                                            sendMeTicketsVisWhatsappProvider
                                                                .notifier)
                                                        .state
                                                    ? logic.whatsAppServiceValue
                                                    : 0,
                                              )).toStringAsFixed(2)} SAR',
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
                                  onComplete: () {},
                                  textStyle: const TextStyle(
                                      color: Colors.white, fontSize: 12),
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
                                    title: 'Checkout',
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
                                                  image:
                                                      NetworkImage(eventImage)),
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
                                                snapShot
                                                        .data
                                                        ?.data
                                                        ?.ticketsInvoice
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
                                                                        .currancy
                                                                        .toString() ??
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
                                          Consumer(
                                            builder: (context, ref, child) {
                                              final termsAndConditions =
                                                  ref.watch(
                                                      termsAndConditionsProvider);
                                              return Row(
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
                                                          color:
                                                              kLightGreyColor,
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
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    'Terms And Conditions',
                                                    style: TextStyle(
                                                      color: kPrimaryColor,
                                                      fontSize: 12,
                                                    ),
                                                  )),
                                            ),
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
                                                  'Additional services',
                                                  style: TextStyle(
                                                      color: kDarkGreyColor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                          ),
                                          FutureBuilder<StaticServices>(
                                            future: ApiManger.getStaticServices(
                                                eventId: eventId),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<StaticServices>
                                                    snapShot) {
                                              switch (
                                                  snapShot.connectionState) {
                                                case ConnectionState.waiting:
                                                  {
                                                    return Center(
                                                        child: ScreenLoading());
                                                  }
                                                default:
                                                  if (snapShot.hasError) {
                                                    return Text(
                                                        'Error: ${snapShot.error}');
                                                  } else {
                                                    logic.initStaticServices(
                                                        snapShot: snapShot,
                                                        context: context,
                                                        tickets:
                                                            selectedTickets);
                                                    return Column(
                                                      children: [
                                                        snapShot.data?.data
                                                                    ?.refund ==
                                                                null
                                                            ? const SizedBox()
                                                            : Consumer(
                                                                builder:
                                                                    (context,
                                                                        ref,
                                                                        child) {
                                                                  final refundGuarantee =
                                                                      ref.watch(
                                                                          refundGuaranteeProvider);
                                                                  return Padding(
                                                                    padding: const EdgeInsets
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
                                                                              onTap: () {
                                                                                if (refundGuarantee == false) {
                                                                                  ref.read(refundGuaranteeProvider.notifier).state = true;
                                                                                } else {
                                                                                  ref.read(refundGuaranteeProvider.notifier).state = false;
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
                                                                              style: TextStyle(color: kDarkGreyColor, fontSize: 12, fontWeight: FontWeight.w400),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            staticServicesInfoDialog(
                                                                                context,
                                                                                'Refund Guarantee',
                                                                                snapShot.data?.data?.refund?.descriptionAr.toString() ?? '');
                                                                          },
                                                                          child:
                                                                              const Icon(
                                                                            Icons.info,
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
                                                        snapShot.data?.data
                                                                    ?.sms ==
                                                                null
                                                            ? const SizedBox()
                                                            : Consumer(
                                                                builder:
                                                                    (context,
                                                                        ref,
                                                                        child) {
                                                                  final sendMeTicketsVisSms =
                                                                      ref.watch(
                                                                          sendMeTicketsVisSmsProvider);
                                                                  return Padding(
                                                                    padding: const EdgeInsets
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
                                                                              onTap: () {
                                                                                if (sendMeTicketsVisSms == false) {
                                                                                  ref.read(sendMeTicketsVisSmsProvider.notifier).state = true;
                                                                                } else {
                                                                                  ref.read(sendMeTicketsVisSmsProvider.notifier).state = false;
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
                                                                              style: TextStyle(color: kDarkGreyColor, fontSize: 12, fontWeight: FontWeight.w400),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        const Icon(
                                                                          Icons
                                                                              .info,
                                                                          color:
                                                                              kDarkGreyColor,
                                                                          size:
                                                                              20,
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
                                                                builder:
                                                                    (context,
                                                                        ref,
                                                                        child) {
                                                                  final sendMeTicketsVisWhatsapp =
                                                                      ref.watch(
                                                                          sendMeTicketsVisWhatsappProvider);
                                                                  return Padding(
                                                                    padding: const EdgeInsets
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
                                                                              ref.read(sendMeTicketsVisWhatsappProvider.notifier).state = true;
                                                                            } else {
                                                                              ref.read(sendMeTicketsVisWhatsappProvider.notifier).state = false;
                                                                            }
                                                                          },
                                                                          child: sendMeTicketsVisWhatsapp == false
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
                                                                              color: kDarkGreyColor,
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.w400),
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
                                                    controller: logic.couponCnt,
                                                    decoration: const InputDecoration(
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
                                                        width: screenWidth / 4,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        alignment:
                                                            Alignment.center,
                                                        decoration:
                                                            const BoxDecoration(
                                                                color:
                                                                    kPrimaryColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          10),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          10),
                                                                )),
                                                        child: const Text(
                                                          'Apply',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
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
                                                const Text(
                                                  'Tickets',
                                                  style: TextStyle(
                                                      color: kDarkGreyColor,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                Text(
                                                  '${logic.countTicketsPrice(tickets: snapShot.data?.data?.ticketsInvoice ?? [])} SAR',
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
                                                const Text(
                                                  'Services',
                                                  style: TextStyle(
                                                      color: kDarkGreyColor,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                Text(
                                                  '${logic.countServicesPrice(services: snapShot?.data?.data?.servicesInvoice ?? [])} SAR',
                                                  style: const TextStyle(
                                                      color: kDarkGreyColor,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Consumer(
                                            builder: (context, ref, child) {
                                              ref.watch(
                                                  refundGuaranteeProvider);
                                              return !ref
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
                                                    );
                                            },
                                          ),
                                          Consumer(
                                            builder: (context, ref, child) {
                                              ref.watch(
                                                  sendMeTicketsVisSmsProvider);
                                              return !ref
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
                                            builder: (context, ref, child) {
                                              ref.watch(
                                                  sendMeTicketsVisWhatsappProvider);
                                              return !ref
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
                                            builder: (context, ref, child) {
                                              ref.watch(logic.couponApplied);
                                              return !ref
                                                      .read(logic.couponApplied
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
                                                            '- ${ref.read(total.notifier).state - ref.read(logic.totalAfterCoupon.notifier).state} SAR',
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
                                            builder: (context, ref, child) {
                                              ref.watch(total);
                                              ref.watch(logic.totalAfterCoupon);
                                              ref.watch(
                                                  sendMeTicketsVisWhatsappProvider);
                                              ref.watch(
                                                  sendMeTicketsVisSmsProvider);
                                              ref.watch(
                                                  refundGuaranteeProvider);
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
                                                    const Text(
                                                      'Total excl. VAT',
                                                      style: TextStyle(
                                                          color: kDarkGreyColor,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    Text(
                                                      logic.countTotalExclVat(
                                                        totalNet: (logic.countTicketsPrice(
                                                                tickets: snapShot
                                                                        .data
                                                                        ?.data
                                                                        ?.ticketsInvoice ??
                                                                    []) +
                                                            logic.countServicesPrice(
                                                                services: snapShot
                                                                        .data
                                                                        ?.data
                                                                        ?.servicesInvoice ??
                                                                    [])),
                                                        totalAfterCoupon: ref
                                                            .read(logic
                                                                .totalAfterCoupon
                                                                .notifier)
                                                            .state,
                                                        refund: ref
                                                                .read(refundGuaranteeProvider
                                                                    .notifier)
                                                                .state
                                                            ? logic
                                                                .refundServiceValue
                                                            : 0.0,
                                                        sms: ref
                                                                .read(sendMeTicketsVisSmsProvider
                                                                    .notifier)
                                                                .state
                                                            ? logic
                                                                .smsServiceValue
                                                            : 0.0,
                                                        whatsapp: ref
                                                                .read(sendMeTicketsVisWhatsappProvider
                                                                    .notifier)
                                                                .state
                                                            ? logic
                                                                .whatsAppServiceValue
                                                            : 0.0,
                                                      ),
                                                      style: const TextStyle(
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
                                          Consumer(
                                            builder: (context, ref, child) {
                                              ref.watch(total);
                                              ref.watch(logic.totalAfterCoupon);
                                              ref.watch(
                                                  sendMeTicketsVisWhatsappProvider);
                                              ref.watch(
                                                  sendMeTicketsVisSmsProvider);
                                              ref.watch(
                                                  refundGuaranteeProvider);
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
                                                      'Fees $fees%',
                                                      style: const TextStyle(
                                                          color: kDarkGreyColor,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    Text(
                                                      '${logic.countFeesValue(
                                                            vat: fees,
                                                            totalNet: (logic.countTicketsPrice(
                                                                    tickets: snapShot
                                                                            .data
                                                                            ?.data
                                                                            ?.ticketsInvoice ??
                                                                        []) +
                                                                logic.countServicesPrice(
                                                                    services: snapShot
                                                                            .data
                                                                            ?.data
                                                                            ?.servicesInvoice ??
                                                                        [])),
                                                            totalAfterCoupon: ref
                                                                .read(logic
                                                                    .totalAfterCoupon
                                                                    .notifier)
                                                                .state,
                                                            refund: ref
                                                                    .read(refundGuaranteeProvider
                                                                        .notifier)
                                                                    .state
                                                                ? logic
                                                                    .refundServiceValue
                                                                : 0,
                                                            sms: ref
                                                                    .read(sendMeTicketsVisSmsProvider
                                                                        .notifier)
                                                                    .state
                                                                ? logic
                                                                    .smsServiceValue
                                                                : 0,
                                                            whatsapp: ref
                                                                    .read(sendMeTicketsVisWhatsappProvider
                                                                        .notifier)
                                                                    .state
                                                                ? logic
                                                                    .whatsAppServiceValue
                                                                : 0,
                                                          ).toStringAsFixed(2)} SAR',
                                                      style: const TextStyle(
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
                                          Consumer(
                                            builder: (context, ref, child) {
                                              ref.watch(total);
                                              ref.watch(logic.totalAfterCoupon);
                                              ref.watch(
                                                  sendMeTicketsVisWhatsappProvider);
                                              ref.watch(
                                                  sendMeTicketsVisSmsProvider);
                                              ref.watch(
                                                  refundGuaranteeProvider);
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
                                                      'VAT $vat%',
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
                                                              vat: fees,
                                                              totalNet: (logic.countTicketsPrice(
                                                                      tickets: snapShot
                                                                              .data
                                                                              ?.data
                                                                              ?.ticketsInvoice ??
                                                                          []) +
                                                                  logic.countServicesPrice(
                                                                      services: snapShot
                                                                              .data
                                                                              ?.data
                                                                              ?.servicesInvoice ??
                                                                          [])),
                                                              totalAfterCoupon: ref
                                                                  .read(logic
                                                                      .totalAfterCoupon
                                                                      .notifier)
                                                                  .state,
                                                              refund: ref
                                                                      .read(refundGuaranteeProvider
                                                                          .notifier)
                                                                      .state
                                                                  ? logic
                                                                      .refundServiceValue
                                                                  : 0,
                                                              sms: ref
                                                                      .read(sendMeTicketsVisSmsProvider
                                                                          .notifier)
                                                                      .state
                                                                  ? logic
                                                                      .smsServiceValue
                                                                  : 0,
                                                              whatsapp: ref
                                                                      .read(sendMeTicketsVisWhatsappProvider
                                                                          .notifier)
                                                                      .state
                                                                  ? logic
                                                                      .whatsAppServiceValue
                                                                  : 0,
                                                            ),
                                                            totalNet: (logic.countTicketsPrice(
                                                                    tickets: snapShot
                                                                            .data
                                                                            ?.data
                                                                            ?.ticketsInvoice ??
                                                                        []) +
                                                                logic.countServicesPrice(
                                                                    services: snapShot
                                                                            .data
                                                                            ?.data
                                                                            ?.servicesInvoice ??
                                                                        [])),
                                                            totalAfterCoupon: ref
                                                                .read(logic
                                                                    .totalAfterCoupon
                                                                    .notifier)
                                                                .state,
                                                            refund: ref
                                                                    .read(refundGuaranteeProvider
                                                                        .notifier)
                                                                    .state
                                                                ? logic
                                                                    .refundServiceValue
                                                                : 0,
                                                            sms: ref
                                                                    .read(sendMeTicketsVisSmsProvider
                                                                        .notifier)
                                                                    .state
                                                                ? logic
                                                                    .smsServiceValue
                                                                : 0,
                                                            whatsapp: ref
                                                                    .read(sendMeTicketsVisWhatsappProvider
                                                                        .notifier)
                                                                    .state
                                                                ? logic
                                                                    .whatsAppServiceValue
                                                                : 0,
                                                          ).toStringAsFixed(2)} SAR',
                                                      style: const TextStyle(
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
                                        ],
                                      ),
                                    )
                                  ],
                                ))
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
      },
    );
    ;
  }
}
