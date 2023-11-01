import 'package:flutter/material.dart';
import 'package:flutter_e_ticaret/components/view/home/all_product.dart';

class Deals extends StatelessWidget {
  Deals({super.key, required this.deals});
  final String deals;
  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "$deals",
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w800),
                ),
                 GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AllProduct())),
                   child: Text(
                    "Tüm Ürünler",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xffA6A6AA)),
                                 ),
                 )
              ],
            ),
          );
  }
}