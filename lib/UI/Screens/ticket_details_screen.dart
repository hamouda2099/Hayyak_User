import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hayyak/Dialogs/loading_screen.dart';
import 'package:hayyak/Logic/Services/api_manger.dart';
import 'package:hayyak/Models/user_order_tickets_model.dart';
import 'package:hayyak/UI/Components/box_shadow.dart';
import 'package:hayyak/UI/Components/service_slider_component.dart';
import 'package:hayyak/UI/Components/ticket_slider_compnent.dart';
import 'package:hayyak/main.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ticket_widget/ticket_widget.dart';

import '../../Config/constants.dart';

class TicketDetails extends StatelessWidget {
  TicketDetails({required this.orderId});
  int? orderId;
  final _controllerTickets = PageController(initialPage: 0);
  final _controllerServices = PageController(initialPage: 0);
  final tabProvider = StateProvider<num>((ref) => 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<UserOrderTicketsModel>(
        future: ApiManger.getOrderTickets(orderId: orderId.toString()),
        builder: (BuildContext context,
            AsyncSnapshot<UserOrderTicketsModel> snapShot) {
          switch (snapShot.connectionState) {
            case ConnectionState.waiting:
              {
                return Center(child: ScreenLoading());
              }
            default:
              if (snapShot.hasError) {
                return Text('Error: ${snapShot.error}');
              } else {

                return Stack(
                  children: [
                    Container(
                      width: screenWidth,
                      height: screenHeight,
                      decoration:  BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  snapShot.data?.data?.order?.orderTickets?[0].image.toString()??''))),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.0)),
                        ),
                      ),
                    ),
                    Consumer(builder: (context, watch, child) {
                      final tab = watch(tabProvider).state;
                      return tab == 0  ? PageView.builder(
                        controller: _controllerTickets,
                        itemCount: snapShot.data?.data?.order?.orderTickets?.length??0,
                        itemBuilder: (context, index) {
                          return SizedBox(
                              width: screenWidth, child: TicketSliderItem(
                            orderTicket: snapShot.data!.data!.order!.orderTickets![index],
                            total:snapShot.data!.data!.order!.orderTickets!.length ,
                            index: index,
                          ));
                        },
                      ) : PageView.builder(
                        controller: _controllerServices,
                        itemCount: snapShot.data?.data?.order?.orderServices?.length??0,
                        itemBuilder: (context, index) {
                          return SizedBox(
                              width: screenWidth, child: ServiceSliderItem(
                            orderService: snapShot.data!.data!.order!.orderServices![index],
                            total:snapShot.data!.data!.order!.orderServices!.length ,
                            index: index,
                          ));
                        },
                      ) ;
                    },),

                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white,
                          )),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Consumer(
                        builder: (context, watch, child) {
                          final tab = watch(tabProvider).state;
                          return Container(
                            margin: const EdgeInsets.all(40),
                            width: screenWidth/1.2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap:(){
                                    context.read(tabProvider).state = 0;
                                  },
                                  child: Container(
                                      alignment: Alignment.center,
                                      width: screenWidth/3,
                                      height: 40,
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: tab == 0 ? Colors.blue :Colors.white.withOpacity(0.3) ,
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: const Text('Tickets',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                                ),
                                const SizedBox(width: 10,),
                                InkWell(
                                  onTap:(){
                                    context.read(tabProvider).state = 1;
                                  },
                                  child: Container(
                                      alignment: Alignment.center,
                                      width: screenWidth/3,
                                      height: 40,
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: tab == 1 ? Colors.blue :Colors.white.withOpacity(0.3) ,
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: const Text('Services',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
          }
        },
      ),
    );
  }
}
