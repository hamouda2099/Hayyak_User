// To parse this JSON data, do
//
//     final availableTicketsForSaleModel = availableTicketsForSaleModelFromJson(jsonString);

import 'dart:convert';

AvailableTicketsForSaleModel availableTicketsForSaleModelFromJson(String str) =>
    AvailableTicketsForSaleModel.fromJson(json.decode(str));

String availableTicketsForSaleModelToJson(AvailableTicketsForSaleModel data) =>
    json.encode(data.toJson());

class AvailableTicketsForSaleModel {
  bool? success;
  String? message;
  Data? data;
  num? code;

  AvailableTicketsForSaleModel({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  factory AvailableTicketsForSaleModel.fromJson(Map<String, dynamic> json) =>
      AvailableTicketsForSaleModel(
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

class Data {
  List<TicketsInvoice>? ticketsInvoice;
  List<ServicesInvoice>? servicesInvoice;

  Data({
    this.ticketsInvoice,
    this.servicesInvoice,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        ticketsInvoice: json["ticketsInvoice"] == null
            ? []
            : List<TicketsInvoice>.from(
                json["ticketsInvoice"]!.map((x) => TicketsInvoice.fromJson(x))),
        servicesInvoice: json["servicesInvoice"] == null
            ? []
            : List<ServicesInvoice>.from(json["servicesInvoice"]!
                .map((x) => ServicesInvoice.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ticketsInvoice": ticketsInvoice == null
            ? []
            : List<dynamic>.from(ticketsInvoice!.map((x) => x.toJson())),
        "servicesInvoice": servicesInvoice == null
            ? []
            : List<dynamic>.from(servicesInvoice!.map((x) => x.toJson())),
      };
}

class ServicesInvoice {
  num? id;
  String? count;
  String? serviceName;
  num? cost;
  String? currancy;

  ServicesInvoice({
    this.id,
    this.count,
    this.serviceName,
    this.cost,
    this.currancy,
  });

  factory ServicesInvoice.fromJson(Map<String, dynamic> json) =>
      ServicesInvoice(
        id: json["id"],
        count: json["count"],
        serviceName: json["service_name"],
        cost: json["cost"],
        currancy: json["currancy"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "count": count,
        "service_name": serviceName,
        "cost": cost,
        "currancy": currancy,
      };
}

class TicketsInvoice {
  num? count;
  num? kindId;
  String? name;
  String? currancy;
  num? finalCost;
  List<AvailableTicket>? availableTickets;
  List<dynamic>? unavailableTickets;

  TicketsInvoice({
    this.count,
    this.kindId,
    this.name,
    this.currancy,
    this.finalCost,
    this.availableTickets,
    this.unavailableTickets,
  });

  factory TicketsInvoice.fromJson(Map<String, dynamic> json) => TicketsInvoice(
        count: json["count"],
        kindId: json["kind_id"],
        name: json["name"],
        currancy: json["currancy"],
        finalCost: json["final_cost"],
        availableTickets: json["available_tickets"] == null
            ? []
            : List<AvailableTicket>.from(json["available_tickets"]!
                .map((x) => AvailableTicket.fromJson(x))),
        unavailableTickets: json["unavailable_tickets"] == null
            ? []
            : List<dynamic>.from(json["unavailable_tickets"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "kind_id": kindId,
        "name": name,
        "currancy": currancy,
        "final_cost": finalCost,
        "available_tickets": availableTickets == null
            ? []
            : List<dynamic>.from(availableTickets!.map((x) => x.toJson())),
        "unavailable_tickets": unavailableTickets == null
            ? []
            : List<dynamic>.from(unavailableTickets!.map((x) => x)),
      };
}

class AvailableTicket {
  num? id;
  String? numId;
  String? row;
  num? number;
  String? type;
  String? holdAt;
  DateTime? date;
  num? kindId;
  num? eventId;
  String? reservedAt;
  String? checkin;
  String? checkout;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  AvailableTicket({
    this.id,
    this.numId,
    this.row,
    this.number,
    this.type,
    this.holdAt,
    this.date,
    this.kindId,
    this.eventId,
    this.reservedAt,
    this.checkin,
    this.checkout,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory AvailableTicket.fromJson(Map<String, dynamic> json) =>
      AvailableTicket(
        id: json["id"],
        numId: json["num_id"],
        row: json["row"],
        number: json["number"],
        type: json["type"],
        holdAt: json["hold_at"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
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
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
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
