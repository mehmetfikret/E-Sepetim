import 'package:flutter/material.dart';
import 'package:flutter_e_ticaret/constant/constant.dart';

class MyTextFile2 extends StatelessWidget {
  
  final controller;
  final String hintText;
  final bool obscureText;
  final Widget iconData;

   MyTextFile2({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.iconData
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(         
                         
                  controller: controller,
                  obscureText: obscureText,
                  decoration: InputDecoration(
                    //suffixIcon: Icon(Icons.remove_red_eye),
                    prefixIcon: iconData,
                      enabledBorder:  OutlineInputBorder(
                          borderSide: BorderSide(color: Constant.orange)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Constant.orange)),
                          fillColor: Constant.darkWhite,
                          filled: true,
                          hintText: hintText,
                          hintStyle: TextStyle(color:const Color.fromARGB(255, 34, 34, 34)),
                          ),
                ),
              );
  }
}