import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_ticaret/constant/constant.dart';

class GetPickerImage extends StatelessWidget {
  //final getUid = FirebaseAuth.instance.currentUser!.uid;
  GetPickerImage({super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(FirebaseAuth.instance.currentUser!.email).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          //Map<String, dynamic>? data = snapshot.data!.data() as Map<String, dynamic>;
          var data = snapshot.data;
          
          if (data != null) {
            return Image.network(
              data["image"].toString(),
              fit: BoxFit.cover,
            );
          } else {
            return Text("Resminiz");
          }
        }

        return const CircularProgressIndicator(
          backgroundColor: Constant.orange,
          valueColor: AlwaysStoppedAnimation<Color>(Constant.orange),
        );
      }),
    );
  }
}
