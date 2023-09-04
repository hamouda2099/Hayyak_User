import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/Dialogs/loading_dialog.dart';
import 'package:hayyak/Dialogs/message_dialog.dart';
import 'package:hayyak/Logic/Services/api_manger.dart';
import 'package:hayyak/UI/Screens/event_details_screen.dart';
import 'package:hayyak/UI/Screens/favourite_list_screen.dart';
import 'package:hayyak/main.dart';

// import 'package:share/share.dart';

import '../../Config/constants.dart';
import '../../Models/fav_list_model.dart';

class FavRow extends StatelessWidget {
  FavRow({required this.item});

  Datum item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: screenWidth / 1.2,
      child: Row(
        children: [
          InkWell(
            onTap: () {
              navigator(
                  context: context, screen: EventDetails(eventId: item.id));
            },
            child: Container(
              width: screenWidth / 2.5,
              height: screenWidth / 3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(item.image),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: screenWidth / 2.2,
                child: Text(
                  item.name,
                  maxLines: 2,
                  style: const TextStyle(
                    color: kLightGreyColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 20,
                    color: kLightGreyColor,
                  ),
                  Container(
                    width: screenWidth / 2.5,
                    child: Text(
                      item.address,
                      overflow: TextOverflow.ellipsis,
                      style:
                          const TextStyle(color: kLightGreyColor, fontSize: 12),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  children: [
                    SizedBox(width: screenWidth / 3),
                    InkWell(
                        onTap: () {
                          // Share.share('https://hayyak.net/ar/event/${item.id}',
                          //     subject: item.name);
                        },
                        child: const Icon(
                          Icons.file_upload_outlined,
                          size: 20,
                          color: kLightGreyColor,
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        loadingDialog(context);
                        ApiManger.removeFromFav(id: item.id.toString())
                            .then((value) {
                          Navigator.pop(context);
                          if (value['success']) {
                            navigator(
                                context: context,
                                screen: const FavListScreen(),
                                replacement: true);
                          } else {
                            messageDialog(context, 'An error occurred');
                          }
                        });
                      },
                      child: SvgPicture.asset(
                        color: kLightGreyColor,
                        width: 20,
                        height: 20,
                        'assets/icon/solid_heart.svg',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
