import 'package:curved_drawer_fork/curved_drawer_fork.dart';
import 'package:flutter/material.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/UI/Components/Dashboard/screens/book_screen.dart';
import 'package:hayyak/UI/Components/Dashboard/screens/dashboard_screen.dart';
import 'package:hayyak/UI/Components/Dashboard/screens/departments_screen.dart';
import 'package:hayyak/UI/Components/Dashboard/screens/employees_screen.dart';
import 'package:hayyak/UI/Components/Dashboard/screens/history_screen.dart';
import 'package:hayyak/UI/Components/Dashboard/screens/surveys_screen.dart';

class DrawerComponent extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
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

      ],
      onTap: (int value) {
        if(value==0){
          navigator(context: context,screen: DashboardScreen());
        } else if (value == 1){
          navigator(context: context,screen: HistoryScreen());
        } else if (value == 2){
          navigator(context: context,screen: DepartmentScreen());
        } else if (value == 3){
          navigator(context: context,screen: EmployeesScreen());
        } else if (value ==4){
          navigator(context: context,screen: SurveysScreen());
        } else if (value==5){
          navigator(context: context,screen: BookScreen());

        }
      },
    );
  }
}
