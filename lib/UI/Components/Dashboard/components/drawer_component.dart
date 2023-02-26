import 'package:curved_drawer_fork/curved_drawer_fork.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/UI/Components/Dashboard/screens/book_screen.dart';
import 'package:hayyak/UI/Components/Dashboard/screens/dashboard_screen.dart';
import 'package:hayyak/UI/Components/Dashboard/screens/departments_screen.dart';
import 'package:hayyak/UI/Components/Dashboard/screens/employees_screen.dart';
import 'package:hayyak/UI/Components/Dashboard/screens/history_screen.dart';
import 'package:hayyak/UI/Components/Dashboard/screens/profile_screen.dart';
import 'package:hayyak/UI/Components/Dashboard/screens/settings_screen.dart';
import 'package:hayyak/UI/Components/Dashboard/screens/surveys_screen.dart';
import 'package:hayyak/UI/Screens/home_screen.dart';
final indexProvider = StateProvider((ref) => 0);

class DrawerComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
       final state = watch(indexProvider).state;
      return CurvedDrawer(
        items: const [
          DrawerItem(
              icon: Icon(
                Icons.dashboard,

              ),
              label: 'Dashboard'),
          DrawerItem(
              icon: Icon(
                Icons.history,
              ),
              label: 'History'),
          DrawerItem(
              icon: Icon(
                Icons.account_balance_rounded,
              ),
              label: 'Departments'),
          DrawerItem(
              icon: Icon(
                Icons.people_alt_rounded,
              ),
              label: 'Employees'),
          DrawerItem(
              icon: Icon(
                Icons.messenger_outline,
              ),
              label: 'Surveys'),
          DrawerItem(
              icon: Icon(
                Icons.book,
              ),
              label: 'Books'),
          DrawerItem(
              icon: Icon(
                Icons.person,
              ),
              label: 'Profile'),
          DrawerItem(
              icon: Icon(
                Icons.settings,
              ),
              label: 'Settings'),
          DrawerItem(
              icon: Icon(
                Icons.logout_outlined,
              ),
              label: 'Exit'),
        ],
        index: state,

        onTap: (int value) {
          if (value == 0) {
            Future.delayed(const Duration(milliseconds: 900), () {
              navigator(context: context, screen: DashboardScreen());
              context.read(indexProvider).state = 0;
              print(context.read(indexProvider).state);
              print(value);
            });
          } else if (value == 1) {
            Future.delayed(const Duration(milliseconds: 900), () {
              navigator(context: context, screen: HistoryScreen());
              context.read(indexProvider).state = 1;
            });
          } else if (value == 2) {
            Future.delayed(const Duration(milliseconds: 900), () {
              navigator(context: context, screen: DepartmentScreen());
              context.read(indexProvider).state = 2;

            });
          } else if (value == 3) {
            Future.delayed(const Duration(milliseconds: 900), () {
              navigator(context: context, screen: EmployeesScreen());
              context.read(indexProvider).state = 3;

            });
          } else if (value == 4) {
            Future.delayed(const Duration(milliseconds: 900), () {
              navigator(context: context, screen: SurveysScreen());
              context.read(indexProvider).state = 4;

            });
          } else if (value == 5) {
            Future.delayed(const Duration(milliseconds: 900), () {
              navigator(context: context, screen: BookScreen());
              context.read(indexProvider).state = 5;

            });
          } else if (value == 6) {
            Future.delayed(const Duration(milliseconds: 900), () {
              navigator(context: context, screen: ProfileScreen());
              context.read(indexProvider).state = 6;

            });
          } else if  (value == 7){
            Future.delayed(const Duration(milliseconds: 900), () {
              navigator(context: context, screen: SettingsScreen());
              context.read(indexProvider).state = 7;

            });
          } else if (value==8) {
            Future.delayed(const Duration(milliseconds: 900), () {
              navigator(context: context, screen: HomeScreen());
              context.read(indexProvider).state = 0;
            });
          }
        },
      );
    },);
  }
}
