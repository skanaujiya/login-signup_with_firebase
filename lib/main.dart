import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_signup_app_with_scan_function/pages/login_page.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);
  final Future<FirebaseApp> _app=Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _app,
        builder: (BuildContext context, AsyncSnapshot<FirebaseApp>snapshot){
        if(snapshot.hasError)
          {
            return const Text("Something went Wrong");
          }else if(snapshot.connectionState==ConnectionState.done)
            {
              return const GetMaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Login/Sign Up',
                home: LoginPage(),
              );
            }
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      }
    );
  }
}