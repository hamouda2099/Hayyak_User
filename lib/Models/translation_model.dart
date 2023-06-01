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
  String? allEvents;
  String? tickets;

  Data({
    this.allEvents,
    this.tickets,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        allEvents: json["all_events"],
        tickets: json["tickets"],
      );

  Map<String, dynamic> toJson() => {
        "all_events": allEvents,
        "tickets": tickets,
      };
}
