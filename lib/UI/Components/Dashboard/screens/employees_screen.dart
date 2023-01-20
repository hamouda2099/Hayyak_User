import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/UI/Components/Dashboard/components/drawer_component.dart';
import 'package:hayyak/UI/Components/Dashboard/screens/create_department.dart';
import 'package:hayyak/main.dart';

class EmployeesScreen extends StatelessWidget {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerComponent(),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 5.0, left: 15, top: 15),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Employees',
                      style: TextStyle(
                          color: kDarkGreyColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              InkWell(
                onTap: () {
                  navigator(context: context, screen: CreateDepartment());
                },
                child: Padding(
                  padding:
                      const EdgeInsets.only(right: 15.0, left: 15, top: 20),
                  child: Row(
                    children: const [
                      Text(
                        'Create Employee',
                        style: TextStyle(color: Colors.blue),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.add_home_outlined,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: screenWidth / 1.1,
            decoration: BoxDecoration(
              border:
                  Border.all(color: kLightGreyColor.withOpacity(0.5), width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.search,
                  color: kLightGreyColor,
                ),
                hintText: 'Search',
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: 40,
                    child: Text(
                      'No',
                      style: TextStyle(color: Colors.blue, fontSize: 12),
                    )),
                Container(
                    width: screenWidth / 4,
                    child: Text(
                      'Employee Name',
                      style: TextStyle(color: kDarkGreyColor, fontSize: 12),
                    )),
                Container(
                    width: screenWidth / 5,
                    child: Text(
                      'Department',
                      style: TextStyle(color: kDarkGreyColor, fontSize: 12),
                    )),
                Container(
                    width: 50,
                    child: Text(
                      'Edit',
                      style: TextStyle(color: kDarkGreyColor, fontSize: 12),
                    )),
                Container(
                    width: 50,
                    child: Text(
                      'Delete',
                      style: TextStyle(color: kDarkGreyColor, fontSize: 12),
                    )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: screenWidth / 1.1,
            height: 1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: kDarkGreyColor,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Consumer(
            builder: (context, watch, child) {
              return Expanded(
                child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(20),
                      width: screenWidth / 1.3,
                      height: screenHeight / 8,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: 40,
                              child: Text(
                                index.toString(),
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 12),
                              )),
                          SizedBox(
                              width: screenWidth / 5,
                              child: Text(
                                'Employee Name',
                                style: TextStyle(
                                    color: kDarkGreyColor, fontSize: 12),
                              )),
                          SizedBox(
                              width: screenWidth / 5,
                              child: Text(
                                'Department',
                                style: TextStyle(color: kDarkGreyColor, fontSize: 12),
                              )),
                          Container(
                            width: 50,
                            child: InkWell(
                                onTap: () {},
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                  size: 20,
                                )),
                          ),
                          Container(
                            width: 50,
                            child: InkWell(
                                onTap: () {},
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 20,
                                )),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          )
        ],
      )),
    );
  }
}
