import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/user_data.dart';
import 'package:hayyak/Models/event_model.dart';
import 'package:hayyak/Models/event_tickets_model.dart';
import 'package:hayyak/Models/faqs_model.dart';
import 'package:hayyak/Models/fav_list_model.dart';
import 'package:hayyak/Models/home_model.dart';
import 'package:hayyak/Models/profile_model.dart';
import 'package:hayyak/Models/search_model.dart';
import 'package:hayyak/Models/static_services_model.dart';
import 'package:hayyak/Models/terms_conditions_model.dart';
import 'package:hayyak/Models/translation_model.dart';
import 'package:hayyak/Models/user_orders_model.dart';
import 'package:hayyak/States/providers.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../Models/aviable_for_sale_model.dart';
import '../../Models/event_seats_model.dart';
import '../../Models/privacy_policy_model.dart';
import '../../Models/settings_model.dart';
import '../../Models/user_order_tickets_model.dart';

class ApiManger {
  static const String hostUrl = 'https://hayyak.net/api';
  static const String _loginUrl = '$hostUrl/auth/login';
  static const String _signupUrl = '$hostUrl/auth/signup';
  static const String _requestOtpUrl = '$hostUrl/auth/request-otp';
  static const String _verifyOtp = '$hostUrl/auth/verify-otp';
  static const String _exploreUrl = '$hostUrl/events/explore';
  static const String _eventDetails = '$hostUrl/event';
  static const String _userOrdersUrl = '$hostUrl/orders/get-user-orders';
  static const String _userOrderTicketsUrl =
      '$hostUrl/orders/get-order-tickets';
  static const String _favUrl = '$hostUrl/favorites';
  static const String _createOrderUrl = '$hostUrl/orders/create-order';
  static const String _payOrderUrl = '$hostUrl/orders/pay-order';
  static const String _availableTicketsForSale = '$hostUrl/event/avail-for-sal';
  static const String _faqsUrl = '$hostUrl/faq';
  static const String _getSettings = '$hostUrl/get-settings';
  static const String _getStaticServices = '$hostUrl/event/get-static-services';
  static const String _translationUrl = '$hostUrl/translation';
  static const String _policyUrl = '$hostUrl/policy';
  static const String _contactUsUrl = '$hostUrl/contact-us';
  static const String _applyCouponUrl = '$hostUrl/apply-coupon';
  static const String _conditionsUrl = '$hostUrl/conditions';
  static const String _profileUrl = '$hostUrl/user/profile';
  static const String _searchUrl = '$hostUrl/event/search/';

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
        'lang': localLanguage,
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
    required String signType,
  }) async {
    return await sendPostRequest(_loginUrl, <String, String>{
      'email': email,
      'password': password,
      "sign_type": signType
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

  static Future<Response> applyCoupon({
    required num total,
    required String coupon,
  }) async {
    return await sendPostRequest(_applyCouponUrl, <String, dynamic>{
      'total': total,
      'coupon': coupon,
    });
  }

  static Future<ProfileModel> getProfileData() async {
    Response response = await sendGetRequest(_profileUrl);
    return ProfileModel.fromJson(json.decode(response.body));
  }

  static Future<SearchModel> search({required String query}) async {
    Response response = await sendGetRequest('$_searchUrl$query');
    return SearchModel.fromJson(json.decode(response.body));
  }

  static Future<FaQsModel> getFAQs() async {
    Response response = await sendGetRequest(_faqsUrl);
    return FaQsModel.fromJson(json.decode(response.body));
  }

  static Future<PrivacyPolicyModel> getPrivacyPolicy() async {
    Response response = await sendGetRequest(_policyUrl);
    return PrivacyPolicyModel.fromJson(json.decode(response.body));
  }

  static Future<TermsAndConditionsModel> getTermsAndConditions() async {
    Response response = await sendGetRequest(_conditionsUrl);
    return TermsAndConditionsModel.fromJson(json.decode(response.body));
  }

  static Future<Response> contactUs({
    required String email,
    required String phone,
    required String name,
    required String subject,
    required String details,
  }) async {
    return await sendPostRequest(_contactUsUrl, <String, String>{
      'email': email,
      'phone': phone,
      'name': name,
      'subject': subject,
      'details': details,
    });
  }

  static Future<HomeModel> getHome() async {
    Response response = await sendGetRequest(_exploreUrl);
    return HomeModel.fromJson(json.decode(response.body));
  }

  static Future<TranslationModel> getTranslationsKeys() async {
    Response response = await sendGetRequest(_translationUrl);
    return TranslationModel.fromJson(json.decode(response.body));
  }

  static Future<SettingsModel> getSettings() async {
    Response response = await sendGetRequest(_getSettings);
    return SettingsModel.fromJson(json.decode(response.body));
  }

  static Future<StaticServices> getStaticServices({String? eventId}) async {
    Response response = await sendGetRequest('$_getStaticServices/$eventId');
    return StaticServices.fromJson(json.decode(response.body));
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

  static Future createOrder({
    required String eventId,
    required String tickets,
    required String services,
    required String sms,
    required String refund,
    required String whatsapp,
    required String amount,
    required String date,
    required String userId,
    required String couponId,
    required String userRole,
    required String token,
  }) async {
    Response response = await sendPostRequest(_createOrderUrl, <String, String>{
      "event_id": eventId,
      "tickets": tickets,
      "services": services,
      "sms": sms,
      "refund": refund,
      "whatsapp": whatsapp,
      "allamount": amount,
      "date": date,
      "user_id": userId,
      "cobon_id": couponId,
      "user_role": userRole,
      "token": token
    });
    return json.decode(response.body);
  }

  static Future payOrder({
    String? orderId,
    String? payStatus,
    String? paymentId,
    String? tranId,
    String? eci,
    String? result,
    String? trackId,
    String? authCode,
    String? responseCode,
    String? rrn,
    String? responseHash,
    String? amount,
    String? cardBrand,
    String? userField1,
    String? userField2,
    String? userField3,
    String? userField4,
    String? userField5,
    String? maskedPAN,
    String? cardToken,
    String? subscriptionId,
    String? email,
    String? payFor,
    String? payId,
    String? terminalid,
    String? udf1,
    String? udf2,
    String? udf3,
    String? udf4,
    String? udf5,
    String? tranDate,
    String? tranType,
    String? integrationModule,
    String? integrationData,
    String? targetUrl,
    String? postData,
    String? intUrl,
    String? linkBasedUrl,
    String? sadadNumber,
    String? billNumber,
    String? responseMsg,
  }) async {
    Response response = await sendPostRequest(_payOrderUrl, <String, String?>{
      "order_id": orderId,
      "pay_status": payStatus,
      "PaymentId": paymentId,
      "TranId": tranId,
      "ECI": eci,
      "Result": result,
      "TrackId": trackId,
      "AuthCode": authCode,
      "ResponseCode": responseCode,
      "RRN": rrn,
      "responseHash": responseHash,
      "amount": amount,
      "cardBrand": cardBrand,
      "UserField1": userField1,
      "UserField2": userField2,
      "UserField3": userField3,
      "UserField4": userField4,
      "UserField5": userField5,
      "maskedPAN": maskedPAN,
      "cardToken": cardToken,
      "SubscriptionId": subscriptionId,
      "email": email,
      "payFor": payFor,
      "terminalid": terminalid,
      "udf1": udf1,
      "udf2": udf2,
      "udf3": udf3,
      "udf4": udf4,
      "udf5": udf5,
      "trandate": tranDate,
      "tranType": tranType,
      "integrationModule": integrationModule,
      "integrationData": integrationData,
      "payid": payId,
      "targetUrl": targetUrl,
      "postData": postData,
      "intUrl": intUrl,
      "linkBasedUrl": linkBasedUrl,
      "sadadNumber": sadadNumber,
      "billNumber": billNumber,
      "ResponseMsg": responseMsg,
    });
    return json.decode(response.body);
  }

  static Future<EventModel> getEvent({required String id}) async {
    Response response = await sendGetRequest('$_eventDetails/$id');
    return EventModel.fromJson(json.decode(response.body));
  }

  static Future<UserOrdersModel> getUserOrders() async {
    Response response = await sendPostRequest(
        _userOrdersUrl, <String, String>{"user_id": UserData.id.toString()});

    return UserOrdersModel.fromJson(json.decode(response.body));
  }

  static Future<UserOrderTicketsModel> getOrderTickets(
      {required String orderId}) async {
    Response response = await sendPostRequest(
        _userOrderTicketsUrl, <String, String>{"order_id": orderId});
    return UserOrderTicketsModel.fromJson(json.decode(response.body));
  }

  static Future<AvailableTicketsForSaleModel> getAvailableTicketsForSale({
    required String eventId,
    required String date,
    required String tickets,
    required String services,
  }) async {
    Response response =
        await sendPostRequest(_availableTicketsForSale, <String, String>{
      "event_id": eventId,
      "date": date.substring(0, 10),
      "tickets": tickets,
      "services": services
    });
    return AvailableTicketsForSaleModel.fromJson(json.decode(response.body));
  }

  static Future<EventTicketsModel> getEventTickets({
    required String eventId,
    required String date,
    int page = 1,
  }) async {
    Response response = await sendPostRequest(
        '$_eventDetails/tickets?page=$page', <String, String>{
      "event_id": eventId,
      "date": date,
    });
    return EventTicketsModel.fromJson(json.decode(response.body));
  }

  static Future<EventSeatsModel> getEventSeats({
    required String eventId,
    required String date,
  }) async {
    Response response =
        await sendPostRequest('$_eventDetails/tickets', <String, String>{
      "event_id": eventId,
      "date": date,
    });
    return EventSeatsModel.fromJson(json.decode(response.body));
  }

  static Future getTime(BuildContext context, WidgetRef ref) async {
    final response = await sendGetRequest(_timeDateUrl);
    ref.read(dateTimeProvider.notifier).state = jsonDecode(response.body);
    return jsonDecode(response.body);
  }
}
