// To parse this JSON data, do
//
//     final favListModel = favListModelFromJson(jsonString);

import 'dart:convert';

FavListModel favListModelFromJson(String str) =>
    FavListModel.fromJson(json.decode(str));

String favListModelToJson(FavListModel data) => json.encode(data.toJson());

class FavListModel {
  FavListModel({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  bool? success;
  String? message;
  List<Datum>? data;
  num? code;

  factory FavListModel.fromJson(Map<String, dynamic> json) => FavListModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "code": code,
      };
}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.address,
  });

  int id;
  String name;
  String description;
  String image;
  String address;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
        "address": address,
      };
}
