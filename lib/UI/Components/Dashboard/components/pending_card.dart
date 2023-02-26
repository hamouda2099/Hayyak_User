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
      padding: const EdgeInsets.all(10),
      width: screenWidth / 1.3,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: screenWidth / 8,
            height: screenWidth / 8,
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
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
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
                  child: Text('Sameh Agag',
                      maxLines: 3,
                      style: TextStyle(
                          color: kLightGreyColor,
                          fontSize: 12)),
                ),
                Container(
                  width: screenWidth/2.5,
                  child: Text('11-01-2023',
                      maxLines: 3,
                      style: TextStyle(
                          color: kLightGreyColor,
                          fontSize: 12)),
                ),
                Container(
                  width: screenWidth/2.5,
                  child: Text('1:49 PM - 4:49 PM',
                      maxLines: 3,
                      style: TextStyle(
                          color: kLightGreyColor,
                          fontSize: 12)),
                ),
                SizedBox(
                  width: screenWidth/1.425,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
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
                )
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),

        ],
      ),
    );
  }
}
