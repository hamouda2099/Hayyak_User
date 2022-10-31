import 'package:flutter/material.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/UI/Components/box_shadow.dart';
import 'package:hayyak/UI/Components/seccond_app_bar.dart';
import 'package:hayyak/UI/Components/text_field.dart';
import 'package:hayyak/main.dart';

class ContactUsScreen extends StatelessWidget {
  TextEditingController nameCnt = TextEditingController();
  TextEditingController phoneCnt = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SecondAppBar(title: 'Contact Us'),
              CustomTextField(
                controller: nameCnt,
                hintText: 'Name',
                obscure: false,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
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
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: '  +966',
                          hintStyle: TextStyle(
                              color: kLightGreyColor.withOpacity(0.8),
                              fontWeight: FontWeight.w300,
                              fontSize: 14),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Text(
                      '|',
                      style: TextStyle(color: kLightGreyColor, fontSize: 14),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      width: screenWidth / 2.5,
                      child: TextField(
                        controller: phoneCnt,
                        decoration: InputDecoration(
                          hintText: 'Phone',
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
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: emailController,
                hintText: 'Email',
                obscure: false,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: nameCnt,
                hintText: 'dd/mm/year',
                obscure: false,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: nameCnt,
                hintText: 'Subject',
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
                height: screenHeight / 4.5,
                child: TextField(
                  obscureText: false,
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Details',
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
                  // navigator(context: context,screen: SignUpScreen());
                },
                child: Container(
                  alignment: Alignment.center,
                  width: screenWidth / 1.2,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(15),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.phone,
                    size: 30,
                    color: kLightGreyColor,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '+92252224',
                    style: TextStyle(color: kLightGreyColor, fontSize: 15),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.language,
                    size: 30,
                    color: kLightGreyColor,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '+92252224',
                    style: TextStyle(color: kLightGreyColor, fontSize: 15),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on,
                    size: 30,
                    color: kLightGreyColor,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Lorem ipsum',
                    style: TextStyle(color: kLightGreyColor, fontSize: 15),
                  ),
                ],
              ),
              Container(
                width: screenWidth / 2,
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Icon(
                      Icons.g_mobiledata,
                      color: Colors.red,
                      size: 40,
                    ),
                    const Icon(
                      Icons.apple,
                      color: Colors.black,
                      size: 40,
                    ),
                    const Icon(
                      Icons.facebook,
                      color: Colors.blue,
                      size: 40,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
