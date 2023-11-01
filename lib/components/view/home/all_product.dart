import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_ticaret/components/view/home/product.dart';
import 'package:flutter_e_ticaret/components/view/home/product_detail.dart';
import 'package:flutter_e_ticaret/constant/constant.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class AllProduct extends ConsumerStatefulWidget {
  AllProduct({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AllProductState();
}

class _AllProductState extends ConsumerState<AllProduct> {
  late Product products;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Tüm Ürünler"),
        actions: [
          /*IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.favorite_border,
                color: Constant.white,
              )),*/
        ],
        backgroundColor: Constant.orange,
        elevation: 10,
      ),
      body: Stack(children: [
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("products")
                .orderBy("id")
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return Container(
                  color: Constant.darkWhite,
                  child: AnimationLimiter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Constant.kDefaultPadding),
                      child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: Constant.kDefaultPadding,
                            crossAxisSpacing: Constant.kDefaultPadding,
                            childAspectRatio: 0.75
                            ),

                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final DocumentSnapshot documentSnapshot =
                                snapshot.data!.docs[index];
                            String urun_adi = (documentSnapshot.data()
                                as Map<String, dynamic>)['name'];
                            int urun_fiyati = (documentSnapshot.data()
                                as Map<String, dynamic>)['price'];
                            String photo_url = (documentSnapshot.data()
                                as Map<String, dynamic>)["image"];
                            List<Product> products = snapshot.data!.docs
                                .map((doc) => Product.fromFirestore(doc))
                                .toList();
                    
                            return AnimationConfiguration.staggeredGrid(
                              
                              columnCount: products.length,
                              position: index,
                              duration: const Duration(milliseconds: 750),
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetail(product: products[index]),));
                                      },
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              //width: 180,
                                              //height: 160,
                                              decoration: BoxDecoration(
                                                color: Constant.darkWhite,
                                                borderRadius: BorderRadius.circular(16)
                                              ),
                                              child: Image.network(photo_url, fit: BoxFit.fill,),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: Constant.kDefaultPadding / 4),
                                            child: Text(urun_adi),
                                          ),
                                          Text("\$${urun_fiyati}", style: TextStyle(fontWeight: FontWeight.bold),)
                                        ],
                                      ),
                                    )),
                              ),
                            );
                          }),
                    ),
                  ),
                );
              } else {
                return CircularProgressIndicator(
                  color: Constant.darkWhite,
                );
              }
            }),
      ]),
    );
  }
}

/*
*/