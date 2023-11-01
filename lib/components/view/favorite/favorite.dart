import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_ticaret/components/view/home/product.dart';
import 'package:flutter_e_ticaret/components/view/home/product_detail.dart';
import 'package:flutter_e_ticaret/constant/constant.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class Favorite extends ConsumerStatefulWidget {
  Favorite({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FavoriteState();
}

class _FavoriteState extends ConsumerState<Favorite> {
  late Product products;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users-favorite-items")
                .doc(FirebaseAuth.instance.currentUser!.email)
                .collection("items")
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {            
                  if(snapshot.hasData){
                    List<Product> products = snapshot.data!.docs
                      .map((doc) => Product.fromFirestore(doc))
                      .toList();
              return AnimationLimiter(
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot _documentSnapshot =
                        snapshot.data!.docs[index];
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 750),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: Card(
                            elevation: 5,
                            child: ListTile(
                              onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProductDetail(
                                              product: products[index]))),
                              splashColor: Constant.orange,
                              tileColor: Constant.darkWhite,
                              textColor: Constant.orange,
                              leading: Image.network(
                                    _documentSnapshot["image"],
                                    width: 70,
                                    height: 220,
                                    fit: BoxFit.cover,
                                  ),
                              subtitle: Text(
                               "\$ ${_documentSnapshot["price"]}",
                                style: TextStyle(
                                    color: Constant.black.withOpacity(0.5), fontWeight: FontWeight.bold),
                              ),
                              title: Text(_documentSnapshot["name"]),
                              trailing: GestureDetector(
                                onTap: () {
                                  FirebaseFirestore.instance.collection("users-favorite-items").doc(FirebaseAuth.instance.currentUser!.email).collection("items").doc(_documentSnapshot.id).delete();
                                },
                                child: Icon(
                                  Icons.delete_outlined,
                                  color: Constant.orange,
                                  size: 28,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
                }
                else{
                 return CircularProgressIndicator(color: Constant.darkWhite,);
                }
            }),
      ]),
    );
  }
}


