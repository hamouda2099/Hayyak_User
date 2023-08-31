// To parse this JSON data, do
//
//     final eventTicketsModel = eventTicketsModelFromJson(jsonString);

import 'dart:convert';

EventTicketsModel eventTicketsModelFromJson(String str) =>
    EventTicketsModel.fromJson(json.decode(str));

String eventTicketsModelToJson(EventTicketsModel data) =>
    json.encode(data.toJson());

class EventTicketsModel {
  EventTicketsModel({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  bool? success;
  String? message;
  Data? data;
  num? code;

  factory EventTicketsModel.fromJson(Map<String, dynamic> json) =>
      EventTicketsModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
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
  List<Kind?>? kinds;
  List<Kind?>? services;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        details:
            json["details"] == null ? null : Details.fromJson(json["details"]),
        kinds: json["kinds"] == null
            ? null
            : List<Kind>.from(json["kinds"].map((x) => Kind.fromJson(x))),
        services: json["services"] == null
            ? null
            : List<Kind>.from(json["services"].map((x) => Kind.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "details": details!.toJson(),
        "kinds": List<dynamic>.from(kinds!.map((x) => x?.toJson())),
        "services": List<dynamic>.from(services!.map((x) => x?.toJson())),
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
        action: json["action"] == null ? null : Action.fromJson(json["action"]),
        seats: json["seats"],
        vat: json["vat"],
        vatDisplayed: json["vat_displayed"],
        eventFees: json["event_fees"] ?? 0,
        eventFeesDisplayed: json["event_fees_displayed"] ?? '',
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
        "action": action?.toJson(),
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
    this.limit,
    this.tickets,
    this.description,
    this.type,
  });

  num? id;
  String? name;
  String? costBeforeDiscount;
  String? costAfterDiscount;
  num? discountValue;
  num? finalCost;
  num? countLimit;
  String? limit;
  String? color;
  Tickets? tickets;
  String? description;
  String? type;

  factory Kind.fromJson(Map<String, dynamic> json) => Kind(
        id: json["id"],
        name: json["name"],
        costBeforeDiscount: json["cost_before_discount"],
        costAfterDiscount: json["cost_after_discount"],
        discountValue: json["discount_value"],
        finalCost: json["final_cost"],
        countLimit: json["count_limit"],
        color: json["color"],
        limit: json["limit"],
        tickets:
            json["tickets"] == null ? null : Tickets.fromJson(json["tickets"]),
        description: json["description"],
        type: json["type"],
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "name": name,
        "cost_before_discount": costBeforeDiscount,
        "cost_after_discount": costAfterDiscount,
        "discount_value": discountValue,
        "final_cost": finalCost,
        "count_limit": countLimit,
        "limit": limit,
        "color": color,
        "tickets": tickets?.toJson(),
        "description": description,
        "type": type,
      };
}

class Tickets {
  Tickets({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  num? currentPage;
  List<dynamic>? data;
  String? firstPageUrl;
  dynamic from;
  num? lastPage;
  String? lastPageUrl;
  List<Link?>? links;
  String? nextPageUrl;
  String? path;
  num? perPage;
  String? prevPageUrl;
  dynamic to;
  num? total;

  factory Tickets.fromJson(Map<String, dynamic> json) => Tickets(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? null
            : List<dynamic>.from(json["data"].map((x) => x)),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null
            ? null
            : List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x)),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null
            ? null
            : List<dynamic>.from(links!.map((x) => x?.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  String? url;
  String? label;
  bool? active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
