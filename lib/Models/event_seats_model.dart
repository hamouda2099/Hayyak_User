// To parse this JSON data, do
//
//     final eventSeatsModel = eventSeatsModelFromJson(jsonString);

import 'dart:convert';

EventSeatsModel eventSeatsModelFromJson(String str) =>
    EventSeatsModel.fromJson(json.decode(str));

String eventSeatsModelToJson(EventSeatsModel data) =>
    json.encode(data.toJson());

class EventSeatsModel {
  EventSeatsModel({
    required this.success,
    required this.message,
    required this.data,
    required this.code,
  });

  bool success;
  String message;
  Data data;
  int code;

  factory EventSeatsModel.fromJson(Map<String, dynamic> json) =>
      EventSeatsModel(
        success: json["success"],
        message: json["message"] ?? '',
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
    required this.services,
  });

  Details details;
  List<Kind> kinds;
  List<Service>? services;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        details: Details.fromJson(json["details"]),
        kinds: List<Kind>.from(json["kinds"].map((x) => Kind.fromJson(x))),
        services: json["services"] == null
            ? []
            : List<Service>.from(
                json["services"].map((x) => Service.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "details": details.toJson(),
        "kinds": List<dynamic>.from(kinds.map((x) => x.toJson())),
        "services": List<dynamic>.from(services!.map((x) => x.toJson())),
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
    required this.vat,
    required this.vatDisplayed,
    required this.eventFees,
    required this.eventFeesDisplayed,
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
  int vat;
  String vatDisplayed;
  num eventFees;
  String eventFeesDisplayed;

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
        vat: json["vat"],
        vatDisplayed: json["vat_displayed"],
        eventFees: json["event_fees"],
        eventFeesDisplayed: json["event_fees_displayed"],
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
        "vat": vat,
        "vat_displayed": vatDisplayed,
        "event_fees": eventFees,
        "event_fees_displayed": eventFeesDisplayed
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
        name: json["name"] ?? '',
        color: json["color"] ?? '',
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
    required this.costAfterDiscount,
    required this.discountValue,
    required this.finalCost,
    required this.countLimit,
    required this.color,
    required this.tickets,
  });

  int id;
  String name;
  String costBeforeDiscount;
  String costAfterDiscount;
  dynamic discountValue;
  int finalCost;
  int countLimit;
  String color;
  dynamic tickets;

  factory Kind.fromJson(Map<String, dynamic> json) => Kind(
        id: json["id"],
        name: json["name"],
        costBeforeDiscount: json["cost_before_discount"],
        costAfterDiscount: json["cost_after_discount"],
        discountValue: json["discount_value"],
        finalCost: json["final_cost"],
        countLimit: json["count_limit"],
        color: json["color"],
        tickets: json["tickets"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "cost_before_discount": costBeforeDiscount,
        "cost_after_discount": costAfterDiscount,
        "discount_value": discountValue,
        "final_cost": finalCost,
        "count_limit": countLimit,
        "color": color,
        "tickets": tickets.toJson(),
      };
}

class Tickets {
  Tickets({
    required this.a,
    required this.b,
    required this.aa,
    required this.bb,
    required this.cc,
  });

  List<A> a;
  List<A> b;
  List<A> aa;
  List<A> bb;
  List<A> cc;

  factory Tickets.fromJson(Map<String, dynamic> json) => Tickets(
        a: List<A>.from(json["A"] ?? [].map((x) => A.fromJson(x))),
        b: List<A>.from(json["B"] ?? [].map((x) => A.fromJson(x))),
        aa: List<A>.from(json["AA"] ?? [].map((x) => A.fromJson(x))),
        bb: List<A>.from(json["BB"] ?? [].map((x) => A.fromJson(x))),
        cc: List<A>.from(json["CC"] ?? [].map((x) => A.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "A": List<dynamic>.from(a.map((x) => x.toJson())),
        "B": List<dynamic>.from(b.map((x) => x.toJson())),
        "AA": List<dynamic>.from(aa.map((x) => x.toJson())),
        "BB": List<dynamic>.from(bb.map((x) => x.toJson())),
        "CC": List<dynamic>.from(cc.map((x) => x.toJson())),
      };
}

class A {
  A({
    required this.id,
    required this.number,
  });

  int id;
  int number;

  factory A.fromJson(Map<String, dynamic> json) => A(
        id: json["id"],
        number: json["number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "number": number,
      };
}

class Service {
  Service({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.countLimit,
    required this.costBeforeDiscount,
    required this.costAfterDiscount,
    required this.discountValue,
    required this.finalCost,
  });

  int id;
  String? name;
  String? description;
  String? type;
  int? countLimit;
  String? costBeforeDiscount;
  String? costAfterDiscount;
  dynamic discountValue;
  int? finalCost;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        type: json["type"],
        countLimit: json["count_limit"],
        costBeforeDiscount: json["cost_before_discount"],
        costAfterDiscount: json["cost_after_discount"],
        discountValue: json["discount_value"],
        finalCost: json["final_cost"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "type": type,
        "count_limit": countLimit,
        "cost_before_discount": costBeforeDiscount,
        "cost_after_discount": costAfterDiscount,
        "discount_value": discountValue,
        "final_cost": finalCost,
      };
}
