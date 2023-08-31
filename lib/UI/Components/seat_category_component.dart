import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hayyak/Config/user_data.dart';
import 'package:hayyak/Dialogs/message_dialog.dart';
import 'package:hayyak/Models/event_seats_model.dart';
import 'package:hayyak/UI/Components/chair_component.dart';

final rebuildProvide = StateProvider<String>((ref) => '');
List globalSelectedSeats = [];
List globalSelectedSeatsServices = [];

class SeatCategoryComponent extends ConsumerWidget {
  SeatCategoryComponent({required this.seatCategory});

  Kind seatCategory;
  List<ChairComponent> chairs = [];
  List selectedSeats = [];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                          color: Color(int.parse(
                              '0xFF${seatCategory.color.toString().substring(1)}')),
                          width: 25,
                          'assets/icon/ticket.svg'),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        seatCategory.name ?? '',
                        style: TextStyle(
                            color: Color(int.parse(
                                '0xFF${seatCategory.color.toString().substring(1)}')),
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 30),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 30, right: 30),
                          child: Text(
                            UserData.translation.data?.chooseYourSeat ??
                                'Choose your seats',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (selectedSeats.length ==
                                seatCategory.countLimit) {
                              messageDialog(context,
                                  'The limits of tickets to this category is ${seatCategory.countLimit}');
                            } else {
                              if (chairs.isNotEmpty) {
                                if (!chairs.last.submitted) {
                                  messageDialog(context,
                                      'Please choose the current seat');
                                } else {
                                  List rows = [];
                                  rows.add('Row');
                                  seatCategory.tickets.forEach((key, value) {
                                    rows.add(key.toString());
                                  });
                                  chairs.add(ChairComponent(
                                    categoryPrice: seatCategory?.finalCost ?? 0,
                                    rows: rows,
                                    tickets: seatCategory.tickets,
                                    chairs: chairs,
                                    selectedSeats: selectedSeats,
                                  ));
                                  ref.read(rebuildProvide.notifier).state =
                                      DateTime.now().toString();
                                }
                              } else {
                                List rows = [];
                                rows.add('Row');
                                seatCategory.tickets.forEach((key, value) {
                                  rows.add(key.toString());
                                });
                                chairs.add(ChairComponent(
                                  categoryPrice: seatCategory.finalCost ?? 0,
                                  rows: rows,
                                  tickets: seatCategory.tickets,
                                  chairs: chairs,
                                  selectedSeats: selectedSeats,
                                ));
                                ref.read(rebuildProvide.notifier).state =
                                    DateTime.now().toString();
                              }
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.add_box_outlined,
                              color: Color(
                                int.parse(
                                    '0xFF${seatCategory.color.toString().substring(1)}'),
                              ),
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    'Price',
                    style: TextStyle(
                      color: Color(int.parse(
                          '0xFF${seatCategory.color.toString().substring(1)}')),
                    ),
                  ),
                  Text(
                    '${seatCategory.finalCost} SAR',
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                ],
              )
            ],
          ),
          Consumer(
            builder: (context, ref, child) {
              ref.watch(rebuildProvide);
              return Column(
                children: List.generate(chairs.length, (index) {
                  chairs[index].index = index;
                  chairs[index].provider = rebuildProvide;
                  return chairs[index];
                }),
              );
            },
          )
        ],
      ),
    );
  }
}
