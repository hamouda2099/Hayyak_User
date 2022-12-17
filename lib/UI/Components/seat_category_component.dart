import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hayyak/UI/Components/chair_component.dart';
import 'package:hayyak/main.dart';

import '../../Config/constants.dart';
import '../../Logic/UI Logic/seats_logic.dart';

class SeatCategoryComponent extends StatelessWidget {
  SeatCategoryComponent({required this.seatCategory});
  Map seatCategory = {};
  final rebuildProvide = StateProvider<bool>((ref) => false);
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
                  seatCategory['seat_category'],
                  style: TextStyle(
                      color: seatCategory['color'],
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Column(
                  children: [
                    Text(
                      'Price',
                      style: TextStyle(color: seatCategory['color']),
                    ),
                    Text(
                      '${seatCategory['price']} SAR',
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
              const Text(
                'Choose your chair',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              IconButton(
                  onPressed: () {
                    SeatsLogic.chairs.add(ChairComponent());
                    context.refresh(rebuildProvide);
                  },
                  icon: Icon(
                    Icons.add_box_outlined,
                    color: seatCategory['color'],
                  ))
            ],
          ),
          Consumer(
            builder: (context, watch, child) {
              watch(rebuildProvide).state;
              return Container(
                width: double.infinity,
                height: screenHeight / 5,
                child: SeatsLogic.chairs.isEmpty
                    ? InkWell(
                        onTap: () {
                          SeatsLogic.chairs.add(ChairComponent());
                          context.refresh(rebuildProvide);
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          width: screenWidth / 2,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: seatCategory['color'],
                          ),
                          child: Text(
                            'Choose chair in this ${seatCategory['seat_category']}',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: SeatsLogic.chairs.length,
                        itemBuilder: (context, index) {
                          SeatsLogic.chairs[index].index = index;
                          SeatsLogic.chairs[index].provider = rebuildProvide;
                          return SeatsLogic.chairs[index];
                        },
                      ),
              );
            },
          )
        ],
      ),
    );
  }
}
