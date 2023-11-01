import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:grock/grock.dart';
import '../../../constant/constant.dart';
import '../home/product.dart';
import '../home/product_detail.dart';

class ProductCard extends StatefulWidget {
  ProductCard({super.key});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late CollectionReference _productCollection;
  @override
  void initState() {
    super.initState();
    _productCollection = FirebaseFirestore.instance.collection("products");
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
          height: 270,
          child: StreamBuilder(
              stream: _productCollection.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  
                  List<Product> products = snapshot.data!.docs
                      .map((doc) => Product.fromFirestore(doc))
                      .toList();
                  return AnimationLimiter(
                    child: ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => SizedBox(
                        width: 1,
                      ),
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot documentSnapshot =
                            snapshot.data!.docs[index];
                        String urun_adi = (documentSnapshot.data()
                            as Map<String, dynamic>)['name'];
                        int urun_fiyati = (documentSnapshot.data()
                            as Map<String, dynamic>)['price'];
                        double urun_puani = (documentSnapshot.data()
                            as Map<String, dynamic>)['star'];
                        String photo_url = (documentSnapshot.data()
                            as Map<String, dynamic>)["image"];
                        
                        return AnimationConfiguration.staggeredGrid(
                            columnCount: 3,
                            position: index,
                            duration: const Duration(milliseconds: 550),
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: GrockContainer(
                                    onTap: () => Grock.to(ProductDetail(
                                        product: products[index])),
                                    width: 150,
                                    decoration: BoxDecoration(
                                        color: Constant.darkWhite,
                                        borderRadius: 15
                                            .allBR, //BorderRadius.all(Radius.circular(15)),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 8,
                                          ),
                                        ]),
                                    child: IntrinsicHeight(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Hero(
                                            tag: photo_url,
                                            child: Image.network(photo_url),
                                          ),
                                          Padding(
                                            padding: 10.horizontalP,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Wrap(
                                                    spacing: 8.0,
                                                    runSpacing: 4.0,
                                                    direction: Axis.horizontal,
                                                    children: [
                                                      Text(
                                                        urun_adi,
                                                        style: const TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                /*favorite.isFalse
                                                    ? const Icon(
                                                        Icons.favorite_border,
                                                        color: Constant.black)
                                                    : const Icon(Icons.favorite,
                                                        color: Colors.red),*/
                                              StreamBuilder<Object>(
                                                stream: FirebaseFirestore.instance.collection("users-favorite-items").doc(FirebaseAuth.instance.currentUser!.email).collection("items").where("name", isEqualTo: urun_adi).snapshots(),
                                                builder: (context, AsyncSnapshot snapshot) {
                                                if(snapshot.hasData)
                                                  {
                                                   return snapshot.data.docs.length == 0 ? Icon(
                                                      Icons.favorite_border,
                                                      color: Constant.black,
                                                    ) : Icon(
                                                      Icons.favorite,
                                                      color: Colors.red,
                                                    );
                                                  }
                                                  else{
                                                     return Text("");
                                                  }
                                                 
                                                }
                                              )
                                                
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                [10, 5].horizontalAndVerticalP,
                                            child: Text(
                                              "\$${urun_fiyati}",
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                [5, 0].horizontalAndVerticalP,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                    Icons.star_rate_rounded,
                                                    color: Constant.yellow,
                                                    size: 22),
                                                Text(
                                                  "${urun_puani}",
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ));
                      },
                    ),
                  );
                } else {
                  return CircularProgressIndicator(
                    color: Constant.darkWhite,
                  );
                }
              })),
    );
  }
}
