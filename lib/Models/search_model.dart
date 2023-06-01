// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

SearchModel searchModelFromJson(String str) =>
    SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
  SearchModel({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  bool? success;
  String? message;
  List<Datum>? data;
  int? code;

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
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
    required this.id,
    this.name,
    this.description,
    this.location,
    this.image,
    this.start,
    this.end,
    this.price,
    this.latLng,
  });

  num id;
  String? name;
  String? description;
  String? location;
  String? image;
  String? start;
  String? end;
  String? price;
  String? latLng;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        location: json["location"],
        image: json["image"],
        start: json["start"],
        end: json["end"],
        price: json["price"],
        latLng: json["lat_lng"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "location": location,
        "image": image,
        "start": start,
        "end": end,
        "price": price,
        "lat_lng": latLng,
      };
}
