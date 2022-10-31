import 'package:flutter/material.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/UI/Components/bottom_nav_bar.dart';
import 'package:hayyak/UI/Components/fav_row_component.dart';
import 'package:hayyak/UI/Components/seccond_app_bar.dart';

class FavListScreen extends StatelessWidget {
  const FavListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(currentScreen: 'Favourites'),
      body: SafeArea(
        child: Column(
          children: [
            SecondAppBar(title: 'Favourites '),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Sat, Mar 19',
                  style: TextStyle(
                      color: kLightGreyColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
                child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return FavRow();
              },
            ))
          ],
        ),
      ),
    );
  }
}
