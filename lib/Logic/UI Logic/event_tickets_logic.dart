import 'package:flutter/cupertino.dart';

class EventTicketsLogic {
  late BuildContext context;
  List<Map<String,dynamic>> reservedTickets = [];
  List reservedServices = [];
  addTicket(
      {required String ticketId,
      required String ticketKind,
      required double ticketPrice,
      required int ticketCount}) async {
    Map<String,dynamic> ticket = {
      "ticketId": ticketId,
      "ticketKind": ticketKind,
      "ticketCount": ticketCount,
      "ticketPrice": ticketPrice,
      "ticketTotal": (ticketPrice * ticketCount)
    };
    print(ticket);
    if (reservedTickets.isEmpty){
      reservedTickets.add(ticket);
    } else {
      for (var element in reservedTickets) {
        if (ticket['ticketId'] == element['ticketId']) {
          reservedTickets.remove(element);
          reservedTickets.add(ticket);
        } else {
          reservedTickets.add(ticket);
        }
      }
    }
  }

  void countTotalPrice() {}
}
