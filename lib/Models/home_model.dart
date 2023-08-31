// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  HomeModel({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  bool? success;
  String? message;
  Data? data;
  num? code;

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
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

class ActionHome {
  String? name;
  String? color;

  ActionHome({
    this.name,
    this.color,
  });

  factory ActionHome.fromJson(Map<String, dynamic> json) => ActionHome(
        name: json["name"],
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "color": color,
      };
}

class Data {
  Data({
    this.slider,
    this.categories,
  });

  List<ExploreSlider>? slider;
  List<Category>? categories;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        slider: json["slider"] == null
            ? []
            : List<ExploreSlider>.from(
                json["slider"].map((x) => ExploreSlider.fromJson(x))),
        categories: json["categories"] == null
            ? []
            : List<Category>.from(
                json["categories"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "slider": slider == null
            ? []
            : List<dynamic>.from(slider!.map((x) => x.toJson())),
        "categories": categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
      };
}

class Category {
  Category({
    this.id,
    this.name,
    this.events,
  });

  num? id;
  String? name;
  List<ExploreSlider>? events;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        events: json["events"] == null
            ? []
            : List<ExploreSlider>.from(
                json["events"].map((x) => ExploreSlider.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "events": events == null
            ? []
            : List<dynamic>.from(events!.map((x) => x.toJson())),
      };
}

class ExploreSlider {
  ExploreSlider(
      {this.id,
      this.name,
      this.description,
      this.location,
      this.image,
      this.start,
      this.end,
      this.price,
      this.latLng,
      this.is_favourite,
      this.action});

  num? id;
  String? name;
  String? description;
  String? location;
  String? image;
  String? start;
  String? end;
  String? price;
  String? latLng;
  bool? is_favourite;
  ActionHome? action;

  factory ExploreSlider.fromJson(Map<String, dynamic> json) => ExploreSlider(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        location: json["location"] ?? "",
        image: json["image"],
        start: json["start"],
        end: json["end"],
        price: json["price"],
        latLng: json["lat_lng"],
        is_favourite: json["is_favourite"],
        action:
            json["action"] == null ? null : ActionHome.fromJson(json["action"]),
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
        "is_favourite": is_favourite,
        "action": action?.toJson(),
      };
}
