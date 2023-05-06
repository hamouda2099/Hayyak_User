import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Dialogs/loading_screen.dart';
import 'package:hayyak/Logic/UI%20Logic/profile_logic.dart';
import 'package:hayyak/Models/profile_model.dart';
import 'package:hayyak/UI/Components/box_shadow.dart';
import 'package:hayyak/UI/Components/custom_app_bar.dart';
import 'package:hayyak/UI/Components/seccond_app_bar.dart';
import 'package:hayyak/main.dart';
import 'package:image_picker/image_picker.dart';

import '../../Logic/Services/api_manger.dart';

class EditAccountScreen extends StatelessWidget {
  ProfileLogic logic = ProfileLogic();
  final picker = StateProvider<ImagePicker>((ref) => ImagePicker());
  @override
  Widget build(BuildContext context) {
    logic.context = context;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SecondAppBar(title: 'Edit Account',shareAndFav: false,backToHome: false),
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
                        logic.init(snapShot);
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              Consumer(builder: (context, watch, child) {
                                watch(picker).state;
                                return   InkWell(
                                  onTap:()async{
                                    XFile? image = await context.read(picker).state.pickImage(source: ImageSource.gallery);

                                  },
                                  child: Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Container(
                                          width: 80,
                                          height: 80,
                                          decoration: BoxDecoration(
                                              border: Border.all(width: 1,color: Colors.blue),
                                              shape: BoxShape.circle,
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
                                );

                              },),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 15.0, left: 15),
                                child: Row(
                                  children: [
                                    Container(
                                      width: screenWidth / 4,
                                      child: const Text(
                                        'First Name',
                                        style: TextStyle(
                                            color: kLightGreyColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ),
                                   Container(
                                       width: screenWidth/1.5,
                                       height: 40,
                                       alignment: Alignment.center,
                                       decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(20),
                                         // color: Colors.white,
                                         border: Border.all(width: 1,color: kLightGreyColor)
                                       ),
                                       child: TextField(
                                         controller: logic.firstNameCnt,
                                     decoration: InputDecoration(
                                       border: InputBorder.none,
                                       contentPadding: EdgeInsets.only(bottom: 10,left:10,right: 10 ),
                                     ),
                                   ))
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
                                      width: screenWidth / 4,
                                      child: const Text(
                                        'Last Name',
                                        style: TextStyle(
                                            color: kLightGreyColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ),
                                    Container(
                                        width: screenWidth/1.5,
                                        height: 40,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            // color: Colors.white,
                                            border: Border.all(width: 1,color: kLightGreyColor)
                                        ),
                                        child: TextField(
                                          controller: logic.lastNameCnt,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.only(bottom: 10,left:10,right: 10 ),
                                          ),
                                        ))

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
                                      width: screenWidth / 4,
                                      child: const Text(
                                        'Email',
                                        style: TextStyle(
                                            color: kLightGreyColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ),
                                    Container(
                                        width: screenWidth/1.5,
                                        height: 40,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            // color: Colors.white,
                                            border: Border.all(width: 1,color: kLightGreyColor)
                                        ),
                                        child: TextField(
                                          controller: logic.emailCnt,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.only(bottom: 10,left:10,right: 10 ),
                                          ),
                                        ))

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
                                      width: screenWidth / 4,
                                      child: const Text(
                                        'Phone',
                                        style: TextStyle(
                                            color: kLightGreyColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ),
                                    Container(
                                        width: screenWidth/1.5,
                                        height: 40,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            // color: Colors.white,
                                            border: Border.all(width: 1,color: kLightGreyColor)
                                        ),
                                        child: TextField(
                                          controller: logic.phoneCnt,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.only(bottom: 10,left:10,right: 10 ),
                                          ),
                                        ))

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
                                      width: screenWidth / 4,
                                      child: const Text(
                                        'Password',
                                        style: TextStyle(
                                            color: kLightGreyColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ),
                                    Container(
                                        width: screenWidth/1.5,
                                        height: 40,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            // color: Colors.white,
                                            border: Border.all(width: 1,color: kLightGreyColor)
                                        ),
                                        child: TextField(
                                          controller: logic.passwordCnt,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.only(bottom: 10,left:10,right: 10 ),
                                          ),
                                        ))

                                  ],
                                ),
                              ),

                              const SizedBox(
                                height: 20,
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.only(right: 15.0, left: 15),
                              //   child: Row(
                              //     children: [
                              //       Container(
                              //         width: screenWidth / 2,
                              //         child: const Text(
                              //           'Location',
                              //           style: TextStyle(
                              //               color: kLightGreyColor,
                              //               fontWeight: FontWeight.bold,
                              //               fontSize: 15),
                              //         ),
                              //       ),
                              //       Text(
                              //         'Egypt Cairo',
                              //         style: TextStyle(
                              //             color: kLightGreyColor.withOpacity(0.5),
                              //             fontWeight: FontWeight.bold,
                              //             fontSize: 15),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              InkWell(
                                onTap: (){
                                  logic.updateProfile();
                                },
                                child: Container(
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
      ),
    );
  }
}
