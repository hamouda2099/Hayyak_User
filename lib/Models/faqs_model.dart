// To parse this JSON data, do
//
//     final faQsModel = faQsModelFromJson(jsonString);

import 'dart:convert';

FaQsModel faQsModelFromJson(String str) => FaQsModel.fromJson(json.decode(str));

String faQsModelToJson(FaQsModel data) => json.encode(data.toJson());

class FaQsModel {
  FaQsModel({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  bool? success;
  String? message;
  List<Datum>? data;
  num? code;

  factory FaQsModel.fromJson(Map<String, dynamic> json) => FaQsModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "code": code,
      };
}

class Datum {
  Datum({
    this.id,
    this.qName,
    this.qAnswer,
  });

  num? id;
  String? qName;
  String? qAnswer;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        qName: json["qName"],
        qAnswer: json["qAnswer"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "qName": qName,
        "qAnswer": qAnswer,
      };
}
