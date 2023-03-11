import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hayyak/Dialogs/message_dialog.dart';
import 'package:hayyak/Models/event_seats_model.dart';
import 'package:hayyak/UI/Components/chair_component.dart';
import 'package:hayyak/main.dart';

import '../../Config/constants.dart';
import '../../Logic/UI Logic/seats_logic.dart';

final rebuildProvide = StateProvider<bool>((ref) => false);

class SeatCategoryComponent extends StatelessWidget {
  SeatCategoryComponent({required this.seatCategory});
  Kind seatCategory;
  List<ChairComponent> chairs = [];
  List selectedSeats = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey.withOpacity(0.2))),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  seatCategory.name,
                  style: TextStyle(
                      color: Color(int.parse(
                          '0xFF${seatCategory.color.toString().substring(1)}')),
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
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
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey.withOpacity(0.4),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: Text(
                  'Choose your seats',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                onPressed: () {
                  print(seatCategory.countLimit);
                  if (selectedSeats.length == seatCategory.countLimit) {
                    messageDialog(context,
                        'The limits of tickets to this category is ${seatCategory.countLimit}');
                  } else {
                    if (chairs.isNotEmpty) {
                      if (!chairs.last.submitted) {
                        messageDialog(
                            context, 'Please choose the current seat');
                      } else {
                        List rows = [];
                        rows.add('Row');
                        seatCategory.tickets.forEach((key, value) {
                          rows.add(key.toString());
                        });
                        chairs.add(ChairComponent(
                          rows: rows,
                          tickets: seatCategory.tickets,
                          chairs: chairs,
                          selectedSeats: selectedSeats,
                        ));
                        context.refresh(rebuildProvide);
                      }
                    } else {
                      List rows = [];
                      rows.add('Row');
                      seatCategory.tickets.forEach((key, value) {
                        rows.add(key.toString());
                      });
                      chairs.add(ChairComponent(
                        rows: rows,
                        tickets: seatCategory.tickets,
                        chairs: chairs,
                        selectedSeats: selectedSeats,
                      ));
                      context.refresh(rebuildProvide);
                    }
                  }
                },
                icon: Icon(
                  Icons.add_box_outlined,
                  color: Color(int.parse(
                      '0xFF${seatCategory.color.toString().substring(1)}')),
                ),
              ),
            ],
          ),
          Consumer(
            builder: (context, watch, child) {
              watch(rebuildProvide).state;

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
