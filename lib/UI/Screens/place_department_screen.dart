import 'package:flutter/material.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/UI/Components/app_bar.dart';
import 'package:hayyak/UI/Components/bottom_nav_bar.dart';
import 'package:hayyak/UI/Components/host_card_component.dart';
import 'package:hayyak/UI/Components/seccond_app_bar.dart';
import 'package:hayyak/main.dart';

class PlaceDepartmentScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(currentScreen: 'Visits'),
      body: SafeArea(
         child: Column(
           children: [
             SecondAppBar(
               title: 'The Host',
               shareAndFav: false,
             ),
             const SizedBox(height: 10,),
             Expanded(
                 child: GridView.builder(
                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                       crossAxisCount: 2, childAspectRatio: 1.1),
                   itemCount: 10,
                   itemBuilder: (context, index) {
                     return HostCardComponent();
                   },
                 )),
           ],
         ),
      ),
    );
  }
}
