import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/UI/Components/seccond_app_bar.dart';
import 'package:hayyak/UI/Screens/checkout_screen.dart';
import 'package:hayyak/main.dart';

import '../../Config/constants.dart';

class EventTicketsScreen extends StatelessWidget {
  const EventTicketsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        width: screenWidth/1,
        height: screenHeight/10,
        color: kDarkGreyColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Total Price',style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),),
                const SizedBox(height: 5,),
                const Text('201.0 SAR',style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),)
              ],
            ),
            SvgPicture.asset(
                color: Colors.white,
                width: 25, height: 25, 'assets/icon/Icon feather-shopping-cart.svg'),
            InkWell(
              onTap: (){
                navigator(context: context,screen: const CheckoutScreen());
              },
              child: Container(
                alignment: Alignment.center,
                width: screenWidth/2,
                height: 50,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text('Checkout',style: const TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),),
              ),
            )
          ],
        ),
      ),
      body: SafeArea(child: SingleChildScrollView(
        child: Column(children: [
          SecondAppBar(title: 'Amr Diab'),
          Container(
            width: screenWidth/1.2,
            height: screenHeight/6,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image:  AssetImage('assets/images/amr-diab-promo.jpg')),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            width: screenWidth/1.3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                        color: kDarkGreyColor,
                        width: 10, height: 25, 'assets/icon/Icon material-event.svg'),
                    const SizedBox(width: 5,),
                    const Text('Sat, Mar 12',style: TextStyle(color: kLightGreyColor,fontSize: 14),)
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.access_time_outlined,color: kLightGreyColor,size: 20,),
                    const SizedBox(width: 5,),
                    const Text('7:00 - 10:00 PM',style: TextStyle(color: kLightGreyColor,fontSize: 14),)
                  ],
                ),
               ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 30.0,right: 30,top: 10,bottom: 10),
            child: const Align(
                alignment: Alignment.centerLeft,
                child: const Text('Tickets',style: TextStyle(color: kLightGreyColor,fontSize: 16,fontWeight: FontWeight.bold),)),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            height: screenHeight/3.5,
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
              final counterProvider = StateProvider((ref) => 1);
              return Consumer(builder: (context, watch, child) {
                final counter = watch(counterProvider).state;
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          SvgPicture.asset(
                              color: kDarkGreyColor,
                              width: 25, height: 25, 'assets/icon/ticket.svg'),
                          const SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('General admission',style: const TextStyle(color: kLightGreyColor,fontSize: 16),),
                              const SizedBox(width: 20,),
                              const Text('50 SAR',style: TextStyle(color: kLightGreyColor,fontSize: 14,fontWeight: FontWeight.bold),)
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap:(){
                              if (counter != 0){
                                context.read(counterProvider).state--;
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: kLightGreyColor,
                              ),
                              child: const Icon(Icons.remove,color: Colors.white,size: 20,),
                            ),
                          ),
                          const SizedBox(width: 12,),

                          Text(counter.toString(),style: const TextStyle(color: kLightGreyColor,fontSize: 16),),
                          const SizedBox(width: 12,),

                          InkWell(
                            onTap:(){
                              context.read(counterProvider).state++;

                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue,
                              ),
                              child: const Icon(Icons.add,color: Colors.white,size: 20,),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },);
            },),
          ),
          Container(
            width: screenWidth/1.3,
            height: 1,
            color: Colors.grey,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 30.0,right: 30,top: 10,bottom: 10),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Services',style: TextStyle(color: kLightGreyColor,fontSize: 16,fontWeight: FontWeight.bold),)),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            height: screenHeight/3.5,
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                final counterProvider = StateProvider((ref) => 1);
                return Consumer(builder: (context, watch, child) {
                  final counter = watch(counterProvider).state;
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            SvgPicture.asset(
                                color: kDarkGreyColor,
                                width: 25, height: 25, 'assets/icon/dinner.svg'),
                            const SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('General admission',style: TextStyle(color: kLightGreyColor,fontSize: 16),),
                                const SizedBox(width: 20,),
                                const Text('50 SAR',style: const TextStyle(color: kLightGreyColor,fontSize: 14,fontWeight: FontWeight.bold),)
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap:(){
                                if (counter != 0){
                                  context.read(counterProvider).state--;
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: kLightGreyColor,
                                ),
                                child: const Icon(Icons.remove,color: Colors.white,size: 20,),
                              ),
                            ),
                            const SizedBox(width: 12,),

                            Text(counter.toString(),style: const TextStyle(color: kLightGreyColor,fontSize: 16),),
                            const SizedBox(width: 12,),

                            InkWell(
                              onTap:(){
                                context.read(counterProvider).state++;

                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue,
                                ),
                                child: const Icon(Icons.add,color: Colors.white,size: 20,),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },);
              },),
          ),

        ],),
      )) ,
    );
  }
}
