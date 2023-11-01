import 'package:flutter/material.dart';
import 'package:flutter_e_ticaret/constant/constant.dart';
import 'package:grock/grock.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  Function onTap;
  String text;
  CustomButton({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: 210,
      child: ElevatedButton(
        onPressed: () => onTap(),
        style: ElevatedButton.styleFrom(
            primary: Constant.orange,
            shape: RoundedRectangleBorder(borderRadius: 10.allBR)),
        child: Text(
          text,
          style: const TextStyle(
              color: Constant.white, fontWeight: FontWeight.bold, fontSize: 28),
        ),
      ),
    );
  }
}