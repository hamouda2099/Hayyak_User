// To parse this JSON data, do
//
//     final eventModel = eventModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

EventModel eventModelFromJson(String str) =>
    EventModel.fromJson(json.decode(str));

String eventModelToJson(EventModel data) => json.encode(data.toJson());

class EventModel {
  EventModel({
    required this.success,
    required this.message,
    required this.data,
    required this.code,
  });

  bool success;
  String message;
  Data data;
  int code;

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
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
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.startDate,
    required this.endDate,
    required this.pickerStartDate,
    required this.prickerEndDate,
    required this.time,
    required this.latLng,
    required this.address,
    required this.averageCost,
    required this.action,
    required this.seats,
  });

  int id;
  String name;
  String description;
  String image;
  String startDate;
  String endDate;
  DateTime pickerStartDate;
  DateTime prickerEndDate;
  String time;
  String latLng;
  String address;
  String averageCost;
  Action action;
  String seats;

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
        address: json["address"],
        averageCost: json["average_cost"],
        action: Action.fromJson(json["action"]),
        seats: json["seats"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
        "start_date": startDate,
        "end_date": endDate,
        "picker_start_date":
            "${pickerStartDate.year.toString().padLeft(4, '0')}-${pickerStartDate.month.toString().padLeft(2, '0')}-${pickerStartDate.day.toString().padLeft(2, '0')}",
        "pricker_end_date":
            "${prickerEndDate.year.toString().padLeft(4, '0')}-${prickerEndDate.month.toString().padLeft(2, '0')}-${prickerEndDate.day.toString().padLeft(2, '0')}",
        "time": time,
        "lat_lng": latLng,
        "address": address,
        "average_cost": averageCost,
        "action": action.toJson(),
        "seats": seats,
      };
}

class Action {
  Action({
    required this.name,
    required this.color,
  });

  String name;
  String color;

  factory Action.fromJson(Map<String, dynamic> json) => Action(
        name: json["name"],
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "color": color,
      };
}
