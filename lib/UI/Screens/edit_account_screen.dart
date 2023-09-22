import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Dialogs/loading_screen.dart';
import 'package:hayyak/Logic/UI%20Logic/profile_logic.dart';
import 'package:hayyak/Models/profile_model.dart';
import 'package:hayyak/UI/Components/seccond_app_bar.dart';
import 'package:hayyak/main.dart';
import 'package:image_picker/image_picker.dart';

import '../../Config/user_data.dart';
import '../../Logic/Services/api_manger.dart';

class EditAccountScreen extends StatelessWidget {
  ProfileLogic logic = ProfileLogic();
  final rebuild = StateProvider<String?>((ref) => null);

  // final picker = StateProvider<ImagePicker>((ref) => ImagePicker());
  @override
  Widget build(BuildContext context) {
    logic.context = context;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SecondAppBar(
                  title: UserData.translation.data?.account?.toString() ??
                      'Edit Account',
                  shareAndFav: false,
                  backToHome: false),
              FutureBuilder<ProfileModel>(
                future: ApiManger.getProfileData(),
                builder: (BuildContext context,
                    AsyncSnapshot<ProfileModel> snapShot) {
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
                          child: Form(
                            key: logic.formKey,
                            child: Column(
                              children: [
                                Consumer(
                                  builder: (context, ref, child) {
                                    ref.watch(rebuild);
                                    return Stack(
                                      alignment: Alignment.bottomRight,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            PickedFile? pickedFile =
                                                await ImagePicker().getImage(
                                              source: ImageSource.gallery,
                                              maxWidth: 1800,
                                              maxHeight: 1800,
                                            );
                                            if (pickedFile != null) {
                                              logic.imageFile =
                                                  File(pickedFile.path);
                                              ref.read(rebuild.notifier).state =
                                                  DateTime.now().toString();
                                            }
                                          },
                                          child: Stack(
                                            alignment: Alignment.bottomRight,
                                            children: [
                                              logic.imageFile != null
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: Container(
                                                        width: 80,
                                                        height: 80,
                                                        decoration: BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            border: Border.all(
                                                                width: 1,
                                                                color:
                                                                    kDarkGreyColor)),
                                                        child: Image.file(
                                                          logic.imageFile!,
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    )
                                                  : Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: Container(
                                                        width: 80,
                                                        height: 80,
                                                        decoration: BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            border: Border.all(
                                                                width: 1,
                                                                color: kDarkGreyColor
                                                                    .withOpacity(
                                                                        0.3)),
                                                            image: DecorationImage(
                                                                image: NetworkImage(
                                                                    snapShot
                                                                            .data
                                                                            ?.data
                                                                            ?.image ??
                                                                        ''))),
                                                      ),
                                                    ),
                                              Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.blue
                                                      .withOpacity(0.5),
                                                ),
                                                child: const Icon(
                                                  Icons.camera_alt_outlined,
                                                  color: Colors.white,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                kPrimaryColor.withOpacity(0.5),
                                          ),
                                          child: const Icon(
                                            Icons.camera_alt_outlined,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 15.0, left: 15),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: screenWidth / 4,
                                        child: Text(
                                          UserData.translation.data?.firstName
                                                  ?.toString() ??
                                              'First Name',
                                          style: const TextStyle(
                                              color: kLightGreyColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ),
                                      Container(
                                          width: screenWidth / 1.5,
                                          height: 40,
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.only(
                                              right: 5, left: 5),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 0.5,
                                              color: kLightGreyColor
                                                  .withOpacity(0.3),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: TextFormField(
                                            controller: logic.firstNameCnt,
                                            validator: (val) {
                                              if (logic
                                                  .firstNameCnt.text.isEmpty) {
                                                return UserData.translation.data
                                                        ?.thisFieldIsRequired
                                                        ?.toString() ??
                                                    'This field is required';
                                              } else {
                                                return null;
                                              }
                                            },
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding: EdgeInsets.only(
                                                  bottom: 10,
                                                  left: 10,
                                                  right: 10),
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 15.0, left: 15),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: screenWidth / 4,
                                        child: Text(
                                          UserData.translation.data?.lastName
                                                  ?.toString() ??
                                              'Last Name',
                                          style: const TextStyle(
                                              color: kLightGreyColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ),
                                      Container(
                                          width: screenWidth / 1.5,
                                          height: 40,
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.only(
                                              right: 5, left: 5),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 0.5,
                                              color: kLightGreyColor
                                                  .withOpacity(0.3),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: TextFormField(
                                            controller: logic.lastNameCnt,
                                            validator: (val) {
                                              if (logic
                                                  .lastNameCnt.text.isEmpty) {
                                                return UserData.translation.data
                                                        ?.thisFieldIsRequired
                                                        ?.toString() ??
                                                    'This field is required';
                                              } else {
                                                return null;
                                              }
                                            },
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding: EdgeInsets.only(
                                                  bottom: 10,
                                                  left: 10,
                                                  right: 10),
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 15.0, left: 15),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: screenWidth / 4,
                                        child: Text(
                                          UserData.translation.data?.phone
                                                  ?.toString() ??
                                              'Phone',
                                          style: const TextStyle(
                                              color: kLightGreyColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ),
                                      Container(
                                          width: screenWidth / 1.5,
                                          height: 40,
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.only(
                                              right: 5, left: 5),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 0.5,
                                              color: kLightGreyColor
                                                  .withOpacity(0.3),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Directionality(
                                            textDirection: TextDirection.ltr,
                                            child: Row(
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  width: 50,
                                                  child: TextField(
                                                    enabled: false,
                                                    decoration: InputDecoration(
                                                      hintText: '  +966',
                                                      hintStyle: TextStyle(
                                                          color: kLightGreyColor
                                                              .withOpacity(0.8),
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          fontSize: 12),
                                                      border: InputBorder.none,
                                                    ),
                                                  ),
                                                ),
                                                const Text(
                                                  '|',
                                                  style: TextStyle(
                                                      color: kLightGreyColor,
                                                      fontSize: 14),
                                                ),
                                                SizedBox(
                                                  width: screenWidth / 2.5,
                                                  child: TextFormField(
                                                    controller: logic.phoneCnt,
                                                    validator: (val) {
                                                      if (logic.phoneCnt?.text
                                                              .isEmpty ??
                                                          ''.isEmpty) {
                                                        return UserData
                                                                .translation
                                                                .data
                                                                ?.thisFieldIsRequired
                                                                ?.toString() ??
                                                            'This field is required';
                                                      } else {
                                                        if (val?.length != 10) {
                                                          return UserData
                                                                  .translation
                                                                  .data
                                                                  ?.phone
                                                                  ?.toString() ??
                                                              'Phone must be of 10 digit';
                                                        } else {
                                                          return null;
                                                        }
                                                      }
                                                    },
                                                    decoration:
                                                        const InputDecoration(
                                                      border: InputBorder.none,
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              bottom: 10,
                                                              left: 10,
                                                              right: 10),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 15.0, left: 15),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: screenWidth / 4,
                                        child: Text(
                                          UserData.translation.data?.password
                                                  ?.toString() ??
                                              'Password',
                                          style: const TextStyle(
                                              color: kLightGreyColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ),
                                      Container(
                                          width: screenWidth / 1.5,
                                          height: 40,
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.only(
                                              right: 5, left: 5),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 0.5,
                                              color: kLightGreyColor
                                                  .withOpacity(0.3),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: TextFormField(
                                            controller: logic.passwordCnt,
                                            validator: (val) {
                                              if (logic.passwordCnt.text
                                                      .isEmpty ??
                                                  ''.isEmpty) {
                                                return UserData.translation.data
                                                        ?.thisFieldIsRequired
                                                        ?.toString() ??
                                                    'This field is required';
                                              } else {
                                                return null;
                                              }
                                            },
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding: EdgeInsets.only(
                                                  bottom: 10,
                                                  left: 10,
                                                  right: 10),
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    if (logic.formKey.currentState
                                            ?.validate() ??
                                        false) {
                                      logic.updateProfile();
                                    }
                                  },
                                  child: Container(
                                    width: screenWidth / 1.1,
                                    height: 50,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color:
                                              kLightGreyColor.withOpacity(0.5),
                                          width: 1),
                                    ),
                                    child: Text(
                                      UserData.translation.data?.save
                                              ?.toString() ??
                                          'Save',
                                      style: const TextStyle(
                                          color: kPrimaryColor, fontSize: 14),
                                    ),
                                  ),
                                )
                              ],
                            ),
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
