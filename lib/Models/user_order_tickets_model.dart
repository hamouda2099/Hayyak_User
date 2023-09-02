// To parse this JSON data, do
//
//     final userOrderTicketsModel = userOrderTicketsModelFromJson(jsonString);

import 'dart:convert';

UserOrderTicketsModel userOrderTicketsModelFromJson(String str) =>
    UserOrderTicketsModel.fromJson(json.decode(str));

String userOrderTicketsModelToJson(UserOrderTicketsModel data) =>
    json.encode(data.toJson());

class UserOrderTicketsModel {
  UserOrderTicketsModel({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  bool? success;
  String? message;
  Data? data;
  num? code;

  factory UserOrderTicketsModel.fromJson(Map<String, dynamic> json) =>
      UserOrderTicketsModel(
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
  Data({
    this.order,
  });

  Order? order;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        order: json["order"] == null ? null : Order.fromJson(json["order"]),
      );

  Map<String, dynamic> toJson() => {
        "order": order?.toJson(),
      };
}

class Order {
  Order({
    this.orderTickets,
    this.orderServices,
  });

  List<OrderTicket>? orderTickets;
  List<OrderService>? orderServices;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        orderTickets: json["orderTickets"] == null
            ? []
            : List<OrderTicket>.from(
                json["orderTickets"]!.map((x) => OrderTicket.fromJson(x))),
        orderServices: json["orderServices"] == null
            ? []
            : List<OrderService>.from(
                json["orderServices"]!.map((x) => OrderService.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "orderTickets": orderTickets == null
            ? []
            : List<dynamic>.from(orderTickets!.map((x) => x.toJson())),
        "orderServices": orderServices == null
            ? []
            : List<dynamic>.from(orderServices!.map((x) => x.toJson())),
      };
}

class OrderTicket {
  OrderTicket({
    this.orderId,
    this.ticketId,
    this.eventName,
    this.numId,
    this.image,
    this.userName,
    this.kindName,
    this.number,
    this.row,
    this.ticketUsedAt,
    this.ticketValidUntil,
    this.date,
    this.doorsOpen,
    this.validity,
  });

  num? orderId;
  num? ticketId;
  String? eventName;
  String? numId;
  String? image;
  String? userName;
  String? kindName;
  num? number;
  String? row;
  String? ticketUsedAt;
  String? ticketValidUntil;
  String? date;
  String? doorsOpen;
  String? validity;

  factory OrderTicket.fromJson(Map<String, dynamic> json) => OrderTicket(
      orderId: json["order_id"],
      ticketId: json["ticket_id"],
      eventName: json["event_name"],
      numId: json["num_id"],
      image: json["image"],
      userName: json["user_name"],
      kindName: json["kind_name"],
      number: json["number"],
      ticketUsedAt: json["ticket_used_at"],
      ticketValidUntil: json["ticket_valid_until"],
      date: json["date"],
      doorsOpen: json["doors_open"],
      validity: json["validity"],
      row: json["row"]);

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "ticket_id": ticketId,
        "event_name": eventName,
        "num_id": numId,
        "image": image,
        "user_name": userName,
        "kind_name": kindName,
        "number": number,
        "ticket_used_at": ticketUsedAt,
        "ticket_valid_until": ticketValidUntil,
        "date": date,
        "doors_open": doorsOpen,
        "row": row,
        "validity": validity,
      };
}

class OrderService {
  OrderService({
    this.orderId,
    this.serviceId,
    this.serviceName,
    this.numId,
    this.image,
    this.userName,
    this.kindName,
    this.number,
    this.serviceUsedAt,
    this.serviceValidUntil,
    this.date,
    this.doorsOpen,
    this.validity,
  });

  num? orderId;
  num? serviceId;
  String? serviceName;
  String? numId;
  String? image;
  String? userName;
  String? kindName;
  num? number;
  String? serviceUsedAt;
  String? serviceValidUntil;
  String? date;
  String? doorsOpen;
  String? validity;

  factory OrderService.fromJson(Map<String, dynamic> json) => OrderService(
        orderId: json["order_id"],
        serviceId: json["service_id"],
        serviceName: json["service_name"],
        numId: json["num_id"],
        image: json["image"],
        userName: json["user_name"],
        kindName: json["kind_name"],
        number: json["number"],
        serviceUsedAt: json["service_used_at"],
        serviceValidUntil: json["service_valid_until"],
        date: json["date"],
        validity: json["validity"],
        doorsOpen: json["doors_open"],
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "service_id": serviceId,
        "service_name": serviceName,
        "num_id": numId,
        "image": image,
        "user_name": userName,
        "kind_name": kindName,
        "number": number,
        "service_used_at": serviceUsedAt,
        "service_valid_until": serviceValidUntil,
        "date": date,
        "validity": validity,
        "doors_open": doorsOpen,
      };
}
