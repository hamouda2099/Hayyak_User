import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/main.dart';

class PendingCard extends StatelessWidget {
  const PendingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
      width: screenWidth / 1.3,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: screenWidth / 7,
            height: screenWidth / 7,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                      'assets/images/amr-diab-promo.jpg')),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children:  [
              Text('Job Visit',
                  style: TextStyle(
                      color: kDarkGreyColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold)),
              Container(
                width: screenWidth/2.5,
                child: Text('Sameh Agag | 181 | 11-01-2023 | 1:49 PM - 4:49 PM',
                    maxLines: 3,
                    style: TextStyle(
                        color: kLightGreyColor,
                        fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {},
            child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color:
                        kDarkGreyColor.withOpacity(0.15),
                        shape: BoxShape.circle),
                    child: const Icon(
                      Icons.close,
                      color: kDarkGreyColor,
                    )),
                Text('Cancel',style: TextStyle(color: kDarkGreyColor,fontSize: 10),)
              ],
            )
          ),
          const SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {},
            child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.blue
                            .withOpacity(0.15),
                        shape: BoxShape.circle),
                    child: const Icon(
                      Icons.edit,
                      color: Colors.blue,
                    )),
                Text('Edit',style: TextStyle(color: Colors.blue,fontSize: 10),)

              ],
            )
          ),
        ],
      ),
    );
  }
}
