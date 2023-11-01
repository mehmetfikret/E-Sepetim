import 'package:flutter/material.dart';
import 'package:grock/grock.dart';
import '../../../constant/constant.dart';

// ignore: must_be_immutable
class AddKart extends StatelessWidget {
  Function onTap;
  String text;
  AddKart({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ElevatedButton(
        onPressed: () => onTap(),
        style: ElevatedButton.styleFrom(
            backgroundColor: Constant.orange,
            shape: RoundedRectangleBorder(borderRadius: 10.allBR)),
        child: Text(
          text,
          style: const TextStyle(
              color: Constant.white, fontWeight: FontWeight.bold, fontSize: 20),
        )
      ),
    );
  }
}