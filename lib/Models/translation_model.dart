// To parse this JSON data, do
//
//     final translationModel = translationModelFromJson(jsonString);

import 'dart:convert';

TranslationModel translationModelFromJson(String str) =>
    TranslationModel.fromJson(json.decode(str));

String translationModelToJson(TranslationModel data) =>
    json.encode(data.toJson());

class TranslationModel {
  bool? success;
  Data? data;
  int? code;

  TranslationModel({
    this.success,
    this.data,
    this.code,
  });

  factory TranslationModel.fromJson(Map<String, dynamic> json) =>
      TranslationModel(
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
        "code": code,
      };
}

class Data {
  String? signIn;
  String? contactUs;
  String? skip;
  String? welcomeBack;
  String? email;
  String? password;
  String? rememberMe;
  String? forgetPassword;
  String? orLoginWith;
  String? dontHaveAccount;
  String? createOne;
  String? firstName;
  String? lastName;
  String? phone;
  String? birth;
  String? gender;
  String? confirmPassword;
  String? acceptAllTermsAndConditions;
  String? alreadyMember;
  String? explore;
  String? tickets;
  String? favourites;
  String? search;
  String? settings;
  String? account;
  String? faqs;
  String? privacyPolicy;
  String? termsAndConditions;
  String? logOut;
  String? personalInfo;
  String? save;
  String? pleaseWait;
  String? recently;
  String? searchForEvents;
  String? upcoming;
  String? past;
  String? address;
  String? addToCalender;
  String? location;
  String? viewMap;
  String? selectDay;
  String? confirm;
  String? seats;
  String? price;
  String? chooseYourSeat;
  String? seat;
  String? services;
  String? checkout;
  String? selectSeat;
  String? additionalServices;
  String? refundGuarantee;
  String? summery;
  String? apply;
  String? totalExclVat;
  String? vat;
  String? fees;
  String? total;
  String? inclVat;
  String? pay;
  String? totalPrice;
  String? sar;
  String? enterPromoCode;
  String? doorsOpen;

  Data({
    this.signIn,
    this.contactUs,
    this.skip,
    this.welcomeBack,
    this.email,
    this.password,
    this.rememberMe,
    this.forgetPassword,
    this.orLoginWith,
    this.dontHaveAccount,
    this.createOne,
    this.firstName,
    this.lastName,
    this.phone,
    this.birth,
    this.gender,
    this.confirmPassword,
    this.acceptAllTermsAndConditions,
    this.alreadyMember,
    this.explore,
    this.tickets,
    this.favourites,
    this.search,
    this.settings,
    this.account,
    this.faqs,
    this.privacyPolicy,
    this.termsAndConditions,
    this.logOut,
    this.personalInfo,
    this.save,
    this.pleaseWait,
    this.recently,
    this.searchForEvents,
    this.upcoming,
    this.past,
    this.address,
    this.addToCalender,
    this.location,
    this.viewMap,
    this.selectDay,
    this.confirm,
    this.seats,
    this.price,
    this.chooseYourSeat,
    this.seat,
    this.services,
    this.checkout,
    this.selectSeat,
    this.additionalServices,
    this.refundGuarantee,
    this.summery,
    this.apply,
    this.totalExclVat,
    this.vat,
    this.fees,
    this.total,
    this.inclVat,
    this.pay,
    this.totalPrice,
    this.sar,
    this.enterPromoCode,
    this.doorsOpen,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        signIn: json["signIn"],
        contactUs: json["contactUs"],
        skip: json["skip"],
        welcomeBack: json["welcome_back"],
        email: json["email"],
        password: json["password"],
        rememberMe: json["remember_me"],
        forgetPassword: json["forget_password"],
        orLoginWith: json["or_login_with"],
        dontHaveAccount: json["dont_have_account"],
        createOne: json["create_one"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phone: json["phone"],
        birth: json["birth"],
        gender: json["gender"],
        confirmPassword: json["confirm_password"],
        acceptAllTermsAndConditions: json["accept_all_terms_and_conditions"],
        alreadyMember: json["already_member"],
        explore: json["explore"],
        tickets: json["tickets"],
        favourites: json["favourites"],
        search: json["search"],
        settings: json["settings"],
        account: json["account"],
        faqs: json["faqs"],
        privacyPolicy: json["privacy_policy"],
        termsAndConditions: json["terms_and_conditions"],
        logOut: json["log_out"],
        personalInfo: json["personal_info"],
        save: json["save"],
        pleaseWait: json["please_wait"],
        recently: json["recently"],
        searchForEvents: json["search_for_events"],
        upcoming: json["upcoming"],
        past: json["past"],
        address: json["address"],
        addToCalender: json["add_to_calender"],
        location: json["location"],
        viewMap: json["view_map"],
        selectDay: json["select_day"],
        confirm: json["confirm"],
        seats: json["seats"],
        price: json["price"],
        chooseYourSeat: json["choose_your_seat"],
        seat: json["seat"],
        services: json["services"],
        checkout: json["checkout"],
        selectSeat: json["select_seat"],
        additionalServices: json["additional_services"],
        refundGuarantee: json["refund_guarantee"],
        summery: json["summery"],
        apply: json["apply"],
        totalExclVat: json["total_excl_vat"],
        vat: json["vat"],
        fees: json["fees"],
        total: json["total"],
        inclVat: json["incl.vat"],
        pay: json["pay"],
        totalPrice: json["total_price"],
        sar: json["sar"],
        enterPromoCode: json["enter_promo_code"],
        doorsOpen: json["doors_open"],
      );

  Map<String, dynamic> toJson() => {
        "signIn": signIn,
        "contactUs": contactUs,
        "skip": skip,
        "welcome_back": welcomeBack,
        "email": email,
        "password": password,
        "remember_me": rememberMe,
        "forget_password": forgetPassword,
        "or_login_with": orLoginWith,
        "dont_have_account": dontHaveAccount,
        "create_one": createOne,
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "birth": birth,
        "gender": gender,
        "confirm_password": confirmPassword,
        "accept_all_terms_and_conditions": acceptAllTermsAndConditions,
        "already_member": alreadyMember,
        "explore": explore,
        "tickets": tickets,
        "favourites": favourites,
        "search": search,
        "settings": settings,
        "account": account,
        "faqs": faqs,
        "privacy_policy": privacyPolicy,
        "terms_and_conditions": termsAndConditions,
        "log_out": logOut,
        "personal_info": personalInfo,
        "save": save,
        "please_wait": pleaseWait,
        "recently": recently,
        "search_for_events": searchForEvents,
        "upcoming": upcoming,
        "past": past,
        "address": address,
        "add_to_calender": addToCalender,
        "location": location,
        "view_map": viewMap,
        "select_day": selectDay,
        "confirm": confirm,
        "seats": seats,
        "price": price,
        "choose_your_seat": chooseYourSeat,
        "seat": seat,
        "services": services,
        "checkout": checkout,
        "select_seat": selectSeat,
        "additional_services": additionalServices,
        "refund_guarantee": refundGuarantee,
        "summery": summery,
        "apply": apply,
        "total_excl_vat": totalExclVat,
        "vat": vat,
        "fees": fees,
        "total": total,
        "incl.vat": inclVat,
        "pay": pay,
        "total_price": totalPrice,
        "sar": sar,
        "enter_promo_code": enterPromoCode,
        "doors_open": doorsOpen,
      };
}
