import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/date_formatter.dart';
import 'package:hayyak/UI/Components/text_field.dart';
import 'package:hayyak/main.dart';

class CreateDepartment extends StatelessWidget {
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
                          'Create Department',
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
                                  'data:image/jpeg;base64,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'))),
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
              const Padding(
                padding: EdgeInsets.only(left: 20, right: 10, bottom: 5),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Visit Reason',
                      style: TextStyle(color: kDarkGreyColor),
                    )),
              ),
              CustomTextField(
                width: screenWidth / 1.2,
                controller: visitOrderController,
                hintText: 'Visit Reason',
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
                      'More Information',
                      style: TextStyle(color: kDarkGreyColor),
                    )),
              ),
              CustomTextField(
                width: screenWidth / 1.2,
                controller: moreInfoController,
                hintText: 'More Information',
                obscure: false,
              ),
              const SizedBox(
                height: 10,
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
