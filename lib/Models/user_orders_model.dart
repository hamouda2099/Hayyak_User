// To parse this JSON data, do
//
//     final userOrdersModel = userOrdersModelFromJson(jsonString);

import 'dart:convert';

UserOrdersModel userOrdersModelFromJson(String str) =>
    UserOrdersModel.fromJson(json.decode(str));

String userOrdersModelToJson(UserOrdersModel data) =>
    json.encode(data.toJson());

class UserOrdersModel {
  UserOrdersModel({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  bool? success;
  String? message;
  Data? data;
  int? code;

  factory UserOrdersModel.fromJson(Map<String, dynamic> json) =>
      UserOrdersModel(
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
    this.orders,
  });

  Orders? orders;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        orders: json["orders"] == null ? null : Orders.fromJson(json["orders"]),
      );

  Map<String, dynamic> toJson() => {
        "orders": orders?.toJson(),
      };
}

class Orders {
  Orders({
    this.upcomingOrders,
    this.pastOrders,
  });

  List<dynamic>? upcomingOrders;
  List<PastOrder>? pastOrders;

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
        upcomingOrders: json["upcomingOrders"] == null
            ? []
            : List<dynamic>.from(json["upcomingOrders"]!.map((x) => x)),
        pastOrders: json["pastOrders"] == null
            ? []
            : List<PastOrder>.from(
                json["pastOrders"]!.map((x) => PastOrder.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "upcomingOrders": upcomingOrders == null
            ? []
            : List<dynamic>.from(upcomingOrders!.map((x) => x)),
        "pastOrders": pastOrders == null
            ? []
            : List<dynamic>.from(pastOrders!.map((x) => x.toJson())),
      };
}

class PastOrder {
  PastOrder({
    this.orderId,
    this.eventId,
    required this.eventType,
    required this.eventName,
    required this.eventLocation,
    required this.image,
    required this.date,
  });

  int? orderId;
  int? eventId;
  String eventType;
  String eventName;
  String eventLocation;
  String image;
  String date;

  factory PastOrder.fromJson(Map<String, dynamic> json) => PastOrder(
        orderId: json["order_id"],
        eventId: json["event_id"],
        eventType: json["event_type"],
        eventName: json["event_name"],
        eventLocation: json["event_location"],
        image: json["image"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "event_id": eventId,
        "event_type": eventType,
        "event_name": eventName,
        "event_location": eventLocation,
        "image": image,
        "date": date,
      };
}
