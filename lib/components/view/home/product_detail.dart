import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grock/grock.dart';
import 'package:flutter_e_ticaret/components/view/home/add_kart.dart';
import 'package:flutter_e_ticaret/components/view/home/product.dart';
import 'package:flutter_e_ticaret/constant/constant.dart';

// ignore: must_be_immutable
class ProductDetail extends StatefulWidget {
  ProductDetail({
    Key? key,
    required this.product,
  }) : super(key: key);
  final Product product;

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  ///////////////////AddtoKart
  Future addToKart() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users-cart-items");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc()
        .set({
      "name": widget.product.title,
      "price": widget.product.price,
      "image": widget.product.image,
      "descTitle": widget.product.descTitle,
      "star": widget.product.star,
      "isFavorite": widget.product.isFavorite,
      "descDetail": widget.product.descDetail,
      "desc": widget.product.desc
    }).then((value) => debugPrint("Added to Kart"));
  }
  ///////////////////AddtoFavorite
  Future addToFavorite() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users-favorite-items");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc()
        .set({
      "name": widget.product.title,
      "price": widget.product.price,
      "image": widget.product.image,
      "descTitle": widget.product.descTitle,
      "star": widget.product.star,
      "isFavorite": widget.product.isFavorite,
      "descDetail": widget.product.descDetail,
      "desc": widget.product.desc
    }).then((value) => debugPrint("Added to Favorite"));
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        actions: [         
          StreamBuilder<Object>(
            stream: FirebaseFirestore.instance.collection("users-favorite-items").doc(FirebaseAuth.instance.currentUser!.email).collection("items").where("name", isEqualTo: widget.product.title).snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if(snapshot.hasData){
                return Padding(
                padding: const EdgeInsets.only(left: 10),
                child: IconButton(
                    onPressed: () {
                      snapshot.data.docs.length == 0 ? addToFavorite() : ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Container(
                          padding: EdgeInsets.all(16.0),
                          height: 80,
                          decoration: BoxDecoration(
                              color:  Colors.red.shade800,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            children: [
                              Icon(
                                Icons.favorite,
                                color: Colors.white,
                                size: 40,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${widget.product.title} ürünü zaten favorilerde",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Spacer(),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        elevation: 3,
                        duration: Duration(milliseconds: 1500),
                      ),
                    );                   
                    },
                    icon: snapshot.data.docs.length == 0 ? Icon(
                      Icons.favorite_outline,
                      color: Constant.white,
                      size: 28,
                    ) : Icon(
                      Icons.favorite,
                      color: Colors.red.shade800,
                      size: 28,
                    )),
              );
              }else{
                return Text("");
              }
              
            }
          ),
        ],
        backgroundColor: Constant.orange,
        elevation: 10,
      ),
      body: Stack(children: [
        ListView(
          children: [
            image(),
            title(),
            colors(),
            subTitle(context),
            totatlPrice(context),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: AddKart(
                  onTap: () {
                    addToKart();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Container(
                          padding: EdgeInsets.all(16.0),
                          height: 80,
                          decoration: BoxDecoration(
                              color: Constant.orange,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: Colors.white,
                                size: 40,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${widget.product.title} başarıyla sepete eklendi",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Spacer(),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        elevation: 3,
                        duration: Duration(milliseconds: 1500),
                      ),
                    );
                  },
                  text: "Sepete Ekle"),
            )
          ],
        ),
      ]),
    );
  }

  Padding totatlPrice(BuildContext context) {
    return Padding(
      padding: [20, 20, 20, 0].paddingLTRB,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Fiyat",
            style: _subTitle,
          ),
          Text(
            "\$${widget.product.price}",
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Padding subTitle(BuildContext context) {
    return Padding(
      padding: [20, 20, 20, 0].paddingLTRB,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.product.descTitle,
            style: _subTitle,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            widget.product.descDetail,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Padding colors() {
    return Padding(
      padding: [20, 20, 20, 0].paddingLTRB,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Renkler",
            style: _subTitle,
          ),
          const SizedBox(
            height: 8,
          ),
          Wrap(
            spacing: 15,
            children: [
              for (int i = 0; i < widget.product.colors.length; i++)
                Container(
                  width: 107,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: 10.allBR,
                    color: widget.product.colors[i],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Align title() {
    return Align(
      alignment: Alignment.center,
      child: Text(
        widget.product.title,
        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      ),
    );
  }

  SizedBox image() {
    return SizedBox(
      height: 381,
      width: double.maxFinite,
      child: Hero(
          tag: widget.product,
          child: Image.network(
            widget.product.image,
            fit: BoxFit.fill,
          )),
    );
  }

  TextStyle _subTitle =
      const TextStyle(fontSize: 17, fontWeight: FontWeight.bold);
}
