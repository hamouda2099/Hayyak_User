import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/Dialogs/loading_dialog.dart';
import 'package:hayyak/Dialogs/message_dialog.dart';
import 'package:hayyak/Models/aviable_for_sale_model.dart';
import 'package:urwaypayment/urwaypayment.dart';

// import 'package:urwaypayment/urwaypayment.dart';

import '../../Config/user_data.dart';
import '../../Dialogs/order_created_successfully.dart';
import '../../Models/static_services_model.dart';
import '../../UI/Screens/home_screen.dart';
import '../Services/api_manger.dart';

class CheckoutLogic {
  late BuildContext context;
  late bool validateEmail;
  StaticServices? staticServices;
  String? eventId;
  String? orderId;
  String? terminalId;
  String? customerEmail;
  String? udf1;
  String? udf2;
  String? udf3;
  String? udf4;
  String? udf5;
  String? requestHash;
  String? paymentId;
  String? transId;
  String? eci;
  String? result;
  String? trackId;
  String? authCode;
  String? responseCode;
  String? rrn;
  String? responseHash;
  String? cardBrand;
  String? amount;
  String? userField1;
  String? userField2;
  String? userField3;
  String? userField4;
  String? userField5;
  String? cardToken;
  String? maskedBan;
  String? payFor;
  String? subscriptionId;
  String? paymentType;
  String tickets = '';
  String services = '';
  num discount = 0;
  num? vat = 0, fees = 0;
  num smsServiceValue = 0, refundServiceValue = 0, whatsAppServiceValue = 0;
  num totalTickets = 0;
  num totalServices = 0;
  num totalExclVat = 0;
  num totalVatVal = 0;
  num totalFeesVal = 0;
  num totalAfterCouponValue = 0;
  num generalTotal = 0;
  final totalAfterCoupon = StateProvider((ref) => 0);
  final refresh = StateProvider<String>((ref) => '');
  final couponApplied = StateProvider((ref) => false);
  TextEditingController couponCnt = TextEditingController();

  Future init(AsyncSnapshot<AvailableTicketsForSaleModel> snapshot) async {
    totalTickets =
        countTicketsPrice(tickets: snapshot.data?.data?.ticketsInvoice ?? []);
    totalServices = countServicesPrice(
        services: snapshot.data?.data?.servicesInvoice ?? []);
    totalExclVat =
        countTotalExclVat(sms: false, refund: false, whatsapp: false);
    totalFeesVal = countFeesValue(
        sms: false, refund: false, whatsapp: false, fees: fees ?? 0);
    totalVatVal = countVatValue(
        sms: false,
        refund: false,
        whatsapp: false,
        vat: vat,
        fees: totalFeesVal);
    generalTotal = totalExclVat + totalFeesVal + totalVatVal;
  }

  createOrder({
    required String eventId,
    required String sms,
    required String refund,
    required String whatsapp,
    required String amount,
    required String date,
    required String couponId,
  }) {
    loadingDialog(context);
    ApiManger.createOrder(
            eventId: eventId,
            tickets: tickets,
            services: services,
            sms: sms,
            refund: refund,
            whatsapp: whatsapp,
            amount: amount,
            date: date,
            userId: UserData.id.toString(),
            couponId: couponId,
            userRole: UserData.role!,
            token: UserData.token!)
        .then((value) {
      print(value);
      Navigator.pop(context);
      if (value['code'] == 200) {
        orderId = value['data']['order']['order_id'].toString() ?? '';
        if (UserData.role == 'member') {
          orderCreatedSuccessfully(context: context);
        } else {
          onlinePayment(context: context, amount: double.parse(amount));
        }
      } else {
        messageDialog(context, 'An error occurred');
      }
    });
  }

  String _convertToJsonStringQuotes({required String raw}) {
    String jsonString = raw.replaceAll(" ", "");

    jsonString = jsonString.replaceAll('{', '{"');
    jsonString = jsonString.replaceAll(':', '": "');
    jsonString = jsonString.replaceAll(',', '", "');
    jsonString = jsonString.replaceAll('}', '"}');

    jsonString = jsonString.replaceAll('"{"', '{"');
    jsonString = jsonString.replaceAll('"}"', '"}');

    jsonString = jsonString.replaceAll('"[{', '[{');
    jsonString = jsonString.replaceAll('}]"', '}]');

    return jsonString;
  }

