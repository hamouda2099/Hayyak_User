import 'package:flutter/material.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:hayyak/Dialogs/loading_screen.dart';
import 'package:hayyak/Models/profile_model.dart';
import 'package:hayyak/UI/Components/box_shadow.dart';
import 'package:hayyak/UI/Components/seccond_app_bar.dart';
import 'package:hayyak/UI/Screens/edit_account_screen.dart';
import 'package:hayyak/main.dart';

import '../../Config/user_data.dart';
import '../../Logic/Services/api_manger.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SecondAppBar(
                title:
                    UserData.translation.data?.account?.toString() ?? 'Account',
                shareAndFav: false,
                backToHome: false),
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
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: kPrimaryColor),
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            snapShot?.data?.data?.image ??
                                                ''))),
                              ),
                            ),
                            Text(
                              snapShot.data?.data?.name ?? '',
                              style: const TextStyle(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            Text(
                              snapShot.data?.data?.email ?? '',
                              style: const TextStyle(
                                  color: kLightGreyColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            InkWell(
                              onTap: () {
                                navigator(
                                    context: context,
                                    screen: EditAccountScreen());
                              },
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                width: screenWidth / 1.1,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: boxShadow),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.person,
                                          color: kDarkGreyColor,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                            UserData.translation.data
                                                    ?.personalInfo
                                                    ?.toString() ??
                                                'Personal Info',
                                            style: TextStyle(
                                                color: kLightGreyColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    Icon(
                                      Icons.mode_edit_outlined,
                                      color: kDarkGreyColor,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 15.0, left: 15),
                              child: Row(
                                children: [
                                  Container(
                                    width: screenWidth / 2,
                                    child: Text(
                                      UserData.translation.data?.firstName
                                              ?.toString() ??
                                          'First Name',
                                      style: TextStyle(
                                          color: kLightGreyColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ),
                                  Text(
                                    snapShot.data!.data!.firstName ?? '',
                                    style: TextStyle(
                                        color: kLightGreyColor.withOpacity(0.5),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 10, right: 15, left: 15),
                              width: double.infinity,
                              height: 1,
                              color: kLightGreyColor.withOpacity(0.5),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 15.0, left: 15),
                              child: Row(
                                children: [
                                  Container(
                                    width: screenWidth / 2,
                                    child: Text(
                                      UserData.translation.data?.lastName
                                              ?.toString() ??
                                          'Last Name',
                                      style: TextStyle(
                                          color: kLightGreyColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ),
                                  Text(
                                    snapShot.data!.data!.lastName ?? '',
                                    style: TextStyle(
                                        color: kLightGreyColor.withOpacity(0.5),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 10, right: 15, left: 15),
                              width: double.infinity,
                              height: 1,
                              color: kLightGreyColor.withOpacity(0.5),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 15.0, left: 15),
                              child: Row(
                                children: [
                                  Container(
                                    width: screenWidth / 2,
                                    child: Text(
                                      UserData.translation.data?.email
                                              ?.toString() ??
                                          'Email',
                                      style: TextStyle(
                                          color: kLightGreyColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ),
                                  Text(
                                    snapShot.data?.data?.email ?? '',
                                    style: TextStyle(
                                        color: kLightGreyColor.withOpacity(0.5),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 10, right: 15, left: 15),
                              width: double.infinity,
                              height: 1,
                              color: kLightGreyColor.withOpacity(0.5),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 15.0, left: 15),
                              child: Row(
                                children: [
                                  Container(
                                    width: screenWidth / 2,
                                    child: Text(
                                      UserData.translation.data?.phone
                                              ?.toString() ??
                                          'Phone',
                                      style: TextStyle(
                                          color: kLightGreyColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ),
                                  Text(
                                    snapShot.data?.data?.phone ?? '',
                                    style: TextStyle(
                                        color: kLightGreyColor.withOpacity(0.5),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 10, right: 15, left: 15),
                              width: double.infinity,
                              height: 1,
                              color: kLightGreyColor.withOpacity(0.5),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
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
