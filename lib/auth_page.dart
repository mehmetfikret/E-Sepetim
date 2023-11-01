import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_ticaret/components/view/base_scaffold/base_scaffold.dart';
import 'components/login/login_or_register_page.dart';


class Authpage extends StatelessWidget {
  const Authpage({super.key});
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          //user is logged in
          if(snapshot.hasData){
            return BaseScaffold();
          }
          //user is NOT logged in
          else{
            return LoginOrRegisterPage();
          }
        },
      ),
    );
  }
     
}