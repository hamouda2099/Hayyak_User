import 'package:flutter/material.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Dialogs/loading_screen.dart';
import 'package:hayyak/Models/profile_model.dart';
import 'package:hayyak/UI/Components/box_shadow.dart';
import 'package:hayyak/UI/Components/custom_app_bar.dart';
import 'package:hayyak/UI/Components/seccond_app_bar.dart';
import 'package:hayyak/main.dart';

import '../../Logic/Services/api_manger.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SecondAppBar(title: 'Account',shareAndFav: false,),
            FutureBuilder<ProfileModel>(
              future: ApiManger.getProfileData(),
              builder:
                  (BuildContext context, AsyncSnapshot<ProfileModel> snapShot) {
                switch (snapShot.connectionState) {
                  case ConnectionState.waiting:
                    {
                      return ScreenLoading();
                    }
                  default:
                    if (snapShot.hasError) {
                      return Text('Error: ${snapShot.error}');
                    } else {
                      var fetchedOrder = snapShot.data;
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                        color: Colors.blue,
                                        image: DecorationImage(
                                            image: NetworkImage(
                                            snapShot?.data?.data?.image??''
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
                             Text(
                              snapShot.data?.data?.phone??'',
                              style: const TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                             Text(
                              snapShot.data?.data?.email??'',
                              style: const TextStyle(
                                  color: kLightGreyColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            Container(
                              margin: const EdgeInsets.all(10),
                              width: screenWidth / 1.1,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: boxShadow),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: const [
                                      Icon(
                                        Icons.person,
                                        color: kDarkGreyColor,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text('Personal Info',
                                          style: TextStyle(
                                              color: kLightGreyColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  const Icon(
                                    Icons.mode_edit_outlined,
                                    color: kDarkGreyColor,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 15.0, left: 15),
                              child: Row(
                                children: [
                                  Container(
                                    width: screenWidth / 2,
                                    child: const Text(
                                      'First Name',
                                      style: TextStyle(
                                          color: kLightGreyColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ),
                                  Text(
                                    'Enas',
                                    style: TextStyle(
                                        color: kLightGreyColor.withOpacity(0.5),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10, right: 15, left: 15),
                              width: double.infinity,
                              height: 1,
                              color: kLightGreyColor.withOpacity(0.5),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 15.0, left: 15),
                              child: Row(
                                children: [
                                  Container(
                                    width: screenWidth / 2,
                                    child: const Text(
                                      'Last Name',
                                      style: TextStyle(
                                          color: kLightGreyColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ),
                                  Text(
                                    'Karim',
                                    style: TextStyle(
                                        color: kLightGreyColor.withOpacity(0.5),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10, right: 15, left: 15),
                              width: double.infinity,
                              height: 1,
                              color: kLightGreyColor.withOpacity(0.5),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 15.0, left: 15),
                              child: Row(
                                children: [
                                  Container(
                                    width: screenWidth / 2,
                                    child: const Text(
                                      'Email',
                                      style: TextStyle(
                                          color: kLightGreyColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ),
                                  Text(
                                      snapShot.data?.data?.email??'',
                                    style: TextStyle(
                                        color: kLightGreyColor.withOpacity(0.5),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10, right: 15, left: 15),
                              width: double.infinity,
                              height: 1,
                              color: kLightGreyColor.withOpacity(0.5),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 15.0, left: 15),
                              child: Row(
                                children: [
                                  Container(
                                    width: screenWidth / 2,
                                    child: const Text(
                                      'Phone',
                                      style: TextStyle(
                                          color: kLightGreyColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ),
                                  Text(
                                      snapShot.data?.data?.phone??'',
                                    style: TextStyle(
                                        color: kLightGreyColor.withOpacity(0.5),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10, right: 15, left: 15),
                              width: double.infinity,
                              height: 1,
                              color: kLightGreyColor.withOpacity(0.5),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 15.0, left: 15),
                              child: Row(
                                children: [
                                  Container(
                                    width: screenWidth / 2,
                                    child: const Text(
                                      'Location',
                                      style: TextStyle(
                                          color: kLightGreyColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ),
                                  Text(
                                    'Egypt Cairo',
                                    style: TextStyle(
                                        color: kLightGreyColor.withOpacity(0.5),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10, right: 15, left: 15),
                              width: double.infinity,
                              height: 1,
                              color: kLightGreyColor.withOpacity(0.5),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: screenWidth / 1.1,
                              height: 50,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: kLightGreyColor.withOpacity(0.5), width: 1),
                              ),
                              child: const Text(
                                'Save',
                                style: TextStyle(color: Colors.blue, fontSize: 14),
                              ),
                            )
                          ],
                        ),
                      );
                    }
                }
              },
            ),

          ],
        ),
      ),
    );
  }
}
