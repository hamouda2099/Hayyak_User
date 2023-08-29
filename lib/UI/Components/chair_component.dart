import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/UI/Components/seat_category_component.dart';
import 'package:hayyak/UI/Screens/event_seats_screen.dart';
import 'package:hayyak/main.dart';

class ChairComponent extends ConsumerWidget {
  ChairComponent(
      {required this.rows,
      required this.tickets,
      required this.chairs,
      required this.selectedSeats,
      required this.categoryPrice});

  double categoryPrice;
  List<ChairComponent> chairs = [];
  List selectedSeats = [];
  bool submitted = false;
  late int index;
  late StateProvider provider;
  final selectedRowProvider = StateProvider<String>((ref) => 'Row');
  final selectedSeatProvider = StateProvider<Map>((ref) => {});
  final rebuild = StateProvider<String>((ref) => '');
  dynamic showedList = [];
  dynamic tickets;
  List rows = [];
  final seatsProvider = StateProvider<List>((ref) => []);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(rebuild);
    return Container(
      margin: const EdgeInsets.only(left: 45, right: 45),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Consumer(
            builder: (context, ref, child) {
              final value = ref.watch(selectedRowProvider);
              ref.watch(selectedSeatProvider);
              return Container(
                height: 30,
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
                    'Select Row',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  onChanged:
                      ref.read(selectedSeatProvider.notifier).state['number'] !=
                              null
                          ? null
                          : (newValue) {
                              ref.read(selectedRowProvider.notifier).state =
                                  newValue.toString();
                              showedList = [];
                              showedList = tickets['$newValue'];
                            },
                  items: rows.map((location) {
                    return DropdownMenuItem(
                      value: location,
                      child: Text(
                        location.toString(),
                        style: TextStyle(
                            color: kLightGreyColor.withOpacity(0.8),
                            fontSize: 12),
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          ),
          InkWell(onTap: () {
            if (ref.read(selectedSeatProvider.notifier).state['number'] ==
                    null &&
                ref.read(selectedRowProvider.notifier).state != 'Row') {
              for (int i = 0; showedList.length > i; i++) {
                if (selectedSeats.contains(showedList[i]['id'])) {
                  showedList.removeAt(i);
                }
              }
              ref.read(seatsProvider.notifier).state = showedList;
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    contentPadding: const EdgeInsets.all(3),
                    title: const Center(
                        child: Text(
                      'Select Seat',
                      style: TextStyle(color: kPrimaryColor, fontSize: 14),
                    )),
                    content: Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: screenWidth / 1.2,
                      height: screenHeight / 1.5,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        itemCount:
                            ref.read(seatsProvider.notifier).state.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              ref.read(selectedSeatProvider.notifier).state =
                                  ref.read(seatsProvider.notifier).state[index];
                              selectedSeats.add(ref
                                  .read(seatsProvider.notifier)
                                  .state[index]['id']);
                              globalSelectedSeats.add(ref
                                  .read(seatsProvider.notifier)
                                  .state[index]['id']);
                              ref.read(cartCounterProvider.notifier).state++;
                              ref.read(totalPriceProvider.notifier).state =
                                  ref.read(totalPriceProvider.notifier).state +
                                      categoryPrice;
                              submitted = true;
                              ref.read(rebuildProvide.notifier).state =
                                  DateTime.now().toString();
                              Navigator.pop(context);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 5),
                              width: 60,
                              height: 60,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                  image: const DecorationImage(
                                    fit: BoxFit.contain,
                                    opacity: 0.2,
                                    image:
                                        AssetImage('assets/images/pngegg.png'),
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Text(
                                  ref
                                      .read(seatsProvider.notifier)
                                      .state[index]['number']
                                      .toString(),
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 12),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            }
          }, child: Consumer(
            builder: (context, ref, child) {
              ref.watch(selectedSeatProvider);
              return ref.read(selectedSeatProvider.notifier).state['number'] ==
                      null
                  ? Container(
                      width: screenWidth / 5,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Text(
                        'Seat',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    )
                  : Text(ref
                      .read(selectedSeatProvider.notifier)
                      .state['number']
                      .toString());
            },
          )),
          IconButton(
            onPressed: () {
              if (selectedSeats.contains(
                      ref.read(selectedSeatProvider.notifier).state['id']) &&
                  globalSelectedSeats.contains(
                      ref.read(selectedSeatProvider.notifier).state['id'])) {
                chairs.removeAt(index);
                selectedSeats.remove(
                    ref.read(selectedSeatProvider.notifier).state['id']);
                globalSelectedSeats.remove(
                    ref.read(selectedSeatProvider.notifier).state['id']);
                ref.read(cartCounterProvider.notifier).state--;
                ref.read(totalPriceProvider.notifier).state =
                    ref.read(totalPriceProvider.notifier).state - categoryPrice;
              } else {
                chairs.removeAt(index);
              }

              for (int i = 0; showedList.length > i; i++) {
                if (selectedSeats.contains(showedList[i]['id'])) {
                  showedList.removeAt(i);
                }
              }
              ref.read(seatsProvider.notifier).state = showedList;
              ref.read(provider.notifier).state = DateTime.now().toString();
            },
            icon: const Icon(
              Icons.remove_circle_outline_rounded,
              size: 20,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
