import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_ticaret/components/login/read_data.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  
  //document ID's
  List<String> docIds = [];
  
  //get DocID's
  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: user.email).get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);
              docIds.add(document.reference.id);
            }));        

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                signUserOut();
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: FutureBuilder(
        future: getDocId(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: docIds.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: GetUserName(documentId: docIds[index],),
              );
            },
          );
        },
      ),
    );
  }

  void signUserOut() async {
    FirebaseAuth.instance.signOut();
  }
}
