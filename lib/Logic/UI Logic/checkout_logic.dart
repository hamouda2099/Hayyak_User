import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hayyak/Dialogs/loading_dialog.dart';
import 'package:hayyak/Dialogs/message_dialog.dart';
import 'package:hayyak/Models/aviable_for_sale_model.dart';
import 'package:urwaypayment/urwaypayment.dart';

// import 'package:urwaypayment/urwaypayment.dart';

import '../../Config/user_data.dart';
import '../../Models/static_services_model.dart';
import '../Services/api_manger.dart';

class CheckoutLogic {
  late BuildContext context;
  late bool validateEmail;
  String tickets = '';
  String services = '';
  num discount = 0;
  num smsServiceValue = 0, refundServiceValue = 0, whatsAppServiceValue = 0;
  num totalTickets = 0;
  num totalServices = 0;
  num totalExclVat = 0;
  num totalVatVal = 0;
  num totalFeesVal = 0;
  final totalAfterCoupon = StateProvider((ref) => 0);
  final couponApplied = StateProvider((ref) => false);
  TextEditingController couponCnt = TextEditingController();

  onlinePayment({required BuildContext context}) {
    Payment.makepaymentService(
      context: context,
      country: 'SA',
      action: '4',
      currency: 'SAR',
      amt: '1000',
      customerEmail: UserData.email,
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
    ).then((value) {});
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
    totalTickets = total;
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
    totalServices = total;
    return total;
  }

  String countTotalExclVat(
      {required num totalNet, totalAfterCoupon, sms, whatsapp, refund}) {
    num total = 0;
    if (totalAfterCoupon == 0) {
      total = totalNet + sms + whatsapp + refund;
    } else {
      total = totalAfterCoupon + sms + whatsapp + refund;
    }
    totalExclVat = total;
    return '$total';
  }

  num countVatValue(
      {required num? totalNet,
      totalAfterCoupon,
      sms,
      whatsapp,
      refund,
      vat,
      fees}) {
    num vatVal = 0;
    if (totalAfterCoupon == 0) {
      vatVal = (totalNet?.toInt())! + sms + whatsapp + refund + fees;
      vatVal = ((vatVal * vat) / 100);
    } else {
      vatVal = totalAfterCoupon + sms + whatsapp + refund + fees;
      vatVal = ((vatVal * vat) / 100);
    }
    totalVatVal = vatVal;
    return vatVal;
  }

  num countFeesValue(
      {required num totalNet, totalAfterCoupon, sms, whatsapp, refund, vat}) {
    num vatVal = 0;
    if (totalAfterCoupon == 0) {
      vatVal = totalNet + sms + whatsapp + refund;
      vatVal = ((vatVal * vat) / 100);
    } else {
      vatVal = totalAfterCoupon + sms + whatsapp + refund;
      vatVal = ((vatVal * vat) / 100);
    }
    totalFeesVal = vatVal;
    return vatVal;
  }

  num countFinalTotal() {
    num total = 0;
    total = total + totalExclVat + totalFeesVal + totalVatVal;
    return total;
  }

  initDataToCheckAvailable(
      {required List selectedTickets,
      required List selectedServices,
      required String receiptType}) {
    if (selectedTickets.isEmpty || selectedServices.isEmpty) {
    } else {
      tickets = '';
      services = '';
      if (receiptType == 'seats') {
        for (var element in selectedTickets) {
          tickets = '$tickets$element,';
        }
        for (var element in selectedServices) {
          services =
              '$services${element['service']['id']},${element['count']},';
        }
        services = services.substring(0, services.length - 1);
      } else {
        for (var element in selectedTickets) {
          tickets = '$tickets${element['id']},';
        }
        for (var element in selectedServices) {
          services =
              '$services${element['service']['id']},${element['count']},';
        }
        services = services.substring(0, services.length - 1);
      }
    }
  }
}
