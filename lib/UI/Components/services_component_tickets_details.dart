import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hayyak/Models/event_tickets_model.dart';
import 'package:hayyak/UI/Screens/event_tickets_screen.dart';

import '../../Config/constants.dart';
import '../../Logic/UI Logic/event_tickets_logic.dart';

class ServicesComponentInTicketDetails extends StatelessWidget {
  ServicesComponentInTicketDetails(
      {required this.service,
      required this.cartProvider,
      required this.totalProvider,
      required this.logic});

  Kind service;
  StateProvider cartProvider;
  StateProvider totalProvider;
  EventTicketsLogic logic;
  final checkedServiceProvider = StateProvider<bool>((ref) => false);

  // List allServices = [];
  @override
  Widget build(BuildContext context) {
    final counterProvider = StateProvider((ref) => 0);
    // allServices = service.tickets!.data;
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
                      color: kDarkGreyColor,
                      width: 20,
                      height: 20,
                      'assets/icon/dinner.svg'),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service.name ?? '',
                        style: const TextStyle(
                            color: kLightGreyColor, fontSize: 12),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        service.costAfterDiscount ?? "",
                        style: const TextStyle(
                            color: kLightGreyColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
              service.limit == 'yes'
                  ? Consumer(
                      builder: (context, ref, child) {
                        final checked = ref.watch(checkedServiceProvider);
                        return InkWell(
                          onTap: () {
                            if (checked) {
                              ref.read(checkedServiceProvider.notifier).state =
                                  false;
                              ref.read(cartProvider.notifier).state--;
                              ref.read(totalProvider.notifier).state =
                                  ref.read(totalProvider.notifier).state -
                                      service.finalCost;
                              selectedServices.removeWhere((element) =>
                                  element['service']['id'] == service.id);
                              if (ref.read(counterProvider.notifier).state !=
                                  0) {
                                selectedServices.add(
                                    {"service": service.toJson(), "count": 1});
                              }
                            } else {
                              ref.read(checkedServiceProvider.notifier).state =
                                  true;
                              ref.read(cartProvider.notifier).state++;
                              ref.read(totalProvider.notifier).state =
                                  ref.read(totalProvider.notifier).state +
                                      service.finalCost;
                              if (selectedServices.isEmpty) {
                                selectedServices.add(
                                    {"service": service.toJson(), "count": 1});
                              } else {
                                selectedServices.removeWhere((element) =>
                                    element['service']['id'] == service.id);
                                if (ref.read(counterProvider.notifier).state !=
                                    0) {
                                  selectedServices.add({
                                    "service": service.toJson(),
                                    "count": 1
                                  });
                                }
                              }
                            }
                          },
                          child: Icon(
                            checked
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                            color: checked ? kPrimaryColor : kDarkGreyColor,
                            size: 25,
                          ),
                        );
                      },
                    )
                  : Row(
                      children: [
                        InkWell(
                          onTap: () {
                            if (counter != 0) {
                              ref.read(counterProvider.notifier).state--;
                              ref.read(cartProvider.notifier).state--;
                              ref.read(totalProvider.notifier).state =
                                  ref.read(totalProvider.notifier).state -
                                      service.finalCost;
                              selectedServices.removeWhere((element) =>
                                  element['service']['id'] == service.id);
                              if (ref.read(counterProvider.notifier).state !=
                                  0) {
                                selectedServices.add({
                                  "service": service.toJson(),
                                  "count":
                                      ref.read(counterProvider.notifier).state
                                });
                              }
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
                          style: const TextStyle(
                              color: kLightGreyColor, fontSize: 14),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        InkWell(
                          onTap: () {
                            if (counter == service.countLimit!.toInt() + 1) {
                            } else {
                              ref.read(counterProvider.notifier).state++;
                              ref.read(cartProvider.notifier).state++;
                              ref.read(totalProvider.notifier).state =
                                  ref.read(totalProvider.notifier).state +
                                      service.finalCost;
                              if (selectedServices.isEmpty) {
                                selectedServices.add({
                                  "service": service.toJson(),
                                  "count":
                                      ref.read(counterProvider.notifier).state
                                });
                              } else {
                                selectedServices.removeWhere((element) =>
                                    element['service']['id'] == service.id);
                                if (ref.read(counterProvider.notifier).state !=
                                    0) {
                                  selectedServices.add({
                                    "service": service.toJson(),
                                    "count":
                                        ref.read(counterProvider.notifier).state
                                  });
                                }
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
                    )
            ],
          ),
        );
      },
    );
  }
}
