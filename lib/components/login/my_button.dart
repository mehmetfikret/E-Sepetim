import 'package:flutter/material.dart';
import 'package:flutter_e_ticaret/constant/constant.dart';

class MyButton extends StatelessWidget {
  const MyButton({super.key, required this.onTap, required this.message});
  final Function()? onTap;
  final String message;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(color: Constant.orange,/*Colors.black*/borderRadius: BorderRadius.circular(8)),
        
        child: Center(
          child: Text(message,
          style: TextStyle(color: Constant.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
    );
  }
}