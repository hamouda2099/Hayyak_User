import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/src/provider.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/Config/user_data.dart';
import 'package:hayyak/States/providers.dart';

import 'package:http/http.dart' as http;

import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../UI/Screens/error_screen.dart';

class ApiManger {
  static const String hostUrl = 'https://hayyak.net';
  static const String _loginUrl = '$hostUrl/api/scanner/login';
  static const String _placesUrl = '$hostUrl/api/scanner/places';
  static const String _placeDashboardUrl = '$hostUrl/api/scanner/dashboard';
  static const String _eventDashboardUrl =
      '$hostUrl/api/scanner/dashboard_event';
  static const String _placeDashboardDetailsUrl =
      'https://hayyak.net/api/scanner/details';
  static const String _eventsUrl = '$hostUrl/api/scanner/event';
  static const String _serviceUrl = '$hostUrl/api/scanner/check_in_servise';
  static const String _order = '$hostUrl/api/scanner/order';
  static const String _service = '$hostUrl/api/scanner/service';
  static const String _category = '$hostUrl/api/scanner/category';
  static const String _orders = '$hostUrl/api/scanner/order';
  static const String _timeDateUrl =
      'https://hayyak.net/api/scanner/data/curr_date';
  static Future<http.Response> sendPostRequest(
      String url, Map<String, dynamic> parameters) async {
    return await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + UserData.token,
      },
      body: jsonEncode(parameters),
    );
  }

  static Future<http.Response> sendGetRequest(String url) async {
    return await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + UserData.token,
      },
    );
  }

  static Future<Response> userLogin({
    required String email,
    required String password,
  }) async {
    return await sendPostRequest(_loginUrl, <String, String>{
      'email': email,
      'password': password,
    });
  }

  static Future getTime(BuildContext context) async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      final response = await sendGetRequest(_timeDateUrl);
      context.read(dateTimeProvider).state = jsonDecode(response.body);
      print(context.read(dateTimeProvider).state);
      return jsonDecode(response.body);
    } else {
      navigator(context: context, screen: const ErrorScreen());
    }
  }


}
