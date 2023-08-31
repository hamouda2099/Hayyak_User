import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Dialogs/loading_screen.dart';
import 'package:hayyak/Logic/Services/api_manger.dart';
import 'package:hayyak/Models/user_orders_model.dart';
import 'package:hayyak/UI/Components/seccond_app_bar.dart';
import 'package:hayyak/UI/Components/ticket_card_component.dart';
import 'package:hayyak/main.dart';

import '../../Config/user_data.dart';
import '../Components/bottom_nav_bar.dart';

class MyTicketsScreen extends StatelessWidget {
  final tabProvider = StateProvider((ref) => 'Upcoming');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        currentScreen: 'Tickets',
      ),
      body: SafeArea(
        child: Column(
          children: [
            SecondAppBar(
              title: UserData.translation.data?.tickets?.toString() ??
                  'My Tickets',
              shareAndFav: false,
              backToHome: true,
            ),
            Container(
                width: screenWidth / 1.2,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: kLightGreyColor, width: 1)),
                child: Consumer(
                  builder: (context, ref, child) {
                    ref.watch(tabProvider);
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                            onTap: () {
                              ref.read(tabProvider.notifier).state = 'Upcoming';
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                UserData.translation.data?.upcoming
                                        ?.toString() ??
                                    'Upcoming',
                                style: TextStyle(
                                    color:
                                        ref.read(tabProvider.notifier).state ==
                                                'Upcoming'
                                            ? kPrimaryColor
                                            : kLightGreyColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                        Text(
                          '|',
                          style: TextStyle(
                              color: kLightGreyColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                        InkWell(
                            onTap: () {
                              ref.read(tabProvider.notifier).state = 'Past';
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                UserData.translation.data?.past?.toString() ??
                                    'Past',
                                style: TextStyle(
                                    color:
                                        ref.read(tabProvider.notifier).state ==
                                                'Past'
                                            ? kPrimaryColor
                                            : kLightGreyColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                      ],
                    );
                  },
                )),
            FutureBuilder<UserOrdersModel>(
              future: ApiManger.getUserOrders(),
              builder: (BuildContext context,
                  AsyncSnapshot<UserOrdersModel> snapShot) {
                switch (snapShot.connectionState) {
                  case ConnectionState.waiting:
                    {
                      return Center(child: ScreenLoading());
                    }
                  default:
                    if (snapShot.hasError) {
                      return Text('Error: ${snapShot.error}');
                    } else {
                      return snapShot.data!.success == true
                          ? Consumer(
                              builder: (context, ref, child) {
                                final tab = ref.watch(tabProvider);
                                return tab == 'Upcoming'
                                    ? SizedBox(
                                        height: screenHeight / 1.5,
                                        child: ListView.builder(
                                          itemCount: snapShot.data!.data!
                                              .orders!.upcomingOrders?.length,
                                          itemBuilder: (context, index) {
                                            return TicketCard(
                                              orderId: snapShot
                                                      .data!
                                                      .data!
                                                      .orders
                                                      ?.upcomingOrders?[index]
                                                  ['order_id'],
                                              name: snapShot.data!.data!.orders
                                                      ?.upcomingOrders?[index]
                                                  ['event_name'],
                                              date: snapShot.data!.data!.orders
                                                      ?.upcomingOrders?[index]
                                                  ['date'],
                                              image: snapShot.data!.data!.orders
                                                      ?.upcomingOrders?[index]
                                                  ['image'],
                                              location: snapShot
                                                      .data!
                                                      .data!
                                                      .orders
                                                      ?.upcomingOrders?[index]
                                                  ['event_location'],
                                            );
                                          },
                                        ),
                                      )
                                    : Padding(
                                        padding: EdgeInsets.only(top: 20),
                                        child: SizedBox(
                                          height: screenHeight / 1.5,
                                          child: ListView.builder(
                                            itemCount: snapShot
                                                    .data!
                                                    .data!
                                                    .orders!
                                                    .pastOrders!
                                                    .length ??
                                                0,
                                            itemBuilder: (context, index) {
                                              return TicketCard(
                                                orderId: snapShot
                                                    .data
                                                    ?.data
                                                    ?.orders
                                                    ?.pastOrders?[index]
                                                    .orderId,
                                                image: snapShot
                                                    .data!
                                                    .data!
                                                    .orders!
                                                    .pastOrders![index]
                                                    .image,
                                                date: snapShot
                                                    .data!
                                                    .data!
                                                    .orders!
                                                    .pastOrders![index]
                                                    .date,
                                                name: snapShot
                                                    .data!
                                                    .data!
                                                    .orders!
                                                    .pastOrders![index]
                                                    .eventName,
                                                location: snapShot
                                                    .data!
                                                    .data!
                                                    .orders!
                                                    .pastOrders![index]
                                                    .eventLocation,
                                              );
                                            },
                                          ),
                                        ),
                                      );
                              },
                            )
                          : Padding(
                              padding: EdgeInsets.only(top: screenHeight / 6),
                              child: const Center(child: Text('No Orders')),
                            );
                    }
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
