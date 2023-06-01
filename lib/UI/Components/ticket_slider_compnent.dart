import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Models/user_order_tickets_model.dart';
import 'package:hayyak/main.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ticket_widget/ticket_widget.dart';

class TicketSliderItem extends StatelessWidget {
  TicketSliderItem(
      {required this.orderTicket, required this.total, required this.index});

  OrderTicket orderTicket;
  int index;
  int total;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TicketWidget(
            width: screenWidth / 1.3,
            height: screenHeight / 1.3,
            isCornerRounded: true,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                    alignment: Alignment.center,
                    width: screenWidth / 1.5,
                    child: Text(
                      orderTicket.eventName.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: kDarkGreyColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )),
                QrImageView(
                  data: "https://hayyak.net/${orderTicket.eventName}",
                  version: QrVersions.auto,
                  size: screenWidth / 2,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: screenWidth / 4.5,
                      height: 1,
                      color: kLightGreyColor,
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(color: kLightGreyColor),
                        borderRadius: BorderRadius.circular(screenHeight),
                      ),
                      child: Text(
                        'Ticket ${index + 1} of ${total}',
                        style: TextStyle(color: kLightGreyColor, fontSize: 12),
                      ),
                    ),
                    Container(
                      width: screenWidth / 4.5,
                      height: 1,
                      color: kLightGreyColor,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: screenHeight / 3,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: screenWidth / 2,
                          height: screenWidth / 3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image:
                                    NetworkImage(orderTicket.image.toString())),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                            alignment: Alignment.center,
                            width: screenWidth / 1.5,
                            child: Text(
                              orderTicket.userName.toString(),
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: kDarkGreyColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          orderTicket.kindName.toString(),
                          style: const TextStyle(
                              color: kDarkGreyColor, fontSize: 14),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        orderTicket.row == null
                            ? SizedBox()
                            : Text(
                                'ROW : ${orderTicket.row}',
                                style: TextStyle(
                                    color: kDarkGreyColor, fontSize: 12),
                              ),
                        SizedBox(
                          height: 5,
                        ),
                        orderTicket.number == null
                            ? SizedBox()
                            : Text(
                                'SEAT : ${orderTicket.number}',
                                style: TextStyle(
                                    color: kDarkGreyColor, fontSize: 12),
                              ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          orderTicket.date.toString(),
                          style: const TextStyle(
                              color: kDarkGreyColor, fontSize: 12),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Doors open ${orderTicket.doorsOpen}',
                          style: const TextStyle(
                              color: kDarkGreyColor, fontSize: 12),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Ticket #${orderTicket.ticketId}',
                                style: TextStyle(
                                    color: kDarkGreyColor, fontSize: 10),
                              ),
                            )),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: Text(
                              'Ticket valid until ${orderTicket.ticketValidUntil}',
                              style: const TextStyle(
                                  color: Colors.green, fontSize: 10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Platform.isAndroid
              ? const SizedBox()
              : InkWell(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    width: screenWidth / 1.3,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Text(
                      'Add to wallet',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