  onlinePayment({required BuildContext context, required double amount}) {
    loadingDialog(context);
    Payment.makepaymentService(
      context: context,
      country: 'SA',
      action: '4',
      currency: 'SAR',
      amt: amount.toString(),
      customerEmail: UserData.email ?? '',
      trackid: 'FLUTTER_456353577432',
      udf1: 'text',
      udf2: '',
      udf3: 'EN',
      udf4: '',
      udf5: 'Text6',
      tokenizationType: '2',
      address: '',
      cardToken: '',
      city: '',
      state: '',
      tokenOperation: 'A',
      zipCode: '21442',
    ).then((value) {
      Navigator.pop(context);
      try {
        String res = _convertToJsonStringQuotes(raw: value);
        Map decodedRes = jsonDecode(res);
        paymentId = decodedRes['PaymentId'];
        transId = decodedRes['TranId'];
        eci = decodedRes['ECI'];
        result = decodedRes['Result'];
        trackId = decodedRes['TrackId'];
        responseCode = decodedRes['ResponseCode'];
        rrn = decodedRes['RRN'];
        responseHash = decodedRes['responseHash'];
        cardBrand = decodedRes['MASTER'];
        userField1 = decodedRes['UserField1'];
        userField2 = decodedRes['UserField2'];
        userField3 = decodedRes['UserField3'];
        userField4 = decodedRes['UserField4'];
        userField5 = decodedRes['UserField5'];
        cardToken = decodedRes['cardToken'];
        maskedBan = decodedRes['maskedPAN'];
        payFor = decodedRes['payFor'];
        subscriptionId = decodedRes['SubscriptionId'];
        paymentType = decodedRes['PaymentType'];
      } catch (e) {
        print("*************************");
      }
      if (result == 'Successful') {
        ApiManger.payOrder(
          orderId: orderId,
          payStatus: 'success',
          // paymentId: paymentId,
          // tranId: transId,
          // eci: eci,
          // result: result,
          // trackId: trackId,
          // authCode: authCode??'',
          // responseCode: responseCode,
          // rrn: rrn,
          // responseHash: responseHash,
          // amount: amount.toString(),
          // cardBrand: cardBrand,
          // userField1: userField1,
          // userField2: userField2,
          // userField3: userField3,
          // userField4: userField4,
          // userField5: userField5,
          // maskedPAN: maskedBan,
          // cardToken: cardToken,
          // subscriptionId: subscriptionId,
          // email: UserData.email,
          // payFor: payFor,
          // payId: paymentId,
          // terminalid: terminalId,
          // udf1: udf1,
          // udf2: udf2,
          // udf3: udf3,
          // udf4: udf4,
          // udf5: udf5,
          // tranDate: '',
          // tranType: '',
          // integrationModule: '',
          // integrationData: '',
          // targetUrl: '',
          // postData: '',
          // intUrl: '',
          // linkBasedUrl: '',
          // sadadNumber: '',
          // billNumber: '',
          // responseMsg: '',
        ).then((value) {
          print(value);
          if (value['success'] == true) {
            navigator(context: context, screen: HomeScreen(), remove: true);
            messageDialog(context, "Orders created successfully!");
          } else {
            messageDialog(context, "an error occured, please contact us");
          }
        });
      } else {
        messageDialog(context, "an error occured, please contact us");
      }
    });
  }

  initStaticServices(
      {required AsyncSnapshot<StaticServices> snapShot,
      required BuildContext context,
      required List tickets}) {
    smsServiceValue = (snapShot.data?.data?.sms?.value ?? 0) * tickets.length;
    refundServiceValue =
        (snapShot.data?.data?.refund?.value ?? 0) * tickets.length;
    whatsAppServiceValue =
        (snapShot.data?.data?.whatsapp?.value ?? 0) * tickets.length;
  }

  applyCoupon(
      {required num total,
      required BuildContext context,
      required WidgetRef ref}) {
    loadingDialog(context);
    ApiManger.applyCoupon(total: total, coupon: couponCnt.text).then((value) {
      Navigator.pop(context);
      if (value.statusCode == 200) {
        ref.read(couponApplied.notifier).state = true;
        ref.read(totalAfterCoupon.notifier).state =
            jsonDecode(value.body)['data']['total_value_after_coupon'];
        totalAfterCouponValue =
            jsonDecode(value.body)['data']['total_value_after_coupon'];
      } else {
        messageDialog(context, 'Coupon not valid !');
      }
    });
  }

