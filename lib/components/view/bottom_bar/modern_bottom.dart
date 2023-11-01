import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_ticaret/components/view/basket/basket.dart';
import 'package:flutter_e_ticaret/components/view/category/category.dart';
import 'package:flutter_e_ticaret/components/view/favorite/favorite.dart';
import 'package:flutter_e_ticaret/components/view/home/home.dart';
import 'package:flutter_e_ticaret/components/view/ubi_deneme/anasayfa_ubi.dart';
import 'package:flutter_e_ticaret/constant/constant.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:badges/badges.dart' as badges;

class ModernBottomNavnar extends StatefulWidget {
  const ModernBottomNavnar({super.key});

  @override
  State<ModernBottomNavnar> createState() => _ModernBottomNavnarState();
}

class _ModernBottomNavnarState extends State<ModernBottomNavnar> {
  int _selectIndex = 0;
  void _navigateBottomBar(int index) {
    setState(() {
      _selectIndex = index;
      debugPrint(_selectIndex.toString());
    });
  }

  final List<Widget> _pages = [
    Home(),
    Category(),
    Favorite(),
    Basket(),
  ];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: _pages[_selectIndex],
      bottomNavigationBar: GNav(
            selectedIndex: _selectIndex,
            onTabChange: _navigateBottomBar,
            backgroundColor: Constant.orange,
            tabBorder: Border.all(width: 1, color: Colors.transparent),
            tabs: [
              //GbuttonCustomer(text: , icon: icon)
              GButton(
                icon: Icons.home,               
                text: "Ana Sayfa",
                gap: 8,
                iconColor: Colors.white,
                iconActiveColor: Colors.white,
                textColor: Colors.white,
                backgroundColor: Colors.black.withOpacity(0.2),
                padding: EdgeInsets.all(16),
              ),
              GButton(
                icon: Icons.category,
                text: "Kategoriler",
                gap: 8,
                iconColor: Colors.white,
                iconActiveColor: Colors.white,
                textColor: Colors.white,
                backgroundColor: Colors.black.withOpacity(0.2),
                padding: EdgeInsets.all(16),
              ),
              GButton(
                icon: Icons.favorite,
                text: "Favoriler",
                gap: 8,
                //iconColor: Colors.white,
                iconActiveColor: Colors.white,
                textColor: Colors.white,
                backgroundColor: Colors.black.withOpacity(0.2),
                padding: EdgeInsets.all(16),
                leading: badges.Badge(
                  position: badges.BadgePosition.bottomEnd(),
                  badgeAnimation: badges.BadgeAnimation.fade(
                      toAnimate: true, animationDuration: Duration(seconds: 1)),
                  badgeStyle: badges.BadgeStyle(badgeColor: Colors.red.shade800, padding: EdgeInsets.all(4)),
                  badgeContent: StreamBuilder<int>(
                    stream: documentCountStreamFavorite(),
                    builder: (context, snapshot) {
                      int? docCount = snapshot.data;                
                        return Text(
                        "$docCount",
                        style: TextStyle(color: Constant.white),
                      );
                    }
                  ),
                  child: Icon(Icons.favorite, color: Colors.white),
                ),
              ),
              GButton(
                icon: Icons.shopping_basket,
                text: "Sepet",
                gap: 8,
                iconColor: Colors.white,
                iconActiveColor: Colors.white,
                textColor: Colors.white,
                backgroundColor: Colors.black.withOpacity(0.2),
                padding: EdgeInsets.all(16),
                leading: badges.Badge(
                  position: badges.BadgePosition.bottomEnd(),
                  badgeAnimation: badges.BadgeAnimation.fade(
                      toAnimate: true, animationDuration: Duration(seconds: 1)),
                  badgeStyle: badges.BadgeStyle(badgeColor: Colors.red.shade800, padding: EdgeInsets.all(4)),
                  badgeContent: StreamBuilder<int>(
                    stream: documentCountStreamKart(),
                    builder: (context, snapshot) {
                      int? docCountKart = snapshot.data;                
                        return Text(
                        "$docCountKart",
                        style: TextStyle(color: Constant.white),
                      );
                    }
                  ),
                  child: Icon(Icons.shopping_basket_sharp, color: Colors.white),
                ),
              ),
            ]),
    
    );
  }

  Stream<int> documentCountStreamFavorite() {
    return FirebaseFirestore.instance
        .collection("users-favorite-items")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection("items")
        .snapshots()
        .map((snapshot) {
      return snapshot.size; // Koleksiyon içindeki belge sayısını döndürür
    });
  }

  Stream<int> documentCountStreamKart() {
    return FirebaseFirestore.instance
        .collection("users-cart-items")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection("items")
        .snapshots()
        .map((snapshot) {
      return snapshot.size; // Koleksiyon içindeki belge sayısını döndürür
    });
  }
}
