import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/Config/user_data.dart';
import 'package:hayyak/Dialogs/loading_dialog.dart';
import 'package:hayyak/Dialogs/message_dialog.dart';
import 'package:hayyak/Logic/Services/api_manger.dart';
import 'package:hayyak/States/providers.dart';
import 'package:hive/hive.dart';

class LoginLogic {
  late WidgetRef ref;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // final FacebookAuth facebookAuth = FacebookAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  static void login(BuildContext context,
      {@required email,
      @required password,
      required var screen,
      required WidgetRef ref,
      required String signType}) {
    if (email == '' || password == '') {
      messageDialog(context, 'Email Or Password Wrong !');
    } else {
      loadingDialog(context);
      ApiManger.userLogin(email: email, password: password, signType: signType)
          .then((value) async {
        Navigator.pop(context);
        ApiManger.getTranslationsKeys().then((value) {
          UserData.translation = value;
        });
        if (jsonDecode(value.body)['success'] == true ||
            jsonDecode(value.body)['code'] == 200) {
          UserData.token = jsonDecode(value.body)['data']['token'];
          UserData.id = jsonDecode(value.body)['data']['id'];
          // UserData.userName = jsonDecode(value.body)['data']['name'];
          UserData.role = jsonDecode(value.body)['data']['role'];
          UserData.email = jsonDecode(value.body)['data']['email'];
          UserData.phone = jsonDecode(value.body)['data']['phone'];
          UserData.imageUrl = jsonDecode(value.body)['data']['image'];
          UserData.language = localLanguage;
          if (ref.read(rememberMeProvider.notifier).state == true) {
            Hive.box('user_data').put('logged_in', true);
            Hive.box('user_data').put('token', UserData.token);
            Hive.box('user_data').put('translation', UserData.translation);
            Hive.box('user_data').put('role', UserData.role);
            Hive.box('user_data').put('id', UserData.id);
            Hive.box('user_data').put('name', UserData.userName);
            Hive.box('user_data').put('phone', UserData.phone);
            Hive.box('user_data').put('email', UserData.email);
            Hive.box('user_data').put('lang', UserData.language);
            Hive.box('user_data').put('image', UserData.imageUrl);
            Hive.box('user_data').put('lang', localLanguage);
          } else {
            null;
          }
          navigator(context: context, screen: screen, replacement: true);
        } else {
          messageDialog(context,
              '${jsonDecode(value.body)['error'] ?? 'An error occurred'}');
        }
      });
    }
  }

  googleLogin({
    required BuildContext context,
    required var screen,
  }) async {
    loadingDialog(context);
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    final GoogleSignInAuthentication? googleSignInAuthentication =
        await googleSignInAccount?.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken);
    final UserCredential user =
        await firebaseAuth.signInWithCredential(credential);
    return await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((value) {
      Navigator.pop(context);
      if (user.user?.emailVerified ?? false) {
        login(context,
            email: value.user?.email,
            password: 'null',
            screen: screen,
            ref: ref,
            signType: 'social');
      } else {}
    });
  }
}
