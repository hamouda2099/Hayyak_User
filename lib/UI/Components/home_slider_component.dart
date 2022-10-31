import 'package:flutter/material.dart';
import 'package:hayyak/main.dart';

class HomeSlider extends StatelessWidget {
  const HomeSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth/1,
      height: screenHeight/3,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 11,
        itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(5),
          width: screenWidth/1.5,
          height: screenHeight/5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.redAccent
          ),
        );
      },),
    );
  }
}
