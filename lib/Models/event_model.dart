// To parse this JSON data, do
//
//     final eventModel = eventModelFromJson(jsonString);

import 'dart:convert';

EventModel eventModelFromJson(String str) =>
    EventModel.fromJson(json.decode(str));

String eventModelToJson(EventModel data) => json.encode(data.toJson());

class EventModel {
  EventModel({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  bool? success;
  String? message;
  Data? data;
  num? code;

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data!.toJson(),
        "code": code,
      };
}

class Data {
  Data({
    this.id,
    this.name,
    this.description,
    this.image,
    this.startDate,
    this.endDate,
    this.pickerStartDate,
    this.prickerEndDate,
    this.time,
    this.latLng,
    this.address,
    this.averageCost,
    this.action,
    this.seats,
    this.avgCost,
    this.typeYouTubeImage,
    this.urlYouTubeImage,
  });

  num? id;
  String? name;
  String? description;
  String? image;
  String? startDate;
  String? endDate;
  DateTime? pickerStartDate;
  DateTime? prickerEndDate;
  String? time;
  String? latLng;
  String? address;
  String? averageCost;
  num? avgCost;
  Action? action;
  String? seats;
  String? typeYouTubeImage;
  String? urlYouTubeImage;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        pickerStartDate: DateTime.parse(json["picker_start_date"]),
        prickerEndDate: DateTime.parse(json["pricker_end_date"]),
        time: json["time"],
        latLng: json["lat_lng"],
        address: json["address"] ?? '',
        averageCost: json["average_cost"],
        avgCost: json["avg_cost"],
        action: Action.fromJson(json["action"]),
        seats: json["seats"],
        typeYouTubeImage: json["type_youtube_image"],
        urlYouTubeImage: json["url_youtube_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
        "start_date": startDate,
        "end_date": endDate,
        "picker_start_date":
            "${pickerStartDate?.year.toString().padLeft(4, '0')}-${pickerStartDate?.month.toString().padLeft(2, '0')}-${pickerStartDate?.day.toString().padLeft(2, '0')}",
        "pricker_end_date":
            "${prickerEndDate?.year.toString().padLeft(4, '0')}-${prickerEndDate?.month.toString().padLeft(2, '0')}-${prickerEndDate?.day.toString().padLeft(2, '0')}",
        "time": time,
        "lat_lng": latLng,
        "address": address,
        "average_cost": averageCost,
        "avg_cost": avgCost,
        "action": action!.toJson(),
        "seats": seats,
        "type_youtube_image": typeYouTubeImage,
        "url_youtube_image": urlYouTubeImage,
      };
}

class Action {
  Action({
    this.name,
    this.color,
  });

  String? name;
  String? color;

  factory Action.fromJson(Map<String, dynamic> json) => Action(
        name: json["name"] ?? '',
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "color": color,
      };
}
