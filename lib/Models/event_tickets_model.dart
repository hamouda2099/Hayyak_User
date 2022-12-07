// To parse this JSON data, do
//
//     final eventTicketsModel = eventTicketsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

EventTicketsModel eventTicketsModelFromJson(String str) => EventTicketsModel.fromJson(json.decode(str));

String eventTicketsModelToJson(EventTicketsModel data) => json.encode(data.toJson());

class EventTicketsModel {
  EventTicketsModel({
    required this.success,
    required this.message,
    required this.data,
    required this.code,
  });

  bool success;
  String message;
  Data data;
  int code;

  factory EventTicketsModel.fromJson(Map<String, dynamic> json) => EventTicketsModel(
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
    required this.event,
  });

  Event event;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    event: Event.fromJson(json["event"]),
  );

  Map<String, dynamic> toJson() => {
    "event": event.toJson(),
  };
}

class Event {
  Event({
    required this.details,
    required this.tickets,
  });

  Details details;
  List<Ticket> tickets;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
    details: Details.fromJson(json["details"]),
    tickets: List<Ticket>.from(json["tickets"].map((x) => Ticket.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "details": details.toJson(),
    "tickets": List<dynamic>.from(tickets.map((x) => x.toJson())),
  };
}

class Details {
  Details({
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

  factory Details.fromJson(Map<String, dynamic> json) => Details(
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
    "picker_start_date": "${pickerStartDate.year.toString().padLeft(4, '0')}-${pickerStartDate.month.toString().padLeft(2, '0')}-${pickerStartDate.day.toString().padLeft(2, '0')}",
    "pricker_end_date": "${prickerEndDate.year.toString().padLeft(4, '0')}-${prickerEndDate.month.toString().padLeft(2, '0')}-${prickerEndDate.day.toString().padLeft(2, '0')}",
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

class Ticket {
  Ticket({
    required this.id,
    required this.name,
    required this.cost,
    required this.max,
    required this.color,
  });

  int id;
  String name;
  String cost;
  int max;
  String color;

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
    id: json["id"],
    name: json["name"],
    cost: json["cost"],
    max: json["max"],
    color: json["color"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "cost": cost,
    "max": max,
    "color": color,
  };
}
