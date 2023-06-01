// To parse this JSON data, do
//
//     final staticServices = staticServicesFromJson(jsonString);

import 'dart:convert';

StaticServices staticServicesFromJson(String str) =>
    StaticServices.fromJson(json.decode(str));

String staticServicesToJson(StaticServices data) => json.encode(data.toJson());

class StaticServices {
  bool? success;
  String? message;
  Data? data;
  int? code;

  StaticServices({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  factory StaticServices.fromJson(Map<String, dynamic> json) => StaticServices(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
        "code": code,
      };
}

class Data {
  Refund? sms;
  Refund? refund;
  Refund? whatsapp;

  Data({
    this.sms,
    this.refund,
    this.whatsapp,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        sms: json["sms"] == null ? null : Refund.fromJson(json["sms"]),
        refund: json["refund"] == null ? null : Refund.fromJson(json["refund"]),
        whatsapp:
            json["whatsapp"] == null ? null : Refund.fromJson(json["whatsapp"]),
      );

  Map<String, dynamic> toJson() => {
        "sms": sms?.toJson(),
        "refund": refund?.toJson(),
        "whatsapp": whatsapp?.toJson(),
      };
}

class Refund {
  String? name;
  String? descriptionAr;
  String? descriptionEn;
  int? value;
  String? valueDisplayed;

  Refund({
    this.name,
    this.descriptionAr,
    this.descriptionEn,
    this.value,
    this.valueDisplayed,
  });

  factory Refund.fromJson(Map<String, dynamic> json) => Refund(
        name: json["name"],
        descriptionAr: json["description_ar"],
        descriptionEn: json["description_en"],
        value: json["value"],
        valueDisplayed: json["value_displayed"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description_ar": descriptionAr,
        "description_en": descriptionEn,
        "value": value,
        "value_displayed": valueDisplayed,
      };
}
