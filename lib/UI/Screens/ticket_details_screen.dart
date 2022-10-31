import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hayyak/UI/Components/box_shadow.dart';
import 'package:hayyak/main.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../Config/constants.dart';

class TicketDetails extends StatelessWidget {
  const TicketDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: screenWidth,
            height: screenHeight,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit:BoxFit.cover,

                    image: ExactAssetImage('assets/images/amr-diab-promo.jpg'))
            ),
            child: BackdropFilter(filter:  ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),child: Container(
              decoration:  BoxDecoration(color: Colors.white.withOpacity(0.0)),

            ),
            ),

          ),
          Align(alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: screenWidth/1.3,
                  height: screenHeight/1.3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: boxShadow,
                      color: Colors.white
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                      Text('AmrDiab',style: TextStyle(color: kDarkGreyColor,fontSize: 16),),
                      QrImage(
                        data: "https://hayyak.net/",
                        version: QrVersions.auto,
                        size: screenWidth/3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: screenWidth/4.5,
                            height: 1,
                            color: kLightGreyColor,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: Border.all(color: kLightGreyColor),
                              borderRadius: BorderRadius.circular(screenHeight),
                            ),
                            child: Text('Ticket 1 of 3',style: TextStyle(color: kLightGreyColor,fontSize: 12),),
                          ),
                          Container(
                            width: screenWidth/4.5,
                            height: 1,
                            color: kLightGreyColor,
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Container(
                        width: screenWidth / 3,
                        height: screenWidth / 3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/images/amr-diab-promo.jpg')),
                        ),
                      ),
                      Text('Johane Maikel',style: TextStyle(color: kDarkGreyColor,fontSize: 16),),
                      SizedBox(height: 20,),
                      Text('General Admition SEAT 34',style: TextStyle(color: kDarkGreyColor,fontSize: 14),),
                      SizedBox(height: 10,),
                      Text('Sat 14 Nov 8-12 AM',style: TextStyle(color: kDarkGreyColor,fontSize: 12),),
                      Text('Doors open 9:30 PN=M',style: TextStyle(color: kDarkGreyColor,fontSize: 12),),
                      Text('466, MNARA ELASAMAA',style: TextStyle(color: kDarkGreyColor,fontSize: 12),),
                      SizedBox(height: 20,),

                      Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Ticket #13145435',style: TextStyle(color: kDarkGreyColor,fontSize: 10),),
                          )),


                    ],
                  ),
                ),
                SizedBox(height: 20,),

                Container(
                  alignment: Alignment.center,
                  width: screenWidth/1.3,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text('Add to wallet',style: TextStyle(color: Colors.white,),),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon: Icon(Icons.close,color: Colors.white,)),
          )
        ],
      ),
    );
  }
}
