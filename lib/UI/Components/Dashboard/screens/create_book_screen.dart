import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/date_formatter.dart';
import 'package:hayyak/UI/Components/text_field.dart';
import 'package:hayyak/main.dart';

class CreateBook extends StatelessWidget {
  final departmentProvider = StateProvider<String>((ref) => 'Sales');
  final employeeProvider = StateProvider<String>((ref) => 'Ahmed Samir');
  TextEditingController visitOrderController = TextEditingController();
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController moreInfoController = TextEditingController();
  List departments = ['Sales', 'Production'];
  List employess = ['Ahmed Samir', 'Hamed Sadek'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_rounded,
                          color: kDarkGreyColor,
                        )),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 5.0, left: 15, top: 10),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Create Book',
                          style: TextStyle(
                              color: kDarkGreyColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20, right: 10, bottom: 5),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Name',
                      style: TextStyle(color: kDarkGreyColor),
                    )),
              ),
              CustomTextField(
                width: screenWidth / 1.2,
                controller: visitOrderController,
                hintText: 'Name',
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
                      'Email',
                      style: TextStyle(color: kDarkGreyColor),
                    )),
              ),
              CustomTextField(
                width: screenWidth / 1.2,
                controller: moreInfoController,
                hintText: 'Email',
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
                      'Category',
                      style: TextStyle(color: kDarkGreyColor),
                    )),
              ),
              CustomTextField(
                width: screenWidth / 1.2,
                controller: moreInfoController,
                hintText: 'Category',
                obscure: false,
              ),
              InkWell(
                onTap: () async {},
                child: Container(
                  alignment: Alignment.center,
                  width: screenWidth / 1.2,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(15),
                  child: const Text(
                    'SAVE',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
