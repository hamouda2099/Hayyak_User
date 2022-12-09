import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/UI/Components/bottom_nav_bar.dart';
import 'package:hayyak/UI/Components/seccond_app_bar.dart';
import 'package:hayyak/main.dart';

class VisitOrderScreen extends StatelessWidget {
  List purposes = ['Meeting', 'Other'];
  final purposeOfVisitProvider = StateProvider<String>((ref) => 'Meeting');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavBar(
        currentScreen: 'Visits',
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
        children: [
            SecondAppBar(title: 'The Host'),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: screenWidth / 2.5,
                    height: screenWidth / 2.5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                'https://media.istockphoto.com/id/831902158/photo/confidence-got-him-to-the-top.jpg?s=612x612&w=0&k=20&c=NPUySFpIi4KQtcBRKeLQLObP5TYaViw9WhHb9NwJbVw='))),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Employee Name',
                        style: TextStyle(
                            color: kLightGreyColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'Sales',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: screenWidth / 2,
                        height: 1,
                        color: Colors.grey.withOpacity(0.3),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Visitor'.toUpperCase(),
                        style: const TextStyle(
                            color: kPrimaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            top: 5, bottom: 5, right: 10, left: 10),
                        color: Colors.grey.withOpacity(0.2),
                        child: const Text(
                          'super@admin.com',
                          style: TextStyle(color: kLightGreyColor, fontSize: 12),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text(
                            'add visitor',
                            style: TextStyle(color: kDarkGreyColor, fontSize: 12),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Icon(
                            Icons.add,
                            color: kDarkGreyColor,
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  'Purpose of visit',
                  style: TextStyle(color: kPrimaryColor),
                ),
              ),
            ),
            Consumer(
              builder: (context, watch, child) {
                final value = watch(purposeOfVisitProvider).state;
                return Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        width: 0.5,
                        color: kLightGreyColor.withOpacity(0.3),
                      )),
                  width: screenWidth / 1,
                  child: DropdownButton(
                    underline: const SizedBox(),
                    isExpanded: true,
                    iconSize: 20,
                    icon: Icon(
                      Icons.arrow_drop_down_outlined,
                      color: Colors.black.withOpacity(0.5),
                    ),
                    value: value,
                    hint: const Text(
                      'Purpose of visit',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    onChanged: (newValue) {
                      context.refresh(purposeOfVisitProvider).state =
                          '${newValue}';
                    },
                    items: purposes.map((location) {
                      return DropdownMenuItem(
                        value: location,
                        child: Text(
                          location,
                          style: TextStyle(
                              color: kLightGreyColor.withOpacity(0.8),
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  'Schedule',
                  style: TextStyle(color: kPrimaryColor),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'From',
                    style: TextStyle(color: Colors.blue, fontSize: 14),
                  ),
                  SizedBox(width: 10,),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(0.3),width: 1),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    width: screenWidth / 3.5,
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                          suffixIcon: Icon(
                        Icons.access_time_rounded,
                        color: Colors.grey.withOpacity(0.3),
                      )),
                    ),
                  ),
                  Text(
                    'To',
                    style: TextStyle(color: Colors.blue, fontSize: 14),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.withOpacity(0.3),width: 1),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    width: screenWidth / 3.5,
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: Icon(
                            Icons.access_time_rounded,
                            color: Colors.grey.withOpacity(0.3),
                          )),
                    ),
                  ),

                ],
              ),
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  'More Info',
                  style: TextStyle(color: kPrimaryColor),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.3),width: 1),
                  borderRadius: BorderRadius.circular(10)
              ),
              width: screenWidth / 1,
              child: TextField(
                maxLines: 2,
                decoration: InputDecoration(
                    border: InputBorder.none,),
              ),
            ),
          SizedBox(height: 10,),
          Container(
            alignment: Alignment.center,
            width: screenWidth/1.05,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Text('Confirm',style: TextStyle(color: Colors.white),),
          ),
          SizedBox(height: 50,),
        ],
      ),
          )),
    );
  }
}
