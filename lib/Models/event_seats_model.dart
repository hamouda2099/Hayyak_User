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
    this.success,
    this.message,
    this.data,
    this.code,
  });

  bool? success;
  String? message;
  Data? data;
  num? code;

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
        "data": data!.toJson(),
        "code": code,
      };
}

class Data {
  Data({
    this.event,
  });

  Event? event;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        event: Event.fromJson(json["event"]),
      );

  Map<String, dynamic> toJson() => {
        "event": event!.toJson(),
      };
}

class Event {
  Event({
    this.details,
    this.kinds,
    this.services,
  });

  Details? details;
  List<Kind>? kinds;
  List<Service>? services;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        details:
            json["details"] == null ? null : Details.fromJson(json["details"]),
        kinds: List<Kind>.from(json["kinds"].map((x) => Kind.fromJson(x))),
        services: json["services"] == null
            ? []
            : List<Service>.from(
                json["services"].map((x) => Service.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "details": details!.toJson(),
        "kinds": List<dynamic>.from(kinds!.map((x) => x.toJson())),
        "services": List<dynamic>.from(services!.map((x) => x.toJson())),
      };
}

class Details {
  Details({
    this.id,
    this.name,
    this.description,
    this.image,
    this.startDate,
    this.endDate,
    this.time,
    this.latLng,
    this.address,
    this.averageCost,
    this.action,
    this.seats,
    this.vat,
    this.vatDisplayed,
    this.eventFees,
    this.eventFeesDisplayed,
  });

  num? id;
  String? name;
  String? description;
  String? image;
  String? startDate;
  String? endDate;
  String? time;
  String? latLng;
  String? address;
  String? averageCost;
  Action? action;
  String? seats;
  num? vat;
  String? vatDisplayed;
  num? eventFees;
  String? eventFeesDisplayed;

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
        "action": action!.toJson(),
        "seats": seats,
        "vat": vat,
        "vat_displayed": vatDisplayed,
        "event_fees": eventFees,
        "event_fees_displayed": eventFeesDisplayed
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
        color: json["color"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "color": color,
      };
}

class Kind {
  Kind({
    this.id,
    this.name,
    this.costBeforeDiscount,
    this.costAfterDiscount,
    this.discountValue,
    this.finalCost,
    this.countLimit,
    this.color,
    this.tickets,
  });

  num? id;
  String? name;
  String? costBeforeDiscount;
  String? costAfterDiscount;
  num? discountValue;
  num? finalCost;
  num? countLimit;
  String? color;
  dynamic tickets;

  factory Kind.fromJson(Map<String, dynamic> json) => Kind(
        id: json["id"],
        name: json["name"],
        costBeforeDiscount: json["cost_before_discount"],
        costAfterDiscount: json["cost_after_discount"],
        discountValue: json["discount_value"],
        finalCost: json["final_cost"].toDouble(),
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
    this.a,
    this.b,
    this.aa,
    this.bb,
    this.cc,
  });

  List<A>? a;
  List<A>? b;
  List<A>? aa;
  List<A>? bb;
  List<A>? cc;

  factory Tickets.fromJson(Map<String, dynamic> json) => Tickets(
        a: List<A>.from(json["A"] ?? [].map((x) => A.fromJson(x))),
        b: List<A>.from(json["B"] ?? [].map((x) => A.fromJson(x))),
        aa: List<A>.from(json["AA"] ?? [].map((x) => A.fromJson(x))),
        bb: List<A>.from(json["BB"] ?? [].map((x) => A.fromJson(x))),
        cc: List<A>.from(json["CC"] ?? [].map((x) => A.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "A": List<dynamic>.from(a!.map((x) => x.toJson())),
        "B": List<dynamic>.from(b!.map((x) => x.toJson())),
        "AA": List<dynamic>.from(aa!.map((x) => x.toJson())),
        "BB": List<dynamic>.from(bb!.map((x) => x.toJson())),
        "CC": List<dynamic>.from(cc!.map((x) => x.toJson())),
      };
}

class A {
  A({
    this.id,
    this.number,
  });

  num? id;
  num? number;

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
    this.id,
    this.name,
    this.description,
    this.type,
    this.countLimit,
    this.costBeforeDiscount,
    this.costAfterDiscount,
    this.discountValue,
    this.finalCost,
  });

  num? id;
  String? name;
  String? description;
  String? type;
  num? countLimit;
  String? costBeforeDiscount;
  String? costAfterDiscount;
  num? discountValue;
  num? finalCost;

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
