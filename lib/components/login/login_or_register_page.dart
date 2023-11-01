import 'package:flutter/material.dart';
import 'package:flutter_e_ticaret/components/login/login_page.dart';
import 'package:flutter_e_ticaret/components/login/register_page.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  //initially show login page
  bool sohwLoginPage = true;
  
  //toogle betwwen login and register page
  void tooglePages() {
    setState(() {
      sohwLoginPage = !sohwLoginPage;
    });
  }


  @override
  Widget build(BuildContext context) {
    if(sohwLoginPage){
      return LoginPage(
        onTap: tooglePages,
      );
    }else{
      return RegisterPage(
        onTap: tooglePages,
      );
    }
  }
}