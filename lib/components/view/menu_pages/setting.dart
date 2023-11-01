import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Settingss extends ConsumerWidget {
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
     return Scaffold(
      appBar: AppBar(title: Text("AYARLAR"),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
        child:  Text("AYARLARINIZ"),
          
            /*child: TextButton(
              onPressed: () {},
              child: Text(
                "SETTİNGS",
                style: TextStyle(color: Colors.white),
              ),
             
            
          )*/
      )],
      ),
    );
  }
}