// To parse this JSON data, do
//
//     final privacyPolicyModel = privacyPolicyModelFromJson(jsonString);

import 'dart:convert';

PrivacyPolicyModel privacyPolicyModelFromJson(String str) =>
    PrivacyPolicyModel.fromJson(json.decode(str));

String privacyPolicyModelToJson(PrivacyPolicyModel data) =>
    json.encode(data.toJson());

class PrivacyPolicyModel {
  PrivacyPolicyModel({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  bool? success;
  String? message;
  Data? data;
  int? code;

  factory PrivacyPolicyModel.fromJson(Map<String, dynamic> json) =>
      PrivacyPolicyModel(
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

  int? id;
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