  num countTicketsPrice({required List<TicketsInvoice> tickets}) {
    double total = 0;
    if (tickets == []) {
      total = 0.0;
    } else {
      for (var element in tickets) {
        total = total + element.finalCost!.toDouble();
      }
    }
    return total;
  }

  num countServicesPrice({required List<ServicesInvoice> services}) {
    double total = 0;
    if (services == []) {
      total = 0.0;
    } else {
      for (var element in services) {
        total = total + element.cost!.toDouble();
      }
    }
    return total;
  }

  num? countReceipt(bool sms, bool whats, bool refund) {
    num? total = 0;
    total =
        total + countTotalExclVat(sms: sms, whatsapp: whats, refund: refund);
    total = total +
        countFeesValue(
            sms: sms, whatsapp: whats, refund: refund, fees: fees ?? 0);
    total = total +
        countVatValue(
            sms: sms,
            fees: totalFeesVal,
            whatsapp: whats,
            refund: refund,
            vat: vat);
    return total;
  }

  num countTotalExclVat({required bool sms, whatsapp, refund}) {
    num total = 0;
    if (totalAfterCouponValue == 0) {
      total = (totalTickets + totalServices) +
          ((sms ? smsServiceValue : 0) +
              (whatsapp ? whatsAppServiceValue : 0) +
              (refund ? refundServiceValue : 0));
    } else {
      total = totalAfterCouponValue +
          ((sms ? smsServiceValue : 0) +
              (whatsapp ? whatsAppServiceValue : 0) +
              (refund ? refundServiceValue : 0));
    }
    totalExclVat = total;
    return total;
  }

  num countVatValue(
      {required bool sms, whatsapp, refund, vat, required num fees}) {
    num vatVal = 0;
    if (totalAfterCouponValue == 0) {
      vatVal = (totalTickets + totalServices) +
          (sms ? smsServiceValue : 0) +
          (whatsapp ? whatsAppServiceValue : 0) +
          (refund ? refundServiceValue : 0) +
          fees;
      vatVal = ((vatVal * vat) / 100);
    } else {
      vatVal = totalAfterCouponValue +
          (sms ? smsServiceValue : 0) +
          (whatsapp ? whatsAppServiceValue : 0) +
          (refund ? refundServiceValue : 0) +
          fees;
      vatVal = ((vatVal * vat) / 100);
    }
    totalVatVal = vatVal;
    return vatVal;
  }

  num countFeesValue({required bool sms, whatsapp, refund, required num fees}) {
    num vatVal = 0;
    if (totalAfterCouponValue == 0) {
      vatVal = (totalTickets + totalServices) +
          (sms ? smsServiceValue : 0) +
          (whatsapp ? whatsAppServiceValue : 0) +
          (refund ? refundServiceValue : 0);
      vatVal = ((vatVal * fees) / 100);
    } else {
      vatVal = totalAfterCouponValue +
          (sms ? smsServiceValue : 0) +
          (whatsapp ? whatsAppServiceValue : 0) +
          (refund ? refundServiceValue : 0);
      vatVal = ((vatVal * fees) / 100);
    }
    totalFeesVal = vatVal;
    return vatVal;
  }

  initDataToCheckAvailable(
      {required List selectedTickets,
      required List selectedServices,
      required String receiptType}) async {
    // if (selectedTickets.isEmpty && selectedServices.isEmpty) {
    // } else {
    tickets = '';
    services = '';
    if (receiptType == 'seats') {
      for (var element in selectedTickets) {
        tickets = '$tickets$element,';
      }
      if (selectedServices.isNotEmpty) {
        for (var element in selectedServices) {
          services =
              '$services${element['service']['id']},${element['count']},';
        }
        services = services.substring(0, services.length - 1);
      }
    } else {
      for (var element in selectedTickets) {
        tickets = '$tickets${element['id']},';
      }
      if (selectedServices.isNotEmpty) {
        for (var element in selectedServices) {
          services =
              '$services${element['service']['id']},${element['count']},';
        }
        services = services.substring(0, services.length - 1);
      }
    }
    await ApiManger.getStaticServices(eventId: eventId).then((value) {
      staticServices = value;
      smsServiceValue = (value.data?.sms?.value ?? 0) * selectedTickets.length;
      refundServiceValue =
          (value.data?.refund?.value ?? 0) * selectedTickets.length;
      whatsAppServiceValue =
          (value.data?.whatsapp?.value ?? 0) * selectedTickets.length;
    });
    // }
  }
}
