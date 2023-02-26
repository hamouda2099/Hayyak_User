import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/UI/Screens/event_seats_screen.dart';
import 'package:hayyak/UI/Screens/event_tickets_screen.dart';
import 'package:hayyak/main.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DatePickerScreen extends StatefulWidget {
  DatePickerScreen({required this.startDate,required this.endDate,required this.eventId,required this.navigateScreen});
  String startDate ='' ;
  String endDate = '';
  String eventId ='';
  String navigateScreen ='';
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
        title: Text('Select Day',style: TextStyle(
          color: kDarkGreyColor
        ),),
        iconTheme: IconThemeData(
          color: Colors.blue
        ),

      ),
        body: SafeArea(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(10),
        width: screenWidth/1,
        height: screenHeight/1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: screenHeight/1.5,
              child: SfDateRangePicker(
                controller: controller,
                view: DateRangePickerView.year,
                enablePastDates : false,
                minDate: DateTime.tryParse(widget.startDate),
                maxDate: DateTime.tryParse(widget.endDate),
                onSelectionChanged: (value){
                  selectedDate = controller.selectedDate.toString();
                },
              ),
            ),
            InkWell(
              onTap: (){
                if (widget.navigateScreen == 'seats'){
                  navigator(
                      context: context, screen: EventSeatsScreen(
                    selectedDate: selectedDate,
                    eventId: widget.eventId,

                  ));
                } else {
                  navigator(context: context,screen: EventTicketsScreen(
                    selectedDate: selectedDate,
                    eventId: widget.eventId,
                  ));
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
                child: const Text(
                  'Confirm',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    )
    );
  }
}

