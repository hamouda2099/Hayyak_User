import 'package:flutter/material.dart';
import 'package:hayyak/Config/constants.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  CustomTextField(
      {Key? key,
      required this.controller,
      required this.hintText,
      this.validator,
      required this.obscure,
      required this.width})
      : super(key: key);
  TextEditingController controller = TextEditingController();
  String hintText;
  bool obscure = false;
  double width;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 5, left: 5),
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.5,
          color: kLightGreyColor.withOpacity(0.3),
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      width: width,
      child: TextFormField(
        obscureText: obscure,
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
              color: kLightGreyColor.withOpacity(0.8),
              fontWeight: FontWeight.bold,
              fontSize: 14),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
