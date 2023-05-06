import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/user_data.dart';
import 'package:hayyak/Dialogs/loading_dialog.dart';
import 'package:hayyak/Dialogs/loading_screen.dart';
import 'package:hayyak/Dialogs/message_dialog.dart';
import 'package:hayyak/Models/search_model.dart';
import 'package:hayyak/UI/Components/bottom_nav_bar.dart';
import 'package:hayyak/UI/Components/seccond_app_bar.dart';
import 'package:hayyak/UI/Screens/event_details_screen.dart';
import 'package:hayyak/UI/Screens/home_screen.dart';
import 'package:hayyak/main.dart';
import 'package:share/share.dart';

import '../../Config/navigator.dart';
import '../../Logic/Services/api_manger.dart';
import '../Components/event_home_component.dart';

class SearchScreen extends StatelessWidget {
TextEditingController controller = TextEditingController();
final rebuildProvider = StateProvider<bool>((ref) => false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(currentScreen: 'Search'),
      body: SafeArea(
        child: Column(
          children: [
            SecondAppBar(title: 'Search',shareAndFav: false,backToHome: false),
            Container(
              width: screenWidth/1.1,
              decoration: BoxDecoration(
                border: Border.all(color: kLightGreyColor.withOpacity(0.5),width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: controller,
                onChanged: (value){
                  context.refresh(rebuildProvider);
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search,color: kLightGreyColor,),
                  hintText: 'Search',
                ),
              ),
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Text('Recently',style: TextStyle(
                  color: kDarkGreyColor,fontSize: 14,fontWeight: FontWeight.bold,
                ),),
              ),
            ),
            Consumer(builder: (context, watch, child) {
             watch(rebuildProvider).state;
              return FutureBuilder<SearchModel>(
                future: ApiManger.search(query: controller.text),
                builder: (BuildContext context, AsyncSnapshot<SearchModel> snapShot) {
                  switch (snapShot.connectionState) {
                    case ConnectionState.waiting:
                      {
                        return ScreenLoading();
                      }
                    default:
                      if (snapShot.hasError) {
                        return Text('Error: ${snapShot.error}');
                      } else {

                        return snapShot.data!.success == true ? Expanded(child: GridView.builder(
                          itemCount: snapShot.data!.data!.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1/1.2
                          ),
                          itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              navigator(
                                  context: context,
                                  screen: EventDetails(
                                    eventId: snapShot.data!.data![index].id,
                                  ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                width: screenWidth / 2,
                                child: Column(
                                  children: [
                                    Container(
                                      width: screenWidth / 2,
                                      height: screenHeight / 5,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          image: DecorationImage(
                                              fit: BoxFit.fill, image: NetworkImage(snapShot.data!.data![index].image.toString()))),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: screenWidth / 2.8,
                                          child: Text(
                                            snapShot.data!.data![index].name.toString(),
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                            const TextStyle(color: kLightGreyColor, fontSize: 12),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            InkWell(
                                                onTap: () {
                                                  Share.share('https://hayyak.net/ar/event/${snapShot.data!.data![index].id}',
                                                      subject: snapShot.data!.data![index].name.toString());
                                                },
                                                child: const Icon(
                                                  Icons.file_upload_outlined,
                                                  size: 20,
                                                  color: kLightGreyColor,
                                                )),
                                            // UserData.token == '' ? SizedBox():  InkWell(
                                            //   onTap: () {
                                            //     if (UserData.id == 0){
                                            //       messageDialog(context, 'Please Login to Add to Favourites !');
                                            //     } else {
                                            //       if (true) {
                                            //         loadingDialog(context);
                                            //         ApiManger.removeFromFav(id: snapShot.data!.data![index].id.toString())
                                            //             .then((value) {
                                            //           Navigator.pop(context);
                                            //           if (value['success']) {
                                            //             navigator(
                                            //                 context: context,
                                            //                 screen: HomeScreen(),
                                            //                 replacement: true);
                                            //           } else {
                                            //             messageDialog(context, 'An error occurred');
                                            //           }
                                            //         });
                                            //       }
                                            //       else {
                                            //         loadingDialog(context);
                                            //         ApiManger.addToFav(eventId: id.toString())
                                            //             .then((value) {
                                            //           Navigator.pop(context);
                                            //           if (value['success']) {
                                            //             navigator(
                                            //                 context: context,
                                            //                 screen: HomeScreen(),
                                            //                 replacement: true);
                                            //           } else {
                                            //             messageDialog(context, 'An Error Occurred');
                                            //           }
                                            //         });
                                            //       }
                                            //     }
                                            //   },
                                            //   child: is_favourite
                                            //       ? SvgPicture.asset(
                                            //       color: kLightGreyColor,
                                            //       width: 20,
                                            //       height: 20,
                                            //       'assets/icon/solid_heart.svg')
                                            //       : SvgPicture.asset(
                                            //       color: kLightGreyColor,
                                            //       width: 15,
                                            //       height: 15,
                                            //       'assets/icon/Icon feather-heart.svg'),
                                            // ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            const Icon(
                                              Icons.location_on,
                                              size: 20,
                                              color: kLightGreyColor,
                                            ),
                                            SizedBox(
                                              width: screenWidth / 4,
                                              child: Text(
                                                snapShot.data!.data![index].location.toString(),
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    color: kLightGreyColor, fontSize: 12),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          snapShot.data!.data![index].start.toString(),
                                          style: const TextStyle(color: Colors.blue, fontSize: 12),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },)) : const Text('Search for events',style: TextStyle(color: kLightGreyColor,fontSize: 14),);
                      }
                  }
                },
              );
            },)
          ],
        ),
      ),
    );
  }
}
