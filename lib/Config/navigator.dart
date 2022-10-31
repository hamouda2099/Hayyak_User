import 'package:flutter/material.dart';

void navigator({required BuildContext context, var screen, bool remove = false, bool replacement = false}){
  if(remove){
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => screen), (Route<dynamic> route) => false);
  }else if(replacement){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => screen,));
  }else{
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen,));
  }
}