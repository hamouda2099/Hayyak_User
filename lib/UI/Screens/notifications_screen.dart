import 'package:flutter/material.dart';
import 'package:hayyak/UI/Components/notification_card_component.dart';
import 'package:hayyak/UI/Components/seccond_app_bar.dart';
import 'package:hayyak/main.dart';

import '../Components/bottom_nav_bar.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(currentScreen: 'Notifications'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SecondAppBar(title: 'Notification',shareAndFav: false,backToHome: false),
              Container(
                  height: screenHeight / 1.2,
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return NotificationCard();
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
