import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/src/provider.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/Config/user_data.dart';
import 'package:hayyak/Models/event_model.dart';
import 'package:hayyak/Models/event_tickets_model.dart';
import 'package:hayyak/Models/fav_list_model.dart';
import 'package:hayyak/Models/home_model.dart';
import 'package:hayyak/Models/profile_model.dart';
import 'package:hayyak/States/providers.dart';
import 'package:hayyak/UI/Screens/favourite_list_screen.dart';

import 'package:http/http.dart' as http;

import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../UI/Screens/error_screen.dart';

class ApiManger {
  static const String hostUrl = 'https://testing.hayyak.net/api';
  static const String _loginUrl = '$hostUrl/auth/login';
  static const String _signupUrl = '$hostUrl/auth/signup';
  static const String _requestOtpUrl = '$hostUrl/auth/request-otp';
  static const String _verifyOtp = '$hostUrl/auth/verify-otp';
  static const String _exploreUrl = '$hostUrl/events/explore';
  static const String _eventDetails = '$hostUrl/event';
  static const String _favUrl = '$hostUrl/favorites';
  static const String _profileUrl = '$hostUrl/user/profile';

  static const String _timeDateUrl =
      'https://hayyak.net/api/scanner/data/curr_date';

  static Future<http.Response> sendPostRequest(
      String url, Map<String, dynamic> parameters) async {
    return await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${UserData.token}',
        'lang': 'en'
      },
      body: jsonEncode(parameters),
    );
  }

  static Future<http.Response> sendGetRequest(String url) async {
    return await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${UserData.token}',
        'lang': 'en',
        'user-id': UserData.id.toString()
      },
    );
  }

  static Future<http.Response> sendDeleteRequest(String url) async {
    return http.delete(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${UserData.token}',
        'accept-language': 'en',
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

  static Future<Response> registerUser({
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required String dateOfBirth,
    required String password,
    required String confirmPassword,
    required String gender,
  }) async {
    return await sendPostRequest(_signupUrl, <String, String>{
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'date_of_birth': dateOfBirth,
      'gender': gender,
      'email': email,
      'password': password,
      'password_confirmation': confirmPassword,
    });
  }

  static Future<Response> requestCode({
    required String email,
  }) async {
    return await sendPostRequest(
        _requestOtpUrl, <String, String>{'email': email});
  }

  static Future<Response> verifyOtp({
    required String email,
    required String otp,
  }) async {
    return await sendPostRequest(_verifyOtp, <String, String>{
      'email': email,
      'otp': otp,
    });
  }

  static Future<ProfileModel> getProfileData() async {
    Response response = await sendGetRequest(_profileUrl);
    return ProfileModel.fromJson(json.decode(response.body));
  }

  static Future<HomeModel> getHome() async {
    Response response = await sendGetRequest(_exploreUrl);
    return HomeModel.fromJson(json.decode(response.body));
  }

  static Future<FavListModel> getFavList() async {
    Response response = await sendGetRequest('$_favUrl/get-events');
    return FavListModel.fromJson(json.decode(response.body));
  }

  static Future removeFromFav({required String id}) async {
    Response response = await sendDeleteRequest('$_favUrl/remove-event/$id');
    return json.decode(response.body);
  }

  static Future addToFav({
    required String eventId,
  }) async {
    Response response =
        await sendPostRequest('$_favUrl/add-event', <String, String>{
      "event_id": eventId,
    });
    return json.decode(response.body);
  }

  static Future<EventModel> getEvent({required String id}) async {
    Response response = await sendGetRequest('$_eventDetails/$id');
    return EventModel.fromJson(json.decode(response.body));
  }

  static Future<EventTicketsModel> getEventTickets({
    required String eventId,
    required String date,
  }) async {
    Response response =
        await sendPostRequest('$_eventDetails/tickets', <String, String>{
      "event_id": eventId,
      "date": date,
    });
    return EventTicketsModel.fromJson(json.decode(response.body));
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
