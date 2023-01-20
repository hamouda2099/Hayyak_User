// To parse this JSON data, do
//
//     final favListModel = favListModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

FavListModel favListModelFromJson(String str) => FavListModel.fromJson(json.decode(str));

String favListModelToJson(FavListModel data) => json.encode(data.toJson());

class FavListModel {
  FavListModel({
    required this.success,
    required this.message,
    required this.data,
    required this.code,
  });

  bool success;
  String message;
  List<Datum> data;
  int code;

  factory FavListModel.fromJson(Map<String, dynamic> json) => FavListModel(
    success: json["success"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
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
