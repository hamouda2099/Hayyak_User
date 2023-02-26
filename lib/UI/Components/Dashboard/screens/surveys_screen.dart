import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/UI/Components/Dashboard/components/drawer_component.dart';
import 'package:hayyak/UI/Components/Dashboard/screens/create_department.dart';
import 'package:hayyak/UI/Components/Dashboard/screens/create_survey_screen.dart';
import 'package:hayyak/main.dart';

class SurveysScreen extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      key: _scaffoldKey,
      drawer: DrawerComponent(),
      backgroundColor: Colors.white,
      body: SafeArea(child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  IconButton(onPressed: (){
                    _scaffoldKey.currentState?.openDrawer();

                  }, icon: Icon(Icons.menu,color: Colors.blue,)),
                  const Padding(
                    padding: EdgeInsets.only(right: 5.0, left: 5, top: 5),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Surveys',
                          style: TextStyle(
                              color: kDarkGreyColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              ),

              InkWell(
                onTap: (){
                  navigator(context: context,screen: CreateSurvey());
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 15.0, left: 15, top: 10),
                  child: Row(
                    children: const [
                      Text('Create Survey',style: TextStyle(color: Colors.blue),),
                      SizedBox(width: 5,),
                      Icon(Icons.add_home_outlined,color: Colors.blue,),
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 20,),
          Container(
            width: screenWidth/1.1,
            decoration: BoxDecoration(
              border: Border.all(color: kLightGreyColor.withOpacity(0.5),width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search,color: kLightGreyColor,),
                hintText: 'Search',
              ),
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(left: 15.0,right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: screenWidth/4,
                    child: Text('Survey Name',style: TextStyle(color: Colors.blue),)),
                Container(
                    width: screenWidth/4,
                    child: Text('Processes',style: TextStyle(color: kDarkGreyColor),)),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Container(
            width: screenWidth/1.1,
            height: 1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: kDarkGreyColor,
            ),
          ),
          SizedBox(height: 5,),
          Consumer(
            builder: (context, watch, child) {
              return  Expanded(
                child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return  Container(
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.all(10),
                      width: screenWidth / 1.3,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              width: screenWidth/4,
                              child: Text('Survey Name',style: TextStyle(color: Colors.blue),)),
                          Container(
                              width: screenWidth/4,
                              child: Text('Processes',style: TextStyle(color: kDarkGreyColor),)),
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
