import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Models/user_order_tickets_model.dart';
import 'package:hayyak/main.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ticket_widget/ticket_widget.dart';

class ServiceSliderItem extends StatelessWidget {
  ServiceSliderItem(
      {required this.orderService, required this.total, required this.index});

  OrderService orderService;
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
                QrImageView(
                  data: "https://hayyak.net/${orderService.serviceName}",
                  version: QrVersions.auto,
                  size: screenWidth / 1.6,
                ),
                SizedBox(
                  height: screenHeight / 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: screenWidth / 4.4,
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
                        '${'Ticket'.tr()}${index + 1} of $total',
                        style: TextStyle(color: kLightGreyColor, fontSize: 12),
                      ),
                    ),
                    Container(
                      width: screenWidth / 4.4,
                      height: 1,
                      color: kLightGreyColor,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: screenHeight / 3,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                            alignment: Alignment.center,
                            width: screenWidth / 1.5,
                            child: Text(
                              orderService.serviceName.toString(),
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: kDarkGreyColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )),
                        Container(
                          width: screenWidth / 2,
                          height: screenWidth / 3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                    orderService.image.toString())),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                            alignment: Alignment.center,
                            width: screenWidth / 1.5,
                            child: Text(
                              orderService.userName.toString(),
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: kDarkGreyColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        orderService.serviceName == null
                            ? SizedBox()
                            : Text(
                                orderService.serviceName.toString(),
                                style: const TextStyle(
                                    color: kDarkGreyColor, fontSize: 14),
                              ),
                        // Text('ROW : 34',style: TextStyle(color: kDarkGreyColor,fontSize: 12),),
                        // SizedBox(height: 5,),
                        //
                        // Text('SEAT : 34',style: TextStyle(color: kDarkGreyColor,fontSize: 12),),
                        // SizedBox(height: 10,),
                        Text(
                          orderService.date.toString(),
                          style: const TextStyle(
                              color: kDarkGreyColor, fontSize: 12),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Doors open ${orderService.doorsOpen}',
                          style: const TextStyle(
                              color: kDarkGreyColor, fontSize: 12),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Service valid until ${orderService.serviceValidUntil}',
                          style: TextStyle(
                              color: orderService.validity == 'valid'
                                  ? Colors.green
                                  : Colors.red,
                              fontSize: 12),
                        ),
                        const SizedBox(
                          height: 20,
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
