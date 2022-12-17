import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/Models/home_model.dart';
import 'package:hayyak/UI/Screens/event_details_screen.dart';
import 'package:hayyak/main.dart';
import 'package:share/share.dart';

class EventHomeCard extends StatelessWidget {
  EventHomeCard(
      {super.key, required this.eventName,
      required this.image,
      required this.location,
      required this.startDate,
      required this.id});
  num id;
  String eventName;
  String image;
  String location;
  String startDate;
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
                    width: screenWidth / 3,
                    child: Text(
                      eventName,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: kLightGreyColor, fontSize: 14),
                    ),
                  ),
                  Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Share.share(
                                'https://hayyak.net/ar/event/$id',
                                subject: eventName);
                          },
                          child: const Icon(
                            Icons.file_upload_outlined,
                            size: 20,
                            color: kLightGreyColor,
                          )),
                      InkWell(
                        onTap: () {},
                        child: SvgPicture.asset(
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
                        width: screenWidth/4,
                        child: Text(
                          location,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: kLightGreyColor, fontSize: 12),
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
