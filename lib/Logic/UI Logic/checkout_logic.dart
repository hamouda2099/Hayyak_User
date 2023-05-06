import 'package:flutter/cupertino.dart';
import 'package:hayyak/Dialogs/loading_dialog.dart';
import 'package:urwaypayment/urwaypayment.dart';

import '../../Config/user_data.dart';
import '../Services/api_manger.dart';

class CheckoutLogic {
  late BuildContext context;
  late bool validateEmail;
  TextEditingController couponCnt = TextEditingController();
  onlinePayment({required BuildContext context}){
    // bool validateSuccess;
    // validateEmail =  Payment.isValidEmailchk(UserData.email);
    // if (validateEmail){
    //   validateSuccess = Payment.isValidationSucess(context, '10', UserData.email, 'A', 'SA', 'SAR', 'Flutter_76376', 'A', '5123450000000009');
    //   if (validateSuccess){
    //     print('validate success');
    //
    //   }
    // }
    Payment.makepaymentService(
        context: context,
        country: 'SA',
        action: '4',
        currency: 'SAR',
        amt: '1000',
        customerEmail: 'sameh.agag.2010@gmail.com',
        trackid: 'FLUTTER_456353577432',
        udf1: 'sjdhkas',
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
        metadata: ''
    ).then((value){
      print(value);
    });
  }
  applyCoupon({required num total}){
    loadingDialog(context);
    ApiManger.applyCoupon(total: total.toDouble(), coupon: couponCnt.text).then((value){
      Navigator.pop(context);
      if (value.statusCode == 200){
        print(value.body);
      } else {
        print(value.body);
      }
    });
  }
}