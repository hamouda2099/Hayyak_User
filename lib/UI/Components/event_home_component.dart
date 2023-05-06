import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/Config/user_data.dart';
import 'package:hayyak/Dialogs/loading_dialog.dart';
import 'package:hayyak/Dialogs/message_dialog.dart';
import 'package:hayyak/Logic/Services/api_manger.dart';
import 'package:hayyak/Models/home_model.dart';
import 'package:hayyak/UI/Screens/event_details_screen.dart';
import 'package:hayyak/UI/Screens/home_screen.dart';
import 'package:hayyak/main.dart';
import 'package:share/share.dart';

class EventHomeCard extends StatelessWidget {
  EventHomeCard(
      {super.key,
      required this.eventName,
      required this.image,
      required this.location,
      required this.startDate,
      required this.id,
      // ignore: non_constant_identifier_names
      required this.is_favourite});
  int id;
  String eventName;
  String image;
  String location;
  String startDate;
  // ignore: non_constant_identifier_names
  bool is_favourite;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigator(
            context: context,
            screen: EventDetails(
              eventId: id,
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          padding: const EdgeInsets.all(5),
          width: screenWidth / 2,
          height: screenHeight / 4,
          child: Column(
            children: [
              Container(
                width: screenWidth / 2,
                height: screenHeight / 5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        fit: BoxFit.fill, image: NetworkImage(image))),
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
                      eventName,
                      overflow: TextOverflow.ellipsis,
                      style:
                          const TextStyle(color: kLightGreyColor, fontSize: 12),
                    ),
                  ),
                  Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Share.share('https://hayyak.net/ar/event/$id',
                                subject: eventName);
                          },
                          child: const Icon(
                            Icons.file_upload_outlined,
                            size: 20,
                            color: kLightGreyColor,
                          )),
                      UserData.token == ''
                          ? SizedBox()
                          : InkWell(
                              onTap: () {
                                if (UserData.id == 0) {
                                  messageDialog(context,
                                      'Please Login to Add to Favourites !');
                                } else {
                                  if (is_favourite) {
                                    loadingDialog(context);
                                    ApiManger.removeFromFav(id: id.toString())
                                        .then((value) {
                                      Navigator.pop(context);
                                      if (value['success']) {
                                        navigator(
                                            context: context,
                                            screen: HomeScreen(),
                                            replacement: true);
                                      } else {
                                        messageDialog(
                                            context, 'An error occurred');
                                      }
                                    });
                                  } else {
                                    loadingDialog(context);
                                    ApiManger.addToFav(eventId: id.toString())
                                        .then((value) {
                                      Navigator.pop(context);
                                      if (value['success']) {
                                        navigator(
                                            context: context,
                                            screen: HomeScreen(),
                                            replacement: true);
                                      } else {
                                        messageDialog(
                                            context, 'An Error Occurred');
                                      }
                                    });
                                  }
                                }
                              },
                              child: is_favourite
                                  ? SvgPicture.asset(
                                      color: kLightGreyColor,
                                      width: 20,
                                      height: 20,
                                      'assets/icon/solid_heart.svg')
                                  : SvgPicture.asset(
                                      color: kLightGreyColor,
                                      width: 15,
                                      height: 15,
                                      'assets/icon/Icon feather-heart.svg'),
                            ),
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
                          location,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: kLightGreyColor, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    startDate,
                    style: const TextStyle(color: Colors.blue, fontSize: 12),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
