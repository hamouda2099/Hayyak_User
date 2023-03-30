import 'package:flutter/material.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/UI/Components/bottom_nav_bar.dart';
import 'package:hayyak/UI/Components/event_home_component.dart';
import 'package:hayyak/UI/Components/place_item_component.dart';
import 'package:hayyak/main.dart';

import '../Components/seccond_app_bar.dart';

class PlacesScreen extends StatelessWidget {
  PlacesScreen({Key? key}) : super(key: key);
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        currentScreen: 'Visits',
      ),
      body: SafeArea(
          child: Column(
        children: [
          SecondAppBar(
            title: 'Places',
            shareAndFav: false,
            backToHome: false,
          ),
          SizedBox(
            width: screenWidth / 1.1,
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: kLightGreyColor,
                ),
                hintText: 'Search Entities, Places',
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
              child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.87,
              crossAxisSpacing: 1,
              mainAxisSpacing: 0.3
            ),
            itemBuilder: (context, index) {
              return PlaceCard();
            },
          )),
        ],
      )),
    );
  }
}
