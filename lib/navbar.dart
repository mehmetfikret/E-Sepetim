import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_ticaret/components/view/menu_pages/image_picker.dart';
import 'package:flutter_e_ticaret/components/view/menu_pages/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_e_ticaret/components/view/menu_pages/setting.dart';
import 'package:flutter_e_ticaret/constant/constant.dart';

import 'components/login/read_data.dart';

class NavbarMenu extends StatefulWidget {
  NavbarMenu({super.key});

  @override
  State<NavbarMenu> createState() => _NavbarMenuState();
}

class _NavbarMenuState extends State<NavbarMenu> {
  final user = FirebaseAuth.instance.currentUser!;


  //document ID's
  List<String> docIds = [];
  late Future<List<String>> userList;
  
  //get DocID's
  Future<List<String>> getDocId() async {
    await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: user.email)
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);
              docIds.add(document.reference.id);
            }));
    return [];
  }

  @override
  void initState() {
    super.initState();
    userList = getDocId();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 200,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
              FutureBuilder(
                future: userList, 
                builder: (context, snapshot) {
                  return UserAccountsDrawerHeader(    
                  accountName:ListView.builder(itemCount: docIds.length,itemBuilder: (context, index) {
                    String user = docIds[index];
                    return Container(          
                      padding: EdgeInsets.only(top: 36),
                      child: GetUserName(documentId: user),
                    );
                  },),
                  accountEmail: Text("${user.email}"),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: ClipOval(
                      child: GetPickerImage(),
                    ),
                  ),
                  decoration: const BoxDecoration(
                    color: Constant.orange,
                  ),          
                );
                },
                 
              ), 

          const Divider(height: 1, color: Colors.white,),
          ListTile(
            leading: Icon(Icons.person, size: 28),
            title: Text(
              "Profil",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile()));
                  
            },
          ),

          ListTile(
            leading: Icon(Icons.settings_outlined, size: 28),
            title: Text(
              "Ayarlar",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Settingss()));
            },
          ),
          ListTile(
            leading: Icon(Icons.logout, size: 28),
            title: Text(
              "Çıkış Yap",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            onTap: () {
              signUserOut();
            },
          ),
        ],
      ),
    );
  }

  void signUserOut() async {
    FirebaseAuth.instance.signOut();
  }
}
