import 'package:flutter/material.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/main.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ticket_widget/ticket_widget.dart';

class TicketSliderItem extends StatelessWidget {
  const TicketSliderItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TicketWidget(
          width: screenWidth/1.3,
          height: screenHeight/1.3,
          isCornerRounded: true,
          child: Column(
            children: [
              SizedBox(height: 10,),
              Container(
                  alignment: Alignment.center,
                  width: screenWidth/1.5,
                  child: Text('Amr Diab',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: kDarkGreyColor,fontSize: 20,fontWeight: FontWeight.bold),)),
              QrImage(
                data: "https://hayyak.net/",
                version: QrVersions.auto,
                size: screenWidth/2,
              ),
              SizedBox(height: 20,),
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
              SizedBox(height: 10,),
              Container(
                height: screenHeight/3,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                      Container(
                        width: screenWidth / 2,
                        height: screenWidth / 3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage('assets/images/amr-diab-promo.jpg')),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                          alignment: Alignment.center,
                          width: screenWidth/1.5,
                          child: Text('Johane Maikel',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: kDarkGreyColor,fontSize: 16,fontWeight: FontWeight.bold),)),
                      SizedBox(height: 10,),
                      Text('General Admision',style: TextStyle(color: kDarkGreyColor,fontSize: 14),),
                      SizedBox(height: 10,),
                      Text('ROW : 34',style: TextStyle(color: kDarkGreyColor,fontSize: 12),),
                      SizedBox(height: 5,),

                      Text('SEAT : 34',style: TextStyle(color: kDarkGreyColor,fontSize: 12),),
                      SizedBox(height: 10,),
                      Text('Sat 14 Nov 8-12 AM',style: TextStyle(color: kDarkGreyColor,fontSize: 12),),
                      SizedBox(height: 5,),
                      Text('Doors open 9:30 PN=M',style: TextStyle(color: kDarkGreyColor,fontSize: 12),),
                      SizedBox(height: 5,),
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
              )


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
    );
  }
}
