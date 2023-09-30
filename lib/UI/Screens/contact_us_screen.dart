import 'package:flutter/material.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Logic/UI%20Logic/contact_us_logic.dart';
import 'package:hayyak/UI/Components/text_field.dart';
import 'package:hayyak/main.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Config/user_data.dart';

class ContactUsScreen extends StatelessWidget {
  ContactUsLogic logic = ContactUsLogic();

  @override
  Widget build(BuildContext context) {
    logic.context = context;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      logic.phoneCnt.text = UserData.phone ?? '';
      logic.emailController.text = UserData.email ?? '';
      logic.nameCnt.text = UserData.userName ?? '';
    });
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          UserData.translation.data?.contactUs?.toString() ?? 'Contact Us',
          style: const TextStyle(
              color: kDarkGreyColor, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: kLightGreyColor,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: logic.formKey,
            child: SizedBox(
              width: screenWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  UserData.token == '' && UserData.userName == ''
                      ? CustomTextField(
                          width: screenWidth / 1.2,
                          controller: logic.nameCnt,
                          validator: (val) {
                            if (logic.nameCnt.text.isEmpty) {
                              return UserData
                                      .translation.data?.thisFieldIsRequired
                                      ?.toString() ??
                                  'This field is required';
                            } else {
                              return null;
                            }
                          },
                          hintText: UserData.translation.data?.firstName
                                  ?.toString() ??
                              'Name',
                          obscure: false,
                        )
                      : SizedBox(),
                  const SizedBox(
                    height: 10,
                  ),
                  UserData.token == '' && UserData.phone == ''
                      ? Container(
                          width: screenWidth / 1.2,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.5,
                              color: kLightGreyColor.withOpacity(0.3),
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                width: 50,
                                child: TextField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                    hintText: '  +966',
                                    hintStyle: TextStyle(
                                        color: kLightGreyColor.withOpacity(0.8),
                                        fontWeight: FontWeight.w300,
                                        fontSize: 12),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              const Text(
                                '|',
                                style: TextStyle(
                                    color: kLightGreyColor, fontSize: 14),
                              ),
                              Container(
                                padding: const EdgeInsets.all(5),
                                width: screenWidth / 2.5,
                                child: TextFormField(
                                  controller: logic.phoneCnt,
                                  keyboardType: TextInputType.phone,
                                  validator: (val) {
                                    if (logic.phoneCnt?.text.isEmpty ??
                                        ''.isEmpty) {
                                      return UserData.translation.data
                                              ?.thisFieldIsRequired
                                              ?.toString() ??
                                          'This field is required';
                                    } else {
                                      if (val?.length != 10) {
                                        return UserData.translation.data?.phone
                                                ?.toString() ??
                                            'Phone must be of 10 digit';
                                      } else {
                                        return null;
                                      }
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: UserData.translation.data?.phone
                                            ?.toString() ??
                                        'Phone',
                                    hintStyle: TextStyle(
                                        color: kLightGreyColor.withOpacity(0.8),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : SizedBox(),
                  const SizedBox(
                    height: 10,
                  ),
                  UserData.token == '' && UserData.email == ''
                      ? CustomTextField(
                          width: screenWidth / 1.2,
                          controller: logic.emailController,
                          validator: (val) {
                            if (logic.emailController.text.isEmpty ??
                                ''.isEmpty) {
                              return UserData
                                      .translation.data?.thisFieldIsRequired
                                      ?.toString() ??
                                  'This field is required';
                            } else {
                              Pattern pattern =
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                              RegExp regex = RegExp(pattern.toString());
                              if (!regex.hasMatch(val ?? '') &&
                                  logic.emailController.text.isNotEmpty) {
                                return UserData.translation.data?.mainVaildation
                                        ?.toString() ??
                                    'Email should contain @ ex: mail@hayyak.com';
                              } else {
                                return null;
                              }
                            }
                          },
                          hintText:
                              UserData.translation.data?.email?.toString() ??
                                  'Email',
                          obscure: false,
                        )
                      : SizedBox(),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    width: screenWidth / 1.2,
                    controller: logic.subjectController,
                    validator: (val) {
                      if (logic.subjectController.text.isEmpty ?? ''.isEmpty) {
                        return UserData.translation.data?.thisFieldIsRequired
                                ?.toString() ??
                            'This field is required';
                      } else {
                        return null;
                      }
                    },
                    hintText: UserData.translation.data?.subject?.toString() ??
                        'Subject',
                    obscure: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 0.5,
                        color: kLightGreyColor.withOpacity(0.3),
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    width: screenWidth / 1.2,
                    height: screenHeight / 6,
                    child: TextFormField(
                      obscureText: false,
                      controller: logic.detailsController,
                      validator: (val) {
                        if (logic.detailsController.text.isEmpty ??
                            ''.isEmpty) {
                          return UserData.translation.data?.thisFieldIsRequired
                                  ?.toString() ??
                              'This field is required';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText:
                            UserData.translation.data?.details?.toString() ??
                                'Details',
                        hintStyle: TextStyle(
                            color: kLightGreyColor.withOpacity(0.8),
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () async {
                      if (logic.formKey.currentState?.validate() ?? false) {
                        logic.submitForm();
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: screenWidth / 1.2,
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        UserData.translation.data?.send?.toString() ?? 'Send',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async {
                            if (UserData.hayyakPhone != null) {
                              await launchUrl(
                                  Uri.parse("tel://${UserData.hayyakPhone}"));
                            }
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                width: screenWidth / 3,
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 30,
                                child: Icon(
                                  Icons.phone,
                                  size: 25,
                                  color: kLightGreyColor,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                UserData.hayyakPhone ?? '',
                                style: TextStyle(
                                    color: kLightGreyColor, fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            if (UserData.site != null) {
                              await launchUrl(Uri.parse(UserData.site ?? ''),
                                  mode: LaunchMode.externalApplication);
                            }
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                width: screenWidth / 3,
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 30,
                                child: Icon(
                                  Icons.language,
                                  size: 25,
                                  color: kLightGreyColor,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                UserData.site?.replaceAll("https://", "") ?? '',
                                style: TextStyle(
                                    color: kLightGreyColor, fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async {
                                if (UserData.facebook != null) {
                                  await launchUrl(
                                      Uri.parse(UserData.facebook ?? ''),
                                      mode: LaunchMode.externalApplication);
                                }
                              },
                              child: Image.asset(
                                "assets/images/facebook.png",
                                width: 30,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              onTap: () async {
                                if (UserData.twitter != null) {
                                  await launchUrl(
                                      Uri.parse(UserData.twitter ?? ''),
                                      mode: LaunchMode.externalApplication);
                                }
                              },
                              child: Image.asset(
                                "assets/images/twitter.png",
                                width: 30,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              onTap: () async {
                                if (UserData.gmail != null) {
                                  final Uri params = Uri(
                                    scheme: 'mailto',
                                    path: UserData.gmail,
                                    query:
                                        'subject=${logic.subjectController.text}&body=${logic.detailsController.text}', //add subject and body here
                                  );
                                  var url = params.toString();
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                }
                              },
                              child: Image.asset(
                                "assets/images/gmail.png",
                                width: 30,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              onTap: () async {
                                if (UserData.insta != null) {
                                  await launchUrl(
                                      Uri.parse(UserData.insta ?? ''),
                                      mode: LaunchMode.externalApplication);
                                }
                              },
                              child: Image.asset(
                                "assets/images/instagram.png",
                                width: 30,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              onTap: () async {
                                if (UserData.linkedIn != null) {
                                  await launchUrl(
                                      Uri.parse(UserData.linkedIn ?? ''),
                                      mode: LaunchMode.externalApplication);
                                }
                              },
                              child: Image.asset(
                                "assets/images/linkedin.png",
                                width: 30,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          textDirection: localLanguage == 'en'
                              ? TextDirection.ltr
                              : TextDirection.rtl,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 60,
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.location_on,
                                size: 50,
                                color: kLightGreyColor,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              UserData.hayyakAddress ?? '',
                              textDirection: localLanguage == 'en'
                                  ? TextDirection.ltr
                                  : TextDirection.rtl,
                              style: TextStyle(
                                  color: kLightGreyColor, fontSize: 15),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
