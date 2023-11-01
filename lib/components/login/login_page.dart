import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_ticaret/components/login/forgot_password.dart';
import 'package:flutter_e_ticaret/components/login/my_button.dart';
import 'package:flutter_e_ticaret/components/login/my_textfile_login.dart';
import 'package:flutter_e_ticaret/components/login/square_tile.dart';
import 'package:flutter_e_ticaret/constant/constant.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
   final Function()? onTap;
   LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Text editing controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  

  //sign user in method
  Future signUserIn() async{
    //show loading circle
    
    showDialog(context: context, builder: (context) {
      return Center(
        child: CircularProgressIndicator(),
      );
    });

    
    
    try{
      //Navigator.pop(context);
      
      await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
      );
      
    }
    on FirebaseAuthException
    catch(e){
      //Navigator.pop(context);
      //Show error message
      Navigator.pop(context);
      showErrorMessage(e.code);
      
    }
   Navigator.of(context).pop();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.darkWhite,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),

                //logo
                Icon(
                  Icons.lock_outline_sharp,
                  size: 100,
                  color: Constant.orange,
                  opticalSize: 0.1,
                ),
          
                const SizedBox(
                  height: 50,
                ),
          
                //welcome back, youve been missed
                Text(
                  "Tekrardan hoşgeldin!",
                  style: TextStyle(color: Colors.grey[800], fontSize: 16),
                ),
          
                const SizedBox(
                  height: 50,
                ),
                //email textfield
                MyTextFile2(
                  iconData: Icon(LineAwesomeIcons.user, color: Constant.orange,),
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false,
                ),
          
                const SizedBox(height: 10,),
                //password textfield
                MyTextFile2(
                  
                  iconData: Icon(LineAwesomeIcons.lock, color: Constant.orange),
                  controller: passwordController,
                  hintText: "Şifre",
                  obscureText: true,
                  
                ),
          
                const SizedBox(height: 10,),
          
                //Forgot Password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword(),));
                      },child: Text("Şifrenizi mi Unuttunuz?", style: TextStyle(color: Constant.orange))),
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
          
                //sign in button
                MyButton(
                  onTap: signUserIn,
                  message: "Giriş Yap",
                ),
                const SizedBox(height: 10,),
          
                //or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 5 , color: Constant.orange,//Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text("Sosyal Hesap ile Giriş Yap", style: TextStyle(color: Colors.grey[800]),),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 5 , color: Constant.orange,//Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
          
                const SizedBox(height: 15,),
                //google sign in button
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(imagePath: "assets/images/google.png")
                  ],
                ),
                const SizedBox(height: 20,),
          
                //not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Henüz kayıtlı değil misiniz?',
                      style: TextStyle(color: Constant.black),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Kayıt Ol',
                        style: TextStyle(
                          color: Constant.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),   
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  //error mesage to user
  void showErrorMessage(String message) {
    showDialog(context: context, builder: (context) {
      return AlertDialog(backgroundColor: Colors.cyanAccent,
      title: Text(message));
    });
  }
  
}
