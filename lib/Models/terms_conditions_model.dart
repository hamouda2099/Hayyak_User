// To parse this JSON data, do
//
//     final termsAndConditionsModel = termsAndConditionsModelFromJson(jsonString);

import 'dart:convert';

TermsAndConditionsModel termsAndConditionsModelFromJson(String str) =>
    TermsAndConditionsModel.fromJson(json.decode(str));

String termsAndConditionsModelToJson(TermsAndConditionsModel data) =>
    json.encode(data.toJson());

class TermsAndConditionsModel {
  TermsAndConditionsModel({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  bool? success;
  String? message;
  Data? data;
  num? code;

  factory TermsAndConditionsModel.fromJson(Map<String, dynamic> json) =>
      TermsAndConditionsModel(
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
  Data({
    this.id,
    this.aboutName,
    this.aboutDescription,
  });

  num? id;
  String? aboutName;
  String? aboutDescription;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        aboutName: json["aboutName"],
        aboutDescription: json["aboutDescription"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "aboutName": aboutName,
        "aboutDescription": aboutDescription,
      };
}
