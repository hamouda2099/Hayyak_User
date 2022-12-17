import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Logic/UI%20Logic/seats_logic.dart';
import 'package:hayyak/main.dart';

class ChairComponent extends ConsumerWidget {
  late StateProvider provider;
  late int index;
  final selectedRowProvider = StateProvider<String>((ref) => 'Select Row');
  final selectedSeatProvider = StateProvider<String>((ref) => 'Select Seat');
  final rebuild = StateProvider<bool>((ref) => false);
  List rowsList = ['B1', 'B2', 'Select Row'];
  List seatsList = ['1', '2', 'Select Seat'];
  bool submitted = false;
  Map submittedSeat = {};
  @override
  Widget build(BuildContext context, watch) {
    watch(rebuild).state;
    return submitted
        ? Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.chair,
                    color: Colors.green,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                      'Your chair in row ${submittedSeat['row']} Seat No ${submittedSeat['seat']}'),
                  IconButton(
                    onPressed: () {
                      submittedSeat = {};
                      submitted = false;
                      context.refresh(rebuild);
                    },
                    icon: const Icon(
                      Icons.remove_circle_outline_rounded,
                      size: 20,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container(
            margin: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Consumer(
                  builder: (context, watch, child) {
                    final value = watch(selectedRowProvider).state;
                    return Container(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            width: 0.5,
                            color: kLightGreyColor.withOpacity(0.3),
                          )),
                      width: screenWidth / 3.5,
                      child: DropdownButton(
                        underline: SizedBox(),
                        isExpanded: true,
                        iconSize: 20,
                        value: value,
                        icon: Icon(
                          Icons.arrow_drop_down_sharp,
                          color: Colors.black.withOpacity(0.5),
                        ),
                        hint: const Text(
                          'Select Gender',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        onChanged: (newValue) {
                          context.refresh(selectedRowProvider).state =
                              newValue.toString();
                        },
                        items: rowsList.map((location) {
                          return DropdownMenuItem(
                            value: location,
                            child: Text(
                              location,
                              style: TextStyle(
                                  color: kLightGreyColor.withOpacity(0.8),
                                  fontSize: 14),
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
                Consumer(
                  builder: (context, watch, child) {
                    final value = watch(selectedSeatProvider).state;
                    return Container(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            width: 0.5,
                            color: kLightGreyColor.withOpacity(0.3),
                          )),
                      width: screenWidth / 3.5,
                      child: DropdownButton(
                        underline: const SizedBox(),
                        isExpanded: true,
                        iconSize: 20,
                        value: value,
                        icon: Icon(
                          Icons.arrow_drop_down_sharp,
                          color: Colors.black.withOpacity(0.5),
                        ),
                        hint: const Text(
                          'Select Gender',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        onChanged: (newValue) {
                          context.refresh(selectedSeatProvider).state =
                              '$newValue';
                        },
                        items: seatsList.map((location) {
                          return DropdownMenuItem(
                            value: location,
                            child: Text(
                              location,
                              style: TextStyle(
                                  color: kLightGreyColor.withOpacity(0.8),
                                  fontSize: 14),
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
                IconButton(
                  onPressed: () {
                    SeatsLogic.chairs.removeAt(index);
                    context.refresh(provider);
                  },
                  icon: const Icon(
                    Icons.remove_circle_outline_rounded,
                    size: 20,
                    color: Colors.red,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    submittedSeat = {
                      'row': context.read(selectedRowProvider).state,
                      'seat': context.read(selectedSeatProvider).state
                    };
                    submitted = true;
                    context.refresh(rebuild);
                  },
                  icon: const Icon(
                    Icons.done,
                    size: 20,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          );
  }
}
