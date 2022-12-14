import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/src/provider.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/Config/user_data.dart';
import 'package:hayyak/Dialogs/loading_dialog.dart';
import 'package:hayyak/Dialogs/message_dialog.dart';
import 'package:hayyak/Logic/Services/api_manger.dart';
import 'package:hayyak/States/providers.dart';
import 'package:hayyak/UI/Screens/home_screen.dart';
import 'package:hayyak/UI/Screens/login_screen.dart';

import 'package:hive/hive.dart';

class LoginLogic {
  static void login(BuildContext context,
      {@required email, @required password}) {
    if (email == '' || password == '') {
      messageDialog(context, 'Email Or Password Wrong !');
    } else {
      loadingDialog(context);
      ApiManger.userLogin(email: email, password: password).then((value) async {
        Navigator.pop(context);
        if (jsonDecode(value.body)['success'] == true ||
            jsonDecode(value.body)['code'] == 200) {
          UserData.token = jsonDecode(value.body)['data']['token'];
          UserData.id = jsonDecode(value.body)['data']['id'];
          // UserData.userName = jsonDecode(value.body)['data']['name'];
          UserData.role = jsonDecode(value.body)['data']['role'];
          UserData.email = jsonDecode(value.body)['data']['email'];
          UserData.phone = jsonDecode(value.body)['data']['phone'];
          UserData.imageUrl = jsonDecode(value.body)['data']['image'];
          navigator(context: context, screen:  HomeScreen(), remove: true);
        } else {
          messageDialog(context, '${jsonDecode(value.body)['error']}');
        }
      });
    }
  }
}
