// To parse this JSON data, do
//
//     final eventTicketsModel = eventTicketsModelFromJson(jsonString);

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
    required this.services,
  });

  Details details;
  List<Kind> kinds;
  List<Kind> services;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
    details: Details.fromJson(json["details"]),
    kinds: List<Kind>.from(json["kinds"].map((x) => Kind.fromJson(x))),
    services: List<Kind>.from(json["services"].map((x) => Kind.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "details": details.toJson(),
    "kinds": List<dynamic>.from(kinds.map((x) => x.toJson())),
    "services": List<dynamic>.from(services.map((x) => x.toJson())),
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
    name: json["name"]??'',
    color: json["color"]??'',
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
    this.discountValue,
    required this.finalCost,
    required this.countLimit,
    this.color,
    this.tickets,
    this.description,
    this.type,
  });

  int id;
  String name;
  String costBeforeDiscount;
  String costAfterDiscount;
  dynamic discountValue;
  int finalCost;
  int countLimit;
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
    tickets: json["tickets"] == null ? null : Tickets.fromJson(json["tickets"]),
    description: json["description"],
    type: json["type"],
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
    "tickets": tickets?.toJson(),
    "description": description,
    "type": type,
  };
}

class Tickets {
  Tickets({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    this.nextPageUrl,
    required this.path,
    required this.perPage,
    this.prevPageUrl,
    this.to,
    required this.total,
  });

  int currentPage;
  List<dynamic> data;
  String firstPageUrl;
  dynamic from;
  int lastPage;
  String lastPageUrl;
  List<Link> links;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  dynamic to;
  int total;

  factory Tickets.fromJson(Map<String, dynamic> json) => Tickets(
    currentPage: json["current_page"],
    data: List<dynamic>.from(json["data"].map((x) => x)),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data.map((x) => x)),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
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
    required this.label,
    required this.active,
  });

  String? url;
  String label;
  bool active;

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
