// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  HomeModel({
    required this.success,
    required this.message,
    required this.data,
    required this.code,
  });

  bool success;
  String message;
  Data data;
  int code;

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
        "code": code,
      };
}

class Data {
  Data({
    required this.slider,
    required this.categories,
  });

  List<SliderEvents> slider;
  List<Category> categories;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        slider: List<SliderEvents>.from(
            json["slider"].map((x) => SliderEvents.fromJson(x))),
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "slider": List<dynamic>.from(slider.map((x) => x.toJson())),
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
      };
}

class Category {
  Category({
    required this.id,
    required this.name,
    required this.events,
  });

  int id;
  String name;
  List<SliderEvents> events;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        events: List<SliderEvents>.from(
            json["events"].map((x) => SliderEvents.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "events": List<dynamic>.from(events.map((x) => x.toJson())),
      };
}

class SliderEvents {
  SliderEvents({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.start,
    required this.end,
    required this.price,
    required this.latLng,
  });

  int id;
  String name;
  String description;
  String image;
  String start;
  String end;
  String price;
  String latLng;

  factory SliderEvents.fromJson(Map<String, dynamic> json) => SliderEvents(
        id: json["id"],
        name: json["name"],
        description: json["description"],
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
        "image": image,
        "start": start,
        "end": end,
        "price": price,
        "lat_lng": latLng,
      };
}
