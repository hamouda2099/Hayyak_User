import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Logic/UI%20Logic/event_tickets_logic.dart';
import 'package:hayyak/Models/event_tickets_model.dart';
import 'package:hayyak/main.dart';

class TicketComponentInTicketDetails extends StatelessWidget {
  TicketComponentInTicketDetails(
      {required this.kind, required this.cartProvider,required this.logic});
  Kind kind;
  StateProvider cartProvider;
  EventTicketsLogic logic;
  @override
  Widget build(BuildContext context) {
    final counterProvider = StateProvider((ref) => 0);
    return Consumer(
      builder: (context, watch, child) {
        final counter = watch(counterProvider).state;
        return Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                      color: Color(int.parse(
                          '0xFF${kind.color.toString().substring(1)}')),
                      width: 25,
                      height: 25,
                      'assets/icon/ticket.svg'),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: screenWidth / 3,
                        child: Text(
                          kind.name,
                          style: TextStyle(
                              color: Color(int.parse(
                                  '0xFF${kind.color.toString().substring(1)}')),
                              fontSize: 12),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        kind.costAfterDiscount,
                        style: const TextStyle(
                            color: kDarkGreyColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      if (counter != 0) {
                        context.read(counterProvider).state--;
                        context.read(cartProvider).state--;
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: kLightGreyColor,
                      ),
                      child: const Icon(
                        Icons.remove,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    counter.toString(),
                    style:
                        const TextStyle(color: kLightGreyColor, fontSize: 14),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  InkWell(
                    onTap: () {
                      if (counter == kind.countLimit + 1) {
                      } else {
                        context.read(counterProvider).state++;
                        context.read(cartProvider).state++;

                        logic.addTicket(
                            ticketId: kind.id.toString(),
                            ticketKind: kind.name,
                            ticketPrice: kind.finalCost.toDouble(),
                            ticketCount: context.read(counterProvider).state);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: kPrimaryColor,
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
