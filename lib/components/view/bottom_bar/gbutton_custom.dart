import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class GbuttonCustomer extends StatelessWidget {
  const GbuttonCustomer({super.key, required this.text, required this.icon});
   
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return 
         GButton(
              icon: icon,
              text: text,
              gap: 8,
              iconColor: Colors.white,
              iconActiveColor: Colors.white,
              textColor: Colors.white,
              backgroundColor: Colors.grey.shade600,
              padding: const EdgeInsets.all(16),
          );
          
  }
}
