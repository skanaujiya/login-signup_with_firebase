import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:login_signup_app_with_scan_function/element/custom_button.dart';
import 'package:login_signup_app_with_scan_function/pages/home_page.dart';
import 'package:login_signup_app_with_scan_function/pages/signup_page.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';



class LoginPage extends StatefulWidget{
  const LoginPage({Key?key}): super(key: key);
  @override
  _LoginPage createState()=>_LoginPage();
}


class _LoginPage extends State<LoginPage>{
  final _key=GlobalKey<FormState>();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  final _auth=FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.purpleAccent,
              Colors.green,
              Colors.blue
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter
          )
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 310,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(45),
                child: Lottie.asset("assets/login.json"),
              ),
             Container(
               padding: const EdgeInsets.all(20),
               width: 325,
               decoration: const BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.all(Radius.circular(15)),
               ),
               child: Form(
                 key: _key,
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     const SizedBox(height: 25,),
                     Container(
                       width: 300,
                       height: 60,
                       child: TextFormField(
                         controller: emailController,
                         keyboardType: TextInputType.emailAddress,
                         decoration: const InputDecoration(
                             suffix: Icon(FontAwesomeIcons.envelope,color: Colors.purpleAccent,),
                             labelText: "Email",
                             border: OutlineInputBorder(
                               borderRadius: BorderRadius.all(Radius.circular(15)),
                             )
                         ),
                         validator: (value){
                           if(value==null||value.isEmpty)
                             {
                               return 'Please Enter Email';
                             }
                           if(!RegExp(r'^[\w]+@+[\w]+.[\w]').hasMatch(value))
                             {
                               return 'Please Enter Valid Email';
                             }
                           return null;
                         },
                       ),),
                     const SizedBox(height: 25,),
                     Container(
                       width: 300,
                       height: 60,
                       child: TextFormField(
                         controller: passwordController,
                         obscureText: true,
                         decoration: const InputDecoration(
                             suffix: Icon(FontAwesomeIcons.eyeSlash,color: Colors.purpleAccent,),
                             labelText: "Password",
                             border: OutlineInputBorder(
                               borderRadius: BorderRadius.all(Radius.circular(15)),
                             )
                         ),
                         validator: (value){
                           if(value==null||value.isEmpty)
                             {
                               return "Please Enter Password";
                             }
                           return null;
                         },
                       ),),
                     const SizedBox(height: 25,),
                     CustomButton(context, "Login", (){
                       logIn(emailController.text, passwordController.text);
                     }),
                     const SizedBox(height: 25,),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         const Text("Don't have account? ",
                           style: TextStyle(
                               color: Colors.grey
                           ),),
                         GestureDetector(
                           onTap: (){
                             Get.to(const SignUpPage());
                           },
                           child: const Text('Sign Up',
                             style: TextStyle(
                                 color: Colors.blue
                             ),),
                         )
                       ],
                     )
                   ],
                 ),
               )
             )
            ],
          ),
        )
      ),
    );
  }


  void logIn (String email,String password)async{
    if(_key.currentState!.validate())
    {
      await _auth.signInWithEmailAndPassword(email: email, password: password)
          .then((value) => {
            Get.off(()=>HomePage())
      }).catchError((e){
       Get.snackbar(
           "Error", "Enter the valid credential",
         colorText: Colors.white,
         borderRadius: 15,
         backgroundColor: Colors.redAccent
       );
      });
    }
  }
}