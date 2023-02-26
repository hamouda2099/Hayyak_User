import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/main.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15.0,right: 15),
          child: Text('2023-03-31',style: TextStyle(color: kDarkGreyColor,fontSize: 14,fontWeight: FontWeight.bold),),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          width: screenWidth / 1.1,
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
                      width: screenWidth/1.8,
                      child: Text('Sameh Agag | 181',
                          maxLines: 3,
                          style: TextStyle(
                              color: kLightGreyColor,
                              fontSize: 12)),
                    ),
                    Container(
                      width: screenWidth/1.8,
                      child: Text('11-01-2023',
                          maxLines: 3,
                          style: TextStyle(
                              color: kLightGreyColor,
                              fontSize: 12)),
                    ),
                    Container(
                      width: screenWidth/1.8,
                      child: Text('1:49 PM - 4:49 PM',
                          maxLines: 3,
                          style: TextStyle(
                              color: kLightGreyColor,
                              fontSize: 12)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
