import 'package:flutter/material.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/UI/Screens/event_seats_screen.dart';
import 'package:hayyak/UI/Screens/event_tickets_screen.dart';
import 'package:hayyak/main.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../Config/user_data.dart';
import '../../Dialogs/message_dialog.dart';

class DatePickerScreen extends StatefulWidget {
  DatePickerScreen(
      {required this.startDate,
      required this.endDate,
      required this.eventId,
      this.eventIsFav,
      required this.navigateScreen});

  String startDate = '';
  bool? eventIsFav;
  String endDate = '';
  String eventId = '';
  String navigateScreen = '';

  @override
  State<DatePickerScreen> createState() => _DatePickerScreenState();
}

class _DatePickerScreenState extends State<DatePickerScreen> {
  DateRangePickerController controller = DateRangePickerController();
  String selectedDate = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            UserData.translation.data?.selectDay?.toString() ?? 'Select Day',
            style: TextStyle(color: kDarkGreyColor),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.close,
                color: Colors.red,
              )),
        ),
        body: SafeArea(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(10),
            width: screenWidth / 1,
            height: screenHeight / 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: screenHeight / 1.5,
                  child: SfDateRangePicker(
                    headerStyle: const DateRangePickerHeaderStyle(
                        textStyle: TextStyle(
                            color: kPrimaryColor, fontWeight: FontWeight.bold)),
                    showNavigationArrow: true,
                    toggleDaySelection: true,
                    allowViewNavigation: true,
                    navigationDirection:
                        DateRangePickerNavigationDirection.vertical,
                    navigationMode: DateRangePickerNavigationMode.snap,
                    controller: controller,
                    view: (DateTime.tryParse(widget.endDate)?.month ==
                            DateTime.tryParse(widget.endDate)?.month)
                        ? DateRangePickerView.month
                        : DateRangePickerView.year,
                    extendableRangeSelectionDirection:
                        ExtendableRangeSelectionDirection.both,
                    enablePastDates: false,
                    initialSelectedDate:
                        (DateTime.tryParse(widget.startDate)?.day ==
                                    DateTime.tryParse(widget.endDate)?.day) &&
                                (DateTime.tryParse(widget.startDate)?.month ==
                                    DateTime.tryParse(widget.endDate)?.month) &&
                                (DateTime.tryParse(widget.startDate)?.year ==
                                    DateTime.tryParse(widget.endDate)?.year)
                            ? DateTime.tryParse(widget.startDate)
                            : null,
                    minDate: DateTime.tryParse(widget.startDate),
                    maxDate: DateTime.tryParse(widget.endDate),
                    onSelectionChanged: (value) {
                      selectedDate = value.value.toString();
                    },
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (DateTime.tryParse(widget.startDate)?.day ==
                            DateTime.tryParse(widget.endDate)?.day &&
                        DateTime.tryParse(widget.startDate)?.year ==
                            DateTime.tryParse(widget.endDate)?.year) {
                      selectedDate =
                          DateTime.tryParse(widget.startDate).toString();
                    }
                    if (selectedDate == '') {
                      messageDialog(
                          context,
                          UserData.translation.data?.pleaseSelectDate
                                  ?.toString() ??
                              'Please select date!');
                    } else {
                      if (widget.navigateScreen == 'seats') {
                        navigator(
                            context: context,
                            screen: EventSeatsScreen(
                              selectedDate: selectedDate,
                              eventId: widget.eventId,
                              eventIsFav: widget.eventIsFav,
                            ));
                      } else {
                        print("selectedDate");
                        print(selectedDate);
                        print(widget.startDate);
                        print(DateTime.parse(selectedDate ?? '').toString());
                        navigator(
                            context: context,
                            screen: EventTicketsScreen(
                              selectedDate: selectedDate,
                              eventId: widget.eventId,
                            ));
                      }
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: screenWidth / 1.2,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      UserData.translation.data?.confirm?.toString() ??
                          'Confirm',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
