import 'package:curved_drawer_fork/curved_drawer_fork.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/UI/Components/Dashboard/components/drawer_component.dart';
import 'package:hayyak/UI/Components/Dashboard/components/incoming_card.dart';
import 'package:hayyak/UI/Components/Dashboard/components/pending_card.dart';
import 'package:hayyak/UI/Components/Dashboard/components/task_card.dart';
import 'package:hayyak/UI/Components/Dashboard/screens/invite_screen.dart';
import 'package:hayyak/main.dart';

class DashboardScreen extends StatelessWidget {
  final tabsProvider = StateProvider<String>((ref) => 'Incoming');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerComponent(),
      body: SafeArea(
        child: Container(
          width: screenWidth,
          height: screenHeight,
          color: Colors.white,
          alignment: Alignment.bottomCenter,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 5.0, left: 15, top: 15),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Dashboard',
                          style: TextStyle(
                              color: kDarkGreyColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                  InkWell(
                    onTap: (){
                      navigator(context: context,screen: InviteScreen());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15.0, left: 15, top: 20),
                      child: Row(
                        children: const [
                          Text('Invite',style: TextStyle(color: Colors.blue),),
                          SizedBox(width: 5,),
                          Icon(Icons.insert_invitation,color: Colors.blue,),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Control your Tasks',
                      style: TextStyle(
                        color: kLightGreyColor,
                        fontSize: 12,
                      ),
                    )),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(12.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Container(
              //         width: screenWidth / 8,
              //         height: screenWidth / 8,
              //         decoration: const BoxDecoration(
              //           shape: BoxShape.circle,
              //           image: DecorationImage(
              //               fit: BoxFit.cover,
              //               image:
              //                   AssetImage('assets/images/amr-diab-promo.jpg')),
              //         ),
              //       ),
              //       const SizedBox(
              //         width: 10,
              //       ),
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: const [
              //           Text('Mohamed Hamouda',
              //               style: TextStyle(
              //                   color: Colors.white,
              //                   fontSize: 14,
              //                   fontWeight: FontWeight.bold)),
              //           Text('enasss12@gmail.com',
              //               style:
              //                   TextStyle(color: Colors.white, fontSize: 12)),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: screenWidth,
                height: screenHeight / 1.2,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    Consumer(builder: (context, watch, child) {
                      watch(tabsProvider).state;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: (){
                              context.read(tabsProvider).state = 'Incoming';

                            },
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                    Text(
                                      'In-Coming',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Text(
                                        '24',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 5),
                                  width: 50,
                                  height: 2,
                                  decoration: BoxDecoration(
                                    color: context.read(tabsProvider).state == 'Incoming'? kLightGreyColor : Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              context.read(tabsProvider).state = 'Pending';
                            },
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                    Text(
                                      'Pending',
                                      style:
                                      TextStyle(color: Colors.grey, fontSize: 12),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Text(
                                        '5',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10),
                                      ),
                                    ),

                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 5),
                                  width: 50,
                                  height: 2,
                                  decoration: BoxDecoration(
                                    color: context.read(tabsProvider).state == 'Pending'? kLightGreyColor : Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              context.read(tabsProvider).state = 'Tasks';

                            },
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                    Text(
                                      'Tasks',
                                      style:
                                      TextStyle(color: Colors.grey, fontSize: 12),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Text(
                                        '30',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10),
                                      ),
                                    ),

                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 5),
                                  width: 50,
                                  height: 2,
                                  decoration: BoxDecoration(
                                    color: context.read(tabsProvider).state == 'Tasks'? kLightGreyColor : Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      );

                    },),
                    const SizedBox(
                      height: 10,
                    ),
                     Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Consumer(
                            builder: (context, watch, child) {
                              watch(tabsProvider);
                              return Text(
                                context.read(tabsProvider).state,
                                style: TextStyle(
                                    color: kDarkGreyColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              );
                            },
                          )
                        )),
                    Consumer(
                      builder: (context, watch, child) {
                       watch(tabsProvider);
                        return context.read(tabsProvider).state == 'Tasks' ? Expanded(
                          child: ListView.builder(
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return  TaskCard();
                            },
                          ),
                        ) : context.read(tabsProvider).state == 'Pending' ? Expanded(
                          child: ListView.builder(
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return  PendingCard();
                            },
                          ),
                        ) : Expanded(
                          child: ListView.builder(
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return  IncomingCard();
                            },
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
