import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/Config/test_static_data.dart';
import 'package:hayyak/Dialogs/loading_screen.dart';
import 'package:hayyak/Logic/Services/api_manger.dart';
import 'package:hayyak/Models/event_seats_model.dart';
import 'package:hayyak/UI/Components/bottom_nav_bar.dart';
import 'package:hayyak/UI/Components/chair_component.dart';
import 'package:hayyak/UI/Components/image_viewer.dart';
import 'package:hayyak/UI/Components/seat_category_component.dart';
import 'package:hayyak/UI/Components/seccond_app_bar.dart';
import 'package:hayyak/UI/Screens/checkout_screen.dart';
import 'package:hayyak/main.dart';
import 'package:photo_view/photo_view.dart';

class EventSeatsScreen extends StatelessWidget {
  EventSeatsScreen({required this.selectedDate, required this.eventId});
  final tabProvider = StateProvider<String>((ref) => 'tickets');
  final cartCounterProvider = StateProvider<int>((ref) => 0);
  String selectedDate = '';
  String eventId = '';
  @override
  Widget build(BuildContext context) {
    print(eventId);
    print(selectedDate);
    return FutureBuilder<EventSeatsModel>(
      future: ApiManger.getEventSeats(
          date: selectedDate.substring(0, 10), eventId: eventId),
      builder: (BuildContext context, AsyncSnapshot<EventSeatsModel> snapShot) {
        switch (snapShot.connectionState) {
          case ConnectionState.waiting:
            {
              return Scaffold(
                body: Center(child: ScreenLoading()),
              );
            }
          default:
            if (snapShot.hasError) {
              print(snapShot);
              return Scaffold(
                  body: Center(child: Text('Error: ${snapShot.error}')));
            } else {
              print(snapShot.data!.data.event.kinds[0].tickets["A"][0]);
              return Scaffold(
                bottomNavigationBar: Container(
                  width: screenWidth / 1,
                  height: screenHeight / 10,
                  color: kDarkGreyColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Total Price',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '201.0 SAR',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0, right: 5),
                            child: SvgPicture.asset(
                                color: Colors.white,
                                width: 25,
                                height: 25,
                                'assets/icon/Icon feather-shopping-cart.svg'),
                          ),
                          Consumer(
                            builder: (context, watch, child) {
                              final cartCounter =  watch(cartCounterProvider).state;
                              return Container(
                                alignment: Alignment.center,
                                width: 15,
                                height: 15,
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child:  Text(
                                  cartCounter.toString(),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 8),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          navigator(context: context, screen: CheckoutScreen());
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: screenWidth / 2,
                          height: 35,
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Text(
                            'Checkout',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                body: SafeArea(

                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SecondAppBar(title: 'Seats', shareAndFav: false,backToHome: false),
                      InkWell(
                        onTap: () {
                         navigator(context: context,screen: ImageViewer(
                           url: snapShot
                               .data!.data.event.details.image ,
                         ));
                        },
                        child: Container(
                          width: double.infinity,
                          height: screenHeight / 4,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(snapShot
                                      .data!.data.event.details.image))),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                     const Align(
                       alignment:Alignment.topLeft,
                       child: Padding(
                         padding: EdgeInsets.only(left: 20.0,top: 10),
                         child: Text(
                           'Tickets',
                           style: TextStyle(
                               color: kDarkGreyColor,
                               fontSize: 14,
                               fontWeight: FontWeight.bold),
                         ),
                       ),
                     ),
                     Column(
                       children: List.generate(
                           snapShot.data!.data.event.kinds
                               .length, (index) {
                         return Padding(
                           padding: const EdgeInsets.only(bottom: 10.0),
                           child: SeatCategoryComponent(
                             seatCategory: snapShot
                                 .data!.data.event.kinds[index],
                           ),
                         );
                       }),
                     ),
                     SizedBox(height: 20,),
                     Container(
                       width: screenWidth / 1.1,
                       height: 1,
                       color: Colors.grey,
                     ),
                     const Align(
                       alignment:Alignment.topLeft,

                       child: Padding(
                         padding: EdgeInsets.only(left: 20.0,top: 10),
                         child: Text(
                           'Services',
                           style: TextStyle(
                               color: kDarkGreyColor,
                               fontSize: 14,
                               fontWeight: FontWeight.bold),
                         ),
                       ),
                     ),

                     Column(
                             children: List.generate(
                                 snapShot.data!.data.event.services.length,
                                 (index) {
                               final counterProvider =
                                   StateProvider((ref) => 0);
                               return Consumer(
                                 builder: (context, watch, child) {
                                   final counter =
                                       watch(counterProvider).state;
                                   return Padding(
                                     padding: const EdgeInsets.only(
                                         left: 20,
                                         right: 20,
                                         top: 10,
                                         bottom: 10),
                                     child: Row(
                                       crossAxisAlignment:
                                       CrossAxisAlignment.start,
                                       mainAxisAlignment:
                                       MainAxisAlignment
                                           .spaceBetween,
                                       children: [
                                         Row(
                                           crossAxisAlignment:
                                           CrossAxisAlignment
                                               .start,
                                           children: [
                                             SvgPicture.asset(
                                                 color: kDarkGreyColor,
                                                 width: 20,
                                                 height: 20,
                                                 'assets/icon/dinner.svg'),
                                             const SizedBox(
                                               width: 10,
                                             ),
                                             Column(
                                               crossAxisAlignment:
                                               CrossAxisAlignment
                                                   .start,
                                               children: [
                                                 Text(
                                                   snapShot
                                                       .data!
                                                       .data
                                                       .event
                                                       .services[index]
                                                       .name,
                                                   style: const TextStyle(
                                                       color:
                                                       kLightGreyColor,
                                                       fontSize: 12),
                                                 ),
                                                 const SizedBox(
                                                   height: 8,
                                                 ),
                                                 Text(
                                                   snapShot
                                                       .data!
                                                       .data
                                                       .event
                                                       .services[index]
                                                       .costAfterDiscount,
                                                   style: const TextStyle(
                                                       color:
                                                       kLightGreyColor,
                                                       fontSize: 12,
                                                       fontWeight:
                                                       FontWeight
                                                           .bold),
                                                 )
                                               ],
                                             ),
                                           ],
                                         ),
                                         Row(
                                           children: [
                                             InkWell(
                                               onTap: () {
                                                 if (counter != 0) {
                                                   context
                                                       .read(
                                                       counterProvider)
                                                       .state--;
                                                   // context.read(cartCounterProvider).state--;

                                                 }
                                               },
                                               child: Container(
                                                 padding:
                                                 const EdgeInsets
                                                     .all(5),
                                                 decoration:
                                                 const BoxDecoration(
                                                   shape:
                                                   BoxShape.circle,
                                                   color:
                                                   kLightGreyColor,
                                                 ),
                                                 child: const Icon(
                                                   Icons.remove,
                                                   color: Colors.white,
                                                   size: 12,
                                                 ),
                                               ),
                                             ),
                                             const SizedBox(
                                               width: 12,
                                             ),
                                             Text(
                                               counter.toString(),
                                               style: const TextStyle(
                                                   color:
                                                   kLightGreyColor,
                                                   fontSize: 14),
                                             ),
                                             const SizedBox(
                                               width: 12,
                                             ),
                                             InkWell(
                                               onTap: () {
                                                 if (counter ==
                                                     snapShot
                                                         .data!
                                                         .data
                                                         .event
                                                         .services[
                                                     index]
                                                         .countLimit +
                                                         1) {
                                                 } else {
                                                   context
                                                       .read(
                                                       counterProvider)
                                                       .state++;
                                                   // context.read(cartCounterProvider).state++;

                                                 }
                                               },
                                               child: Container(
                                                 padding:
                                                 const EdgeInsets
                                                     .all(5),
                                                 decoration:
                                                 const BoxDecoration(
                                                   shape:
                                                   BoxShape.circle,
                                                   color:
                                                   kPrimaryColor,
                                                 ),
                                                 child: const Icon(
                                                   Icons.add,
                                                   color: Colors.white,
                                                   size: 12,
                                                 ),
                                               ),
                                             ),
                                           ],
                                         )
                                       ],
                                     ),
                                   );
                                 },
                               );
                             }),
                           ),

                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )),
              );
            }
        }
      },
    );
  }
}
