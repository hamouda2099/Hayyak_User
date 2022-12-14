import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/States/providers.dart';
import 'package:hayyak/UI/Components/custom_app_bar.dart';
import 'package:hayyak/UI/Components/seccond_app_bar.dart';
import 'package:hayyak/main.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  'Total',
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
                navigator(context: context, screen: CheckoutScreen());
              },
              child: Container(
                alignment: Alignment.center,
                width: screenWidth / 1.5,
                height: 50,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'PAY',
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
            SecondAppBar(title: 'Checkout'),
            Container(
              width: screenWidth,
              height: screenHeight / 1.3,
              child: ListView(
                children: [
                  Container(
                    width: screenWidth / 1.2,
                    height: screenHeight / 6,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image:
                              AssetImage('assets/images/amr-diab-promo.jpg')),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    width: screenWidth / 1.2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text('Amr Diab',
                            style: TextStyle(
                                color: kLightGreyColor, fontSize: 14)),
                        Row(
                          children: [
                            SvgPicture.asset(
                                color: kLightGreyColor,
                                width: 20,
                                height: 20,
                                'assets/icon/Icon material-event.svg'),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
                              'Sat, Mar 12',
                              style: TextStyle(
                                  color: kLightGreyColor, fontSize: 14),
                            )
                          ],
                        ),
                        Row(
                          children: const [
                            Icon(
                              Icons.access_time_outlined,
                              color: kLightGreyColor,
                              size: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '7:00 - 10:00 PM',
                              style: TextStyle(
                                  color: kLightGreyColor, fontSize: 14),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: screenWidth / 1.2,
                    height: screenHeight / 8,
                    child: ListView.builder(
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: const [
                                  Text(
                                    '3x',
                                    style: TextStyle(
                                        color: kPrimaryColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'VIP Admission',
                                    style: TextStyle(
                                        color: kLightGreyColor, fontSize: 16),
                                  )
                                ],
                              ),
                              const Text(
                                '50 SAR',
                                style: TextStyle(
                                    color: kLightGreyColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Consumer(
                    builder: (context, watch, child) {
                      final termsAndConditions =
                          watch(termsAndConditionsProvider).state;
                      return Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                if (termsAndConditions == false) {
                                  context
                                      .read(termsAndConditionsProvider)
                                      .state = true;
                                } else {
                                  context
                                      .read(termsAndConditionsProvider)
                                      .state = false;
                                }
                              },
                              icon: termsAndConditions == false
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
                            Text(
                              'Accept all',
                              style: TextStyle(
                                  color: kDarkGreyColor.withOpacity(0.6),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                            InkWell(
                              onTap: () {},
                              child: const Text(
                                ' terms & conditions',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                        left: 30.0, right: 30, top: 10, bottom: 10),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Terms And Conditions',
                          style: TextStyle(
                              color: kLightGreyColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 30.0, right: 30),
                    child: Text(
                      'The big night for Amr Diab The big night for Amr Diab '
                      ' The big night for Amr Diab',
                      style: TextStyle(color: kLightGreyColor, fontSize: 14),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: screenWidth / 1.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: kLightGreyColor.withOpacity(0.2), width: 1)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: screenWidth / 2,
                          padding: const EdgeInsets.only(left: 10),
                          child: const TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter Promo Code'),
                          ),
                        ),
                        Container(
                          width: screenWidth / 4,
                          padding: EdgeInsets.all(15),
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              )),
                          child: const Text(
                            'Apply',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                        left: 30.0, right: 30, top: 10, bottom: 10),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Payment Method',
                          style: TextStyle(
                              color: kLightGreyColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: kLightGreyColor.withOpacity(0.5), width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              kLightGreyColor.withOpacity(0.5),
                                          width: 1),
                                      shape: BoxShape.circle),
                                  child: Icon(
                                    Icons.circle,
                                    color: Colors.blue,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Card',
                                  style: TextStyle(
                                      color: kLightGreyColor, fontSize: 14),
                                ),
                              ],
                            ),
                            Row(
                              children: const [
                                Image(
                                  width: 30,
                                  image: NetworkImage(
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMB6KwAcMDUZz3BiN7DD3vNksHmhiHlwQ8Qg&usqp=CAU'),
                                ),
                                Image(
                                  width: 30,
                                  image: NetworkImage(
                                      'https://logoeps.com/wp-content/uploads/2011/08/mastercard-logo.png'),
                                ),
                                Image(
                                  width: 30,
                                  image: NetworkImage(
                                      'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/Visa_Inc._logo.svg/1000px-Visa_Inc._logo.svg.png'),
                                ),
                              ],
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10, left: 5),
                          padding: EdgeInsets.only(left: 5, right: 5),
                          width: screenWidth / 1.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                color: kLightGreyColor.withOpacity(0.5),
                                width: 1),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: 'Card Number',
                                border: InputBorder.none,
                                hintStyle: TextStyle(fontSize: 12)),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 10, left: 5),
                              padding: EdgeInsets.only(left: 5, right: 5),
                              width: screenWidth / 4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    color: kLightGreyColor.withOpacity(0.5),
                                    width: 1),
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                    hintText: 'Expiry month',
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(fontSize: 12)),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10, left: 5),
                              padding: EdgeInsets.only(left: 5, right: 5),
                              width: screenWidth / 4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    color: kLightGreyColor.withOpacity(0.5),
                                    width: 1),
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Expiry year',
                                    hintStyle: TextStyle(fontSize: 12)),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10, left: 5),
                              padding: EdgeInsets.only(left: 5, right: 5),
                              width: screenWidth / 4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    color: kLightGreyColor.withOpacity(0.5),
                                    width: 1),
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'CVV',
                                    hintStyle: TextStyle(fontSize: 12)),
                              ),
                            ),
                          ],
                        ),
                        Consumer(
                          builder: (context, watch, child) {
                            final saveMyCardDetails =
                                watch(saveMyCardDetailsProvider).state;
                            return Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    if (saveMyCardDetails == false) {
                                      context
                                          .read(saveMyCardDetailsProvider)
                                          .state = true;
                                    } else {
                                      context
                                          .read(saveMyCardDetailsProvider)
                                          .state = false;
                                    }
                                  },
                                  icon: saveMyCardDetails == false
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
                                Text(
                                  'Save my card details',
                                  style: TextStyle(
                                      color: kDarkGreyColor.withOpacity(0.6),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                        left: 20.0, right: 20, top: 10, bottom: 10),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Additional services',
                          style: TextStyle(
                              color: kLightGreyColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                  Consumer(
                    builder: (context, watch, child) {
                      final refundGuarantee =
                          watch(refundGuaranteeProvider).state;
                      return Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              if (refundGuarantee == false) {
                                context.read(refundGuaranteeProvider).state =
                                    true;
                              } else {
                                context.read(refundGuaranteeProvider).state =
                                    false;
                              }
                            },
                            icon: refundGuarantee == false
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
                          Text(
                            'Refund Guarantee',
                            style: TextStyle(
                                color: kDarkGreyColor.withOpacity(0.6),
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      );
                    },
                  ),
                  Consumer(
                    builder: (context, watch, child) {
                      final sendMeTicketsVisSms =
                          watch(sendMeTicketsVisSmsProvider).state;
                      return Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              if (sendMeTicketsVisSms == false) {
                                context
                                    .read(sendMeTicketsVisSmsProvider)
                                    .state = true;
                              } else {
                                context
                                    .read(sendMeTicketsVisSmsProvider)
                                    .state = false;
                              }
                            },
                            icon: sendMeTicketsVisSms == false
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
                          Text(
                            'Send me tickets vis sms',
                            style: TextStyle(
                                color: kDarkGreyColor.withOpacity(0.6),
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      );
                    },
                  ),
                  Consumer(
                    builder: (context, watch, child) {
                      final sendMeTicketsVisWhatsapp =
                          watch(sendMeTicketsVisWhatsappProvider).state;
                      return Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              if (sendMeTicketsVisWhatsapp == false) {
                                context
                                    .read(sendMeTicketsVisWhatsappProvider)
                                    .state = true;
                              } else {
                                context
                                    .read(sendMeTicketsVisWhatsappProvider)
                                    .state = false;
                              }
                            },
                            icon: sendMeTicketsVisWhatsapp == false
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
                          Text(
                            'Send me tickets vis Whatsapp',
                            style: TextStyle(
                                color: kDarkGreyColor.withOpacity(0.6),
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      );
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                        left: 20.0, right: 20, top: 10, bottom: 10),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Summary',
                          style: TextStyle(
                              color: kLightGreyColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 20.0, right: 20, top: 5, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Tickets',
                          style: TextStyle(
                              color: kDarkGreyColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          '180 SAR',
                          style: TextStyle(
                              color: kDarkGreyColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 20.0, right: 20, top: 5, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Refund Gurarantee',
                          style: TextStyle(
                              color: kDarkGreyColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          '10.50 SAR',
                          style: TextStyle(
                              color: kDarkGreyColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 20.0, right: 20, top: 5, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Send me tickets vis sms',
                          style: TextStyle(
                              color: kDarkGreyColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          '2.00 SAR',
                          style: TextStyle(
                              color: kDarkGreyColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 20.0, right: 20, top: 5, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Send me tickets vis Whatsapp',
                          style: TextStyle(
                              color: kDarkGreyColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          '2.00 SAR',
                          style: TextStyle(
                              color: kDarkGreyColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    width: screenWidth / 1.2,
                    child: Divider(
                      height: 1,
                      color: kLightGreyColor,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 20.0, right: 20, top: 5, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Total excl. VAT',
                          style: TextStyle(
                              color: kDarkGreyColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          '194.50 SAR',
                          style: TextStyle(
                              color: kDarkGreyColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 20.0, right: 20, top: 5, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'VAT 5%',
                          style: TextStyle(
                              color: kDarkGreyColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          '10.50 SAR',
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
            ),
          ],
        ),
      ),
    );
  }
}
