import 'package:flutter/material.dart';
import 'package:flutter_e_ticaret/constant/constant.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Category extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      /* appBar: AppBar(
        title: Text("Navigator İslemleri"),
      ),*/
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
        ),
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              print('Tıklandı:');
            },
            child: Card(
              color: Constant.orange,
              elevation: 2.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/images/im_w1.png",
                    height: 140,
                    width: 180,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "kategori_adi",
                    style: TextStyle(fontSize: 18.0, color: Constant.white),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
