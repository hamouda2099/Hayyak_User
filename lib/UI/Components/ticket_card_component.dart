import 'package:flutter/material.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/UI/Screens/ticket_details_screen.dart';
import 'package:hayyak/main.dart';

class TicketCard extends StatelessWidget {
  TicketCard(
      {required this.orderId,
      required this.name,
      required this.location,
      required this.image,
      required this.date});

  int? orderId;
  String? name, location, date, image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigator(
            context: context,
            screen: TicketDetails(
              orderId: orderId,
            ));
      },
      child: Container(
        width: screenWidth / 1.2,
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              width: screenWidth / 3,
              height: screenWidth / 3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage(image.toString())),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name.toString() + orderId.toString(),
                  style: TextStyle(color: kDarkGreyColor, fontSize: 14),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 20,
                      color: kLightGreyColor,
                    ),
                    Text(
                      location.toString(),
                      style: const TextStyle(color: Colors.blue, fontSize: 10),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.calendar_month_outlined,
                      size: 20,
                      color: kLightGreyColor,
                    ),
                    Text(
                      date.toString(),
                      style: const TextStyle(color: Colors.blue, fontSize: 10),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
