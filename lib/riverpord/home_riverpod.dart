import 'package:flutter/material.dart';
import 'package:flutter_e_ticaret/components/view/home/home_products.dart';

class HomeRiverPod extends ChangeNotifier {
  HomeProduct hotDeals = HomeProduct(categoryTitle: "Hot Deals");
  HomeProduct mostPopular =
      HomeProduct(categoryTitle: "Most Popular");
}
