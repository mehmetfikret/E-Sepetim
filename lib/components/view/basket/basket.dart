import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_ticaret/components/view/basket/credit_card.dart';
import 'package:flutter_e_ticaret/components/view/bottom_bar/custom_button.dart';
import 'package:flutter_e_ticaret/constant/constant.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:grock/grock.dart';

class Basket extends StatefulWidget {
  const Basket({super.key});

  @override
  State<Basket> createState() => _BasketState();
}

class _BasketState extends State<Basket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users-cart-items")
                .doc(FirebaseAuth.instance.currentUser!.email)
                .collection("items")
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                final productss = snapshot.data!.docs;
                int totalPrice = 0;
                for (var productttt in productss) {
                  final price = productttt["price"] as int;
                  totalPrice += price;
                }

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: [5, 10].horizontalAndVerticalP,
                        child: Container(
                          padding: [18, 10].horizontalAndVerticalP,
                          margin: 20.horizontalP,
                          decoration: BoxDecoration(
                            color: Constant.orange.withOpacity(0.8),
                            borderRadius: 10.allBR,
                          ),
                          child: const Center(
                              child: Text("Satın Alma Sayfasına Hoş Geldiniz", style: TextStyle(color: Constant.black, fontWeight: FontWeight.w500),)),
                        ),
                      ),
                      AnimationLimiter(
                        child: ListView.separated(
                          itemCount: snapshot.data!.docs.length,
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 20,
                          ),
                          padding: 10.verticalP,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final DocumentSnapshot _documentSnapshot =
                                snapshot.data!.docs[index];
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 750),
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: Container(
                                    padding: 10.allP,
                                    decoration: BoxDecoration(
                                        color: Constant.white,
                                        borderRadius: 10.allBR,
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 15,
                                          ),
                                        ]),
                                    child: IntrinsicHeight(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.network(
                                            _documentSnapshot["image"],
                                            width: Grock.width * 0.3,
                                            height: Grock.width * 0.3,
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(_documentSnapshot["name"],
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(
                                                "\$ ${_documentSnapshot["price"]}",
                                                style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "${_documentSnapshot["descTitle"]}",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: Constant.black
                                                        .withOpacity(0.5)),
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                  children: [
                                                    WidgetSpan(
                                                      child: Icon(
                                                          Icons
                                                              .star_rate_rounded,
                                                          size: 22,
                                                          color:
                                                              Constant.yellow),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          "${_documentSnapshot["star"].toString()}",
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Constant.yellow),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 7,
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          IconButton(
                                              icon: Icon(Icons.delete),
                                              onPressed: () {
                                                AwesomeDialog(
                                                  context: context,
                                                  dialogType:
                                                      DialogType.question,
                                                  animType: AnimType.rightSlide,
                                                  title: 'Uyarı!',
                                                  desc:
                                                      '${_documentSnapshot["name"]} ürününü sepetinden çıkarmak istediğine emin misin?',
                                                  btnCancelOnPress: () {},
                                                  btnCancelText: "Vazgeç",
                                                  btnOkOnPress: () {
                                                    FirebaseFirestore.instance
                                                        .collection(
                                                            "users-cart-items")
                                                        .doc(FirebaseAuth
                                                            .instance
                                                            .currentUser!
                                                            .email)
                                                        .collection("items")
                                                        .doc(_documentSnapshot
                                                            .id)
                                                        .delete();
                                                  },
                                                  btnOkText: "Evet",
                                                )..show();
                                              }),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: 20.onlyBottomP,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Toplam Fiyat",
                              style: _style,
                            ),
                            Text(
                              "\$ $totalPrice",
                              style: _style,
                            )
                          ],
                        ),
                      ),
                      totalPrice > 0
                          ? sepetButonu()
                          : Text(
                              "Sepetinizde Ürün Bulunmamaktadır",
                              style: TextStyle(
                                  fontSize: 38, fontWeight: FontWeight.bold, color: Constant.orange),
                              textAlign: TextAlign.center,
                            ),
                    ],
                  ),
                );
              } else {
                return CircularProgressIndicator(
                  color: Constant.darkWhite,
                );
              }
            }));
  }

  TextStyle _style = TextStyle(fontSize: 36, fontWeight: FontWeight.bold);
}

class sepetButonu extends StatelessWidget {
  const sepetButonu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomButton(
            onTap: () => Grock.to(MyCardsPage()), text: "Sepeti Onayla"));
  }
}
