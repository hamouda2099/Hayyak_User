import 'package:flutter/material.dart';
import 'package:hayyak/main.dart';
import 'package:hayyak/Models/home_model.dart';

class HomeSlider extends StatelessWidget {
  HomeSlider({required this.slider});
  List<SliderEvents> slider = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth / 1,
      height: screenHeight / 3,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: slider.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(5),
            width: screenWidth / 1.5,
            height: screenHeight / 5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(slider[index].image.toString()))),
          );
        },
      ),
    );
  }
}
