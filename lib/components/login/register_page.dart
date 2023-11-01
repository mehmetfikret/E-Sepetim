import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_ticaret/components/login/my_button.dart';
import 'package:flutter_e_ticaret/components/login/my_textfile_register.dart';
import 'package:flutter_e_ticaret/components/login/square_tile.dart';
import 'package:flutter_e_ticaret/constant/constant.dart';

class RegisterPage extends StatefulWidget {
   final Function()? onTap;
   RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //Text editing controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  //sign user in method
  Future signUserUp() async{
    //show loading circle
    showDialog(context: context, builder: (context) {
      return Center(
        child: CircularProgressIndicator(),
      );
    });
    
    Future addUserDetails(String firstName, String lastName, String email, String password) async{
      await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.email)
      .set({
        "firstName": firstName,
        "lastName": lastName,
        "email": email,   
        "password": password,
        "uid": FirebaseAuth.instance.currentUser!.uid,
      });
    }

    try{
      //show error message, passwords don't match 
      if(passwordController.text != confirmPasswordController.text){
        Navigator.pop(context);
        showErrorMessage("Passwords don't match!");
        return;
      
      }else{
      //check if password     
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
      );
      //Navigator.pop(context);
      //add user details      
      addUserDetails(firstNameController.text, lastNameController.text, emailController.text, passwordController.text.toString());
      Navigator.pop(context);
      }
      
    }
    on FirebaseAuthException
    catch(e){
      
      Navigator.pop(context);
      //Show error message
      showErrorMessage(e.code);
    }
  //Navigator.of(context).pop(); denemee
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
                  height: 15,
                ),
          
                //logo
                Icon(
                  Icons.person_add_outlined,
                  size: 75,
                  color: Constant.orange,
                ),
          
                const SizedBox(
                  height: 25,
                ),
          
                //let's create an account for you
                Text(
                  "Kayıt olmaya hoşgeldiniz!",
                  style: TextStyle(color: Colors.grey[800], fontSize: 16),
                ),
          
                const SizedBox(
                  height: 15,
                ),

                //firstname textfield
                MyTextFile(
                 
                  controller: firstNameController,
                  hintText: "Adınız",
                  obscureText: false,
                  
                ),

                const SizedBox(height: 10,),

                //lastname textfield
                MyTextFile(
                
                  controller: lastNameController,
                  hintText: "Soyadınız",
                  obscureText: false,
                ),

                const SizedBox(height: 10,),

                //email textfield
                MyTextFile(
                  
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false,
                ),
          
                const SizedBox(height: 10,),
                //password textfield
                MyTextFile(
                  
                  controller: passwordController,
                  hintText: "Şifre",
                  obscureText: true,
                ),
                const SizedBox(height: 10,),

                MyTextFile(
                
                  controller: confirmPasswordController,
                  hintText: "Şifre Onayı",
                  obscureText: true,
                ),
          
                const SizedBox(height: 10,),      
          
                //sign in button
                MyButton(
                  onTap: signUserUp,
                  message: "Kayıt Ol",
                ),
                const SizedBox(height: 7,),
          
                //or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 5 , color: Constant.orange,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text("Sosyal Hesap ile Giriş Yap", style: TextStyle(color: Colors.grey[800]),),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 5 , color: Constant.orange,
                        ),
                      ),
                    ],
                  ),
                ),
          
                const SizedBox(height: 15,),
                //google sign in button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(imagePath: "assets/images/google.png")
                  ],
                ),
                const SizedBox(height: 20,),
          
                //Already have an account? Login now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Zaten bir hesabınız var mı?',
                      style: TextStyle(color: Colors.grey[800]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Giriş Yap',
                        style: TextStyle(
                          color: Constant.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
          
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
