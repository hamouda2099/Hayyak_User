import 'package:flutter/material.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/UI/Components/box_shadow.dart';
import 'package:hayyak/UI/Components/custom_app_bar.dart';
import 'package:hayyak/UI/Components/seccond_app_bar.dart';
import 'package:hayyak/main.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SecondAppBar(title: 'Account'),
            SingleChildScrollView(
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
                            color: Colors.blue.withOpacity(0.2),
                          ),
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
                  const Text(
                    'Enas karim',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  const Text(
                    'enasss12@gmail.com',
                    style: TextStyle(
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
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0, left: 15),
                    child: Row(
                      children: [
                        Container(
                          width: screenWidth / 2,
                          child: Text(
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
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0, left: 15),
                    child: Row(
                      children: [
                        Container(
                          width: screenWidth / 2,
                          child: Text(
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
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0, left: 15),
                    child: Row(
                      children: [
                        Container(
                          width: screenWidth / 2,
                          child: Text(
                            'Email',
                            style: TextStyle(
                                color: kLightGreyColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ),
                        Text(
                          'nasss12@gmail.com',
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
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0, left: 15),
                    child: Row(
                      children: [
                        Container(
                          width: screenWidth / 2,
                          child: Text(
                            'Phone',
                            style: TextStyle(
                                color: kLightGreyColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ),
                        Text(
                          '+9236652333664',
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
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0, left: 15),
                    child: Row(
                      children: [
                        Container(
                          width: screenWidth / 2,
                          child: Text(
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
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: screenWidth / 1.1,
                    height: 50,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: kLightGreyColor.withOpacity(0.5), width: 1),
                    ),
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.blue, fontSize: 14),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
