import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Logic/UI%20Logic/checkout_logic.dart';
import 'package:moyasar/moyasar.dart';

import '../../main.dart';

class PaymentMethods extends StatelessWidget {
  PaymentMethods(
      {this.description, this.amount, this.orderId, required this.logic});

  CheckoutLogic logic = CheckoutLogic();
  String? description;
  String? orderId;
  num? amount;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: kDarkGreyColor,
          ),
        ),
        title: const Text(
          "Online Payment",
          style: TextStyle(color: kDarkGreyColor, fontSize: 16),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image(
              width: screenWidth / 1.5,
              image: const AssetImage('assets/images/grey_logo.png'),
            ),
            SizedBox(
              height: screenHeight / 8,
            ),
            ApplePay(
              config: logic.paymentConfig!,
              onPaymentResult: logic.onPaymentResult,
            ),
            Platform.isIOS ? const Text("or") : const SizedBox(),
            CreditCard(
              config: logic.paymentConfig!,
              onPaymentResult: logic.onPaymentResult,
            )
          ],
        ),
      ),
    );
  }
}
