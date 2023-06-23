import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Dialogs/message_dialog.dart';
import 'package:hayyak/Logic/UI%20Logic/event_tickets_logic.dart';
import 'package:hayyak/Models/event_tickets_model.dart';
import 'package:hayyak/UI/Screens/event_tickets_screen.dart';
import 'package:hayyak/main.dart';

class TicketComponentInTicketDetails extends StatelessWidget {
  TicketComponentInTicketDetails(
      {super.key,
      required this.kind,
      required this.cartProvider,
      required this.totalProvider,
      required this.logic});

  Kind kind;
  StateProvider cartProvider;
  StateProvider totalProvider;
  EventTicketsLogic logic;
  List allTickets = [];

  @override
  Widget build(BuildContext context) {
    final counterProvider = StateProvider((ref) => 0);
    allTickets = kind.tickets!.data;
    return Consumer(
      builder: (context, ref, child) {
        final counter = ref.watch(counterProvider);
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
                        ref.read(counterProvider.notifier).state--;
                        ref.read(cartProvider.notifier).state--;
                        ref.read(totalProvider.notifier).state =
                            ref.read(totalProvider.notifier).state -
                                kind.finalCost;
                        allTickets.add(selectedTickets.first);
                        selectedTickets.removeAt(0);
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
                      if (counter == kind.countLimit) {
                        messageDialog(context,
                            '${kind.countLimit} tickets allowed for this kind !');
                      } else {
                        if (allTickets.isNotEmpty) {
                          ref.read(counterProvider.notifier).state++;
                          ref.read(cartProvider.notifier).state++;
                          ref.read(totalProvider.notifier).state =
                              ref.read(totalProvider.notifier).state +
                                  kind.finalCost;
                          selectedTickets.add(allTickets.first);
                          allTickets.remove(allTickets.first);
                          print(selectedTickets);
                        } else {
                          messageDialog(
                              context, 'this kind tickets was sold !');
                        }
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
