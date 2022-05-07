import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:login_signup_app_with_scan_function/pages/login_page.dart';
import '../element/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SignUpPage extends StatefulWidget{
  const SignUpPage({Key?key}): super(key: key);
  @override
  _SignUpPage createState()=> _SignUpPage();
}

class _SignUpPage extends State<SignUpPage>{
  final _formKey= GlobalKey<FormState>();
  TextEditingController nameController= TextEditingController();
  TextEditingController emailController= TextEditingController();
  TextEditingController passwordController= TextEditingController();
  TextEditingController rePasswordController= TextEditingController();
  final _auth=FirebaseAuth.instance;
  clearText(){
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    rePasswordController.clear();
  }
   addUser(){
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24
        ),),
        backgroundColor: Colors.purpleAccent,
        elevation: 0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
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
            padding: const EdgeInsets.all(30),
          child: Container(
              width: 300,
                height: 500,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
            child: Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.all(30),
                  children: [

                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                      prefixIcon: Icon(FontAwesomeIcons.user,color: Colors.purple,),
                      label: Text('Name'),
                      hintText: 'Enter name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      )
                      ),
                      validator: (value){
                        if(value==null|| value.isEmpty)
                          {
                            return 'Please Enter Name';
                          }if(value.length<3 || !RegExp(r'^[\D]').hasMatch(value))
                            {
                              return 'Enter the valid Name';
                            }
                        return null;
                      },
                    ),
                    const SizedBox(height: 25,),

                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                      prefixIcon: Icon(FontAwesomeIcons.envelope,color: Colors.purple,),
                      label: Text('Email'),
                      hintText: 'Enter Email ID',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      )
                      ),
                      validator: (value){
                        if(value==null || value.isEmpty)
                        {return 'Please Enter Email';}
                        else if(!value.contains('@'))
                        {return 'Please Enter Valid Email';}
                        return null;},
                ),
                const SizedBox(height: 25,),

                TextFormField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.password,color: Colors.purple,),
                      label: Text('Password'),
                      hintText: 'Enter Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      )
                  ),
                  validator: (value){
                    if(value==null || value.isEmpty)
                      {return 'Please Enter Password';}
                    if(value.length<6)
                      {
                        return "Password must contain min. 6 Character";
                      }
                    return null;
                  },
                ),
                const SizedBox(height: 25,),
                TextFormField(
                  obscureText: true,
                  controller: rePasswordController,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.password,color: Colors.purple,),
                      label: Text('Re-Password'),
                      hintText: 'Re Enter Your Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      )
                  ),
                  validator: (value){
                    if(value==null||value.isEmpty)
                      {
                        return 'Please Re Enter Password';
                      }
                    if(value.length!=passwordController.text.length)
                    {
                      return "Re Enter password in not same";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 28,),
                CustomButton(context, "Sign Up", (){
                  signUp(emailController.text, passwordController.text);
                }),
            ],
            )
            )
          )
        )
      )
    );
  }

  void signUp(String email,String password) async{
    if(_formKey.currentState!.validate())
    {
      await _auth.createUserWithEmailAndPassword(email: email, password: password)
      .then((value) => {dataSentToDatabase()})
      .catchError((e){
        Get.snackbar(
            "Message", "User is already registered",
            colorText: Colors.white,
            borderRadius: 15,
            backgroundColor: Colors.orange
        );
      });
    }
  }

  //Here we send the to the cloud firestore
  Future<void> dataSentToDatabase() async{
    User? user=_auth.currentUser!;
    await FirebaseFirestore.instance.collection('users')
        .doc(user.uid)
        .set({'name':nameController.text,'email':emailController.text});
    clearText();
    Get.snackbar(
        "You have successfully registered", '',
        colorText: Colors.white,
        borderRadius: 15,
        backgroundColor: Colors.green
    );
    Get.off(()=>const LoginPage());
  }
}