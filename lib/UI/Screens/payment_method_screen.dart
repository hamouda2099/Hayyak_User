import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:moyasar/moyasar.dart';

import '../../main.dart';

class PaymentMethods extends StatelessWidget {
  PaymentMethods({this.description, this.amount});
  PaymentConfig? paymentConfig;
  String? description;
  num? amount;

  void onPaymentResult(result) {
    if (result is PaymentResponse) {
      if (result.status == PaymentStatus.paid) {
        print(result.status);
        print(result.source);
        print(result.updatedAt);
        print(result.refunded);
        // ApiManger.payOrder(
        //   orderId: orderId,
        //   payStatus: 'success',
        //   // paymentId: paymentId,
        //   // tranId: transId,
        //   // eci: eci,
        //   // result: result,
        //   // trackId: trackId,
        //   // authCode: authCode??'',
        //   // responseCode: responseCode,
        //   // rrn: rrn,
        //   // responseHash: responseHash,
        //   // amount: amount.toString(),
        //   // cardBrand: cardBrand,
        //   // userField1: userField1,
        //   // userField2: userField2,
        //   // userField3: userField3,
        //   // userField4: userField4,
        //   // userField5: userField5,
        //   // maskedPAN: maskedBan,
        //   // cardToken: cardToken,
        //   // subscriptionId: subscriptionId,
        //   // email: UserData.email,
        //   // payFor: payFor,
        //   // payId: paymentId,
        //   // terminalid: terminalId,
        //   // udf1: udf1,
        //   // udf2: udf2,
        //   // udf3: udf3,
        //   // udf4: udf4,
        //   // udf5: udf5,
        //   // tranDate: '',
        //   // tranType: '',
        //   // integrationModule: '',
        //   // integrationData: '',
        //   // targetUrl: '',
        //   // postData: '',
        //   // intUrl: '',
        //   // linkBasedUrl: '',
        //   // sadadNumber: '',
        //   // billNumber: '',
        //   // responseMsg: '',
        // ).then((value) {
        //   if (value['success'] == true) {
        //     navigator(context: context, screen: HomeScreen(), remove: true);
        //     messageDialog(context, "Orders created successfully!");
        //   } else {
        //     messageDialog(context, "an error occured, please contact us");
        //   }
        // });
        // } else {
        //   messageDialog(context, "an error occured, please contact us");
        // }
      } else if (result.status == PaymentStatus.failed) {
        print(result.metadata);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      paymentConfig = PaymentConfig(
        publishableApiKey: 'pk_test_wS13FMSHPN7CxmVhiZD3msn5L2FfDJFTqeVDSkzD',
        amount: (amount ?? 0 * 100).toInt(), // SAR 257.58
        description: description ?? '',
        metadata: {'size': '250g'},
        creditCard: CreditCardConfig(saveCard: true, manual: false),
        applePay: ApplePayConfig(
            merchantId: 'sk_test_k6R4UubCbhZCnGfKD9SfMMdHZzrmPsemkccBWpVg',
            label: 'Hayyak Events',
            manual: false),
      );
    });
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
              config: paymentConfig!,
              onPaymentResult: onPaymentResult,
            ),
            Platform.isIOS ? const Text("or") : SizedBox(),
            CreditCard(
              config: paymentConfig!,
              onPaymentResult: onPaymentResult,
            )
          ],
        ),
      ),
    );
  }
}
