import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  MyTextBox({super.key, required this.text, required this.sectionName, required this.onPressed});
  final String text;
  final String sectionName;
  void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8)
      ),
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(sectionName,
              style: TextStyle(color: Colors.red),
              ),

              IconButton(onPressed: () {
                
              }, icon: Icon(Icons.settings, color: Colors.green,))
            ],
          ),
          Text(text),
        ],
      ),
    );
  }
}