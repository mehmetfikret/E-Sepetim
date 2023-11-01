/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_ticaret/constant/constant.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController ?_firstName;
  TextEditingController ?_lastName;

  setDataToTextField(data){
    return Column(
              children: [
                TextFormField(
                  controller: _firstName = TextEditingController(text: data["firstName"]),
                ),
                TextFormField(
                  controller: _lastName = TextEditingController(text: data["lastName"]),
                ),
                ElevatedButton(onPressed: () => updateData(), child: Text("Güncelle")),
              ],
            );
  }

  updateData(){
    CollectionReference _collectionRef = FirebaseFirestore.instance.collection("users");
    return _collectionRef.doc(FirebaseAuth.instance.currentUser!.email).update({
      "firstName": _firstName!.text,
      "lastName": _lastName!.text,
    }).then((value) => debugPrint("Güncellendi"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profil Sayfası"), centerTitle: true, backgroundColor: Constant.orange,),
      body: SafeArea(child: 
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<Object>(
          stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.email).snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
             final data = snapshot.data!.data() as Map<String, dynamic>;
             
             if(data==null){
              return Center(child: CircularProgressIndicator(color: Colors.black,));
              
             }
             else{
              return setDataToTextField(data);
             }
            
          }
        ),
      )
      ),
    );
  }
}*/

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_ticaret/components/view/menu_pages/image_picker.dart';
import 'package:flutter_e_ticaret/constant/constant.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _obscureText = true;
  TextEditingController? _firstName;
  TextEditingController? _lastName;
  TextEditingController? _email;
  TextEditingController? _password;
  String? downloadUrl;

  setDataToTextField(data) {
    return Column(
      children: [
        // -- IMAGE with ICON
        Stack(
          children: [
            SizedBox(
                width: 140,
                height: 120,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: downloadUrl == null ? Image.asset("assets/images/ben.jpg") : GetPickerImage())),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Constant.yellow),
                child: GestureDetector(
                  onTap: () async {
                    ////////////////////
                    final picker = ImagePicker();
                    final pickedImage =
                        await picker.pickImage(source: ImageSource.gallery);

                    if (pickedImage == null) return;
                    String uniqueFileName = DateTime.now().microsecondsSinceEpoch.toString();
                    final File file = File(pickedImage.path);
                    final Reference storageRef = FirebaseStorage.instance.ref().child('images')                       .child(uniqueFileName);

                    UploadTask uploadTask = storageRef.putFile(file);

                    TaskSnapshot storageSnapshot =
                        await uploadTask.whenComplete(() => null);

                    downloadUrl = await storageSnapshot.ref.getDownloadURL();


                    ////////////////////
                  },
                  child: Icon(LineAwesomeIcons.camera,
                      color: Constant.black, size: 22),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // -- Form Fields
        Form(
          child: Column(
            children: [
              TextFormField(
                controller: _firstName =
                    TextEditingController(text: data["firstName"]),
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Constant.black),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Constant.orange),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintStyle: TextStyle(color: Constant.orange),
                  prefixIconColor: Constant.orange,
                  focusColor: Constant.orange,
                  fillColor: Constant.orange,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Constant.black),
                      borderRadius: BorderRadius.circular(20)),
                  label: Text(
                    "Adınız",
                    style: TextStyle(color: Constant.black.withOpacity(0.7)),
                  ),
                  prefixIcon: Icon(LineAwesomeIcons.user),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _lastName =
                    TextEditingController(text: data["lastName"]),
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Constant.black),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Constant.orange),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintStyle: TextStyle(color: Constant.orange),
                  prefixIconColor: Constant.orange,
                  focusColor: Constant.orange,
                  fillColor: Constant.orange,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Constant.black),
                      borderRadius: BorderRadius.circular(20)),
                  label: Text(
                    "Soyadınız",
                    style: TextStyle(color: Constant.black.withOpacity(0.7)),
                  ),
                  prefixIcon: Icon(LineAwesomeIcons.user),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _email = TextEditingController(text: data["email"]),
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Constant.black),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Constant.orange),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintStyle: TextStyle(color: Constant.orange),
                  prefixIconColor: Constant.orange,
                  focusColor: Constant.orange,
                  fillColor: Constant.orange,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Constant.black),
                      borderRadius: BorderRadius.circular(20)),
                  label: Text(
                    "E-Mail Adresiniz",
                    style: TextStyle(color: Constant.black.withOpacity(0.7)),
                  ),
                  prefixIcon: Icon(LineAwesomeIcons.envelope_1),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                obscureText: _obscureText,
                controller: _password =
                    TextEditingController(text: data["password"]),
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      icon: Icon(_obscureText
                          ? LineAwesomeIcons.eye_slash
                          : LineAwesomeIcons.eye),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      }),
                  suffixIconColor: Constant.black,
                  labelStyle: TextStyle(color: Constant.black),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Constant.orange),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintStyle: TextStyle(color: Constant.orange),
                  prefixIconColor: Constant.orange,
                  focusColor: Constant.orange,
                  fillColor: Constant.orange,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Constant.black),
                      borderRadius: BorderRadius.circular(20)),
                  label: Text(
                    "Şifreniz",
                    style: TextStyle(color: Constant.black.withOpacity(0.7)),
                  ),
                  prefixIcon: Icon(LineAwesomeIcons.fingerprint),
                ),
              ),

              const SizedBox(height: 20),

              // -- Form Submit Button
              SizedBox(
                width: double.infinity,
                height: 70,
                child: ElevatedButton(
                  onPressed: () {
                    updateData();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Constant.orange,
                      side: BorderSide.none,
                      shape: const StadiumBorder()),
                  child: const Text("Güncelle",
                      style: TextStyle(color: Constant.white, fontSize: 28)),
                ),
              ),
              const SizedBox(height: 20),

              // -- Created Date and Delete Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      text: "En son giriş zamanı: ",
                      style: TextStyle(fontSize: 12),
                      children: [
                        TextSpan(
                            text:
                                "${FirebaseAuth.instance.currentUser!.metadata.lastSignInTime}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12))
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent.withOpacity(0.1),
                        elevation: 0,
                        foregroundColor: Colors.red,
                        shape: const StadiumBorder(),
                        side: BorderSide.none),
                    child: const Text("Hesabı Sil"),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  updateData() {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users");
    return _collectionRef.doc(FirebaseAuth.instance.currentUser!.email).update({
      "firstName": _firstName!.text,
      "lastName": _lastName!.text,
      "image": downloadUrl,
    }).then((value) => debugPrint("Güncellendi"));
  }

  /*void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Constant.orange,
          title:
              Text("Profil Sayfası", style: TextStyle(color: Constant.white)),
          centerTitle: true,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Container(
          color: Constant.darkWhite,
          padding: const EdgeInsets.all(16),
          child: StreamBuilder<Object>(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(FirebaseAuth.instance.currentUser!.email)
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                /*final data =
                    snapshot.data.data() as Map<String, dynamic>;*/
                    var data = snapshot.data;

                if (data == null) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: Colors.black,
                  ));
                } else {
                  return setDataToTextField(data);
                }
              }),
        ))));
  }
}
