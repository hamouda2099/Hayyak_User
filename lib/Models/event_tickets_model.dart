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
    required this.kinds,
  });

  Details details;
  List<Kind> kinds;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
    details: Details.fromJson(json["details"]),
    kinds: List<Kind>.from(json["kinds"].map((x) => Kind.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "details": details.toJson(),
    "kinds": List<dynamic>.from(kinds.map((x) => x.toJson())),
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

class Kind {
  Kind({
    required this.id,
    required this.name,
    required this.costBeforeDiscount,
    required this.max,
    required this.color,
    required this.tickets,
  });

  int id;
  String name;
  int costBeforeDiscount;
  int max;
  String color;
  Tickets tickets;

  factory Kind.fromJson(Map<String, dynamic> json) => Kind(
    id: json["id"],
    name: json["name"],
    costBeforeDiscount: json["cost_before_discount"],
    max: json["max"],
    color: json["color"],
    tickets: Tickets.fromJson(json["tickets"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "cost_before_discount": costBeforeDiscount,
    "max": max,
    "color": color,
    "tickets": tickets.toJson(),
  };
}

class Tickets {
  Tickets({
    required this.empty,
  });

  List<Empty> empty;

  factory Tickets.fromJson(Map<String, dynamic> json) => Tickets(
    empty: List<Empty>.from(json[""].map((x) => Empty.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "": List<dynamic>.from(empty.map((x) => x.toJson())),
  };
}

class Empty {
  Empty({
    required this.id,
    required this.numId,
    required this.row,
    required this.number,
    required this.type,
    required this.holdAt,
    required this.date,
    required this.kindId,
    required this.eventId,
    required this.reservedAt,
    required this.checkin,
    required this.checkout,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String numId;
  String row;
  int number;
  String type;
  dynamic holdAt;
  DateTime date;
  int kindId;
  int eventId;
  dynamic reservedAt;
  dynamic checkin;
  dynamic checkout;
  dynamic deletedAt;
  String createdAt;
  String updatedAt;

  factory Empty.fromJson(Map<String, dynamic> json) => Empty(
    id: json["id"],
    numId: json["num_id"],
    row: json["row"],
    number: json["number"],
    type: json["type"],
    holdAt: json["hold_at"],
    date: DateTime.parse(json["date"]),
    kindId: json["kind_id"],
    eventId: json["event_id"],
    reservedAt: json["reserved_at"],
    checkin: json["checkin"],
    checkout: json["checkout"],
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "num_id": numId,
    "row": row,
    "number": number,
    "type": type,
    "hold_at": holdAt,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "kind_id": kindId,
    "event_id": eventId,
    "reserved_at": reservedAt,
    "checkin": checkin,
    "checkout": checkout,
    "deleted_at": deletedAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
