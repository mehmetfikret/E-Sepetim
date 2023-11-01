import 'package:flutter/material.dart';
import 'package:flutter_e_ticaret/components/view/home/deals.dart';
import 'package:flutter_e_ticaret/components/view/home/product_cart.dart';
import 'package:flutter_e_ticaret/components/view/home/slider_screen.dart';

class Home extends StatefulWidget {
  Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    ProductCard();
    SliderScreen();
  }

  @override
  Widget build(BuildContext context) {
    
      return ListView(
        children: [
          SizedBox(height: 210, child: SliderScreen()),
          Column(
            children: [
              Deals(deals: "Çok Satanlar"),

              /////////////////////////////////////////////////////

              Align(
                alignment: Alignment.centerLeft,
                child: ProductCard(),
              ),

              ////////////////////////////////////////////////////
              Deals(deals: "Senin İçin Seçtiklerimiz"),

            ],
          )
        ],
      );
   
  }
}
