import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/UI/Components/Dashboard/components/drawer_component.dart';
import 'package:hayyak/UI/Components/Dashboard/screens/create_department.dart';
import 'package:hayyak/UI/Components/text_field.dart';
import 'package:hayyak/main.dart';

class SettingsScreen extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerComponent(),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:  [
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
                                'Profile',
                                style: TextStyle(
                                    color: kDarkGreyColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                      ],
                    ),

                  ],
                ),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://www.investnational.com.au/wp-content/uploads/2016/08/person-stock-2.png'
                                ))                                    ),
                      ),
                    ),
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue.withOpacity(0.5),
                      ),
                      child: const Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),

                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20, right: 10, bottom: 5),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Name AR',
                        style: TextStyle(color: kDarkGreyColor),
                      )),
                ),
                CustomTextField(
                  width: screenWidth / 1.2,
                  controller: controller,
                  hintText: 'Name AR',
                  obscure: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20, right: 10, bottom: 5),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Description AR',
                        style: TextStyle(color: kDarkGreyColor),
                      )),
                ),
                CustomTextField(
                  width: screenWidth / 1.2,
                  controller: controller,
                  hintText: 'Description AR',
                  obscure: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20, right: 10, bottom: 5),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Name EN',
                        style: TextStyle(color: kDarkGreyColor),
                      )),
                ),
                CustomTextField(
                  width: screenWidth / 1.2,
                  controller: controller,
                  hintText: 'Name EN',
                  obscure: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20, right: 10, bottom: 5),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Description EN',
                        style: TextStyle(color: kDarkGreyColor),
                      )),
                ),
                CustomTextField(
                  width: screenWidth / 1.2,
                  controller: controller,
                  hintText: 'Description EN',
                  obscure: false,
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: screenWidth/1.2,
                  height: screenHeight/3.5,
                  child: const GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(30.033333, 31.233334),
                      zoom: 14.4746,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: screenWidth / 1.1,
                  height: 50,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
