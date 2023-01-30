import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hayyak/UI/Components/box_shadow.dart';
import 'package:hayyak/UI/Components/ticket_slider_compnent.dart';
import 'package:hayyak/main.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ticket_widget/ticket_widget.dart';

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
          Padding(
            padding: EdgeInsets.only(top: 30),
            child: Align(alignment: Alignment.center,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                return Container(
                    width: screenWidth,
                    child: TicketSliderItem());
              },),
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
