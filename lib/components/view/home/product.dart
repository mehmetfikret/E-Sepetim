import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Product {
  String id;
  String image;
  String title;
  int price;
  double star;
  bool isFavorite;
  String desc;
  String descTitle;
  List<Color> colors;
  String descDetail;
  Product({
    required this.id,
    required this.image,
    required this.title,
    required this.price,
    required this.star,
    required this.isFavorite,
    required this.desc,
    required this.descTitle,
    required this.descDetail,
    required this.colors,
  });

  factory Product.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Product(
        id: doc.id,
        image: data["image"],
        title: data['name'],
        price: data['price'],
        star: data['star'].toDouble(),
        isFavorite: data["isFavorite"],
        descDetail: data["descDetail"],
        colors: [Colors.red, Colors.green, Colors.deepPurple],
        desc: data["desc"],
        descTitle: data["descTitle"]);
  }
}
