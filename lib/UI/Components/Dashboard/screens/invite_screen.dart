import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Config/date_formatter.dart';
import 'package:hayyak/UI/Components/text_field.dart';
import 'package:hayyak/main.dart';

class InviteScreen extends StatelessWidget {
   InviteScreen({Key? key}) : super(key: key);
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
                          'Invite',
                          style: TextStyle(
                              color: kDarkGreyColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              const Padding(
                padding: EdgeInsets.only(left: 20, right: 10,bottom: 5),
                child: Align(alignment:Alignment.topLeft,child: Text('Department',style: TextStyle(color: kDarkGreyColor),)),
              ),
              Consumer(
                builder: (context, watch, child) {
                  final value = watch(departmentProvider).state;
                  return Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          width: 0.5,
                          color: kLightGreyColor.withOpacity(0.3),
                        )),
                    width: screenWidth / 1.2,
                    child: DropdownButton(
                      underline: const SizedBox(),
                      isExpanded: true,
                      iconSize: 20,
                      icon: Icon(
                        Icons.arrow_drop_down_circle_rounded,
                        color: Colors.black.withOpacity(0.5),
                      ),
                      value: value,
                      hint: const Text(
                        'Select Gender',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      onChanged: (newValue) {
                        context.refresh(departmentProvider).state = '${newValue}';
                      },
                      items: departments.map((location) {
                        return DropdownMenuItem(
                          child: Text(
                            location,
                            style: TextStyle(
                                color: kLightGreyColor.withOpacity(0.8),
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                          value: location,
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20, right: 10,bottom: 5),
                child: Align(alignment:Alignment.topLeft,child: Text('Employee',style: TextStyle(color: kDarkGreyColor),)),
              ),
              Consumer(
                builder: (context, watch, child) {
                  final value = watch(employeeProvider).state;
                  return Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          width: 0.5,
                          color: kLightGreyColor.withOpacity(0.3),
                        )),
                    width: screenWidth / 1.2,
                    child: DropdownButton(
                      underline: const SizedBox(),
                      isExpanded: true,
                      iconSize: 20,
                      icon: Icon(
                        Icons.arrow_drop_down_circle_rounded,
                        color: Colors.black.withOpacity(0.5),
                      ),
                      value: value,
                      hint: const Text(
                        'Select Gender',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      onChanged: (newValue) {
                        context.refresh(employeeProvider).state = '${newValue}';
                      },
                      items: employess.map((location) {
                        return DropdownMenuItem(
                          child: Text(
                            location,
                            style: TextStyle(
                                color: kLightGreyColor.withOpacity(0.8),
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                          value: location,
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10,),
              const Padding(
                padding: EdgeInsets.only(left: 20, right: 10,bottom: 5),
                child: Align(alignment:Alignment.topLeft,child: Text('Visit Reason',style: TextStyle(color: kDarkGreyColor),)),
              ),
              CustomTextField(
                width: screenWidth/1.2,
                controller: visitOrderController,
                hintText: 'Visit Reason',
                obscure: false,
              ),
              const SizedBox(height: 10,),
              Container(
                padding: const EdgeInsets.all(5),
                width: screenWidth / 1.2,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.5,
                    color: kLightGreyColor.withOpacity(0.3),
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextField(
                  controller: dateController,
                  decoration: InputDecoration(
                    hintText: 'dd/mm/yy',
                    suffixIcon: IconButton(
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(), //get today's date
                            firstDate: DateTime(
                                2000), //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2101));
                        dateController.text =
                            dateFormatter(pickedDate.toString());
                      },
                      icon: Icon(
                        Icons.calendar_month,
                        color: kLightGreyColor,
                      ),
                    ),
                    hintStyle: TextStyle(
                        color: kLightGreyColor.withOpacity(0.8),
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              SizedBox(
                width: screenWidth/1.2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       const Text('From',style: TextStyle(color: kDarkGreyColor),),
                       SizedBox(height: 5,),
                       CustomTextField(
                         width: screenWidth/2.5,
                         controller: fromController,
                         hintText: 'From',
                         obscure: false,
                       ),
                     ],
                   ),
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       const Text('To',style: TextStyle(color: kDarkGreyColor),),
                       SizedBox(height: 5,),
                       CustomTextField(
                         width: screenWidth/2.5,
                         controller: toController,
                         hintText: 'To',
                         obscure: false,
                       ),
                     ],
                   ),

                  ],
                ),
              ),
              const SizedBox(height: 10,),

              const Padding(
                padding: EdgeInsets.only(left: 20, right: 10,bottom: 5),
                child: Align(alignment:Alignment.topLeft,child: Text('More Information',style: TextStyle(color: kDarkGreyColor),)),
              ),
              CustomTextField(
                width: screenWidth/1.2,
                controller: moreInfoController,
                hintText: 'More Information',
                obscure: false,
              ),
              const SizedBox(height: 10,),
              const Padding(
                padding: EdgeInsets.only(left: 20, right: 10,bottom: 5),
                child: Align(alignment:Alignment.topLeft,child: Text('Visitor Email',style: TextStyle(color: kDarkGreyColor),)),
              ),
              CustomTextField(
                width: screenWidth/1.2,
                controller: moreInfoController,
                hintText: 'Visitor Email',
                obscure: false,
              ),
              InkWell(
                onTap: (){
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 15.0, left: 15, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('Add Visitor',style: TextStyle(color: kDarkGreyColor),),
                      SizedBox(width: 5,),
                      Icon(Icons.person_add,color: kDarkGreyColor,),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              InkWell(
                onTap: () async {

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
                    'SEND',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30,),
            ],
          ),
        ),
      ),
    );
  }
}
