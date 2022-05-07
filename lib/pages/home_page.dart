import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';


class HomePage extends StatefulWidget{
  HomePage({Key?key}):super(key:key);
  @override
  _HomePage createState()=>_HomePage();
}

class _HomePage extends State<HomePage>{
  User? user=FirebaseAuth.instance.currentUser;
  Map<String,dynamic> data= Map();
  List userdata=[];
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  @override
  void reassemble() {
    super.reassemble();
    controller!.pauseCamera();
  }

  @override
 void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
     FirebaseFirestore.instance.collection('user')
    .doc(user!.uid)
    .get()
    .then((value) => {
      data=value.data() as Map<String,dynamic>
     });
     userdata.add(data);
    setState(() { });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('Welcome'),
        actions: [
         ElevatedButton(
             onPressed: (){
               logout();
             },
             child: const Text("Logout",
             style: TextStyle(
               fontWeight: FontWeight.bold,
               fontSize: 16
             ),),
           style: ButtonStyle(
             backgroundColor: MaterialStateProperty.all(Colors.purple),
             elevation: MaterialStateProperty.all(0)
           ),
         )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
            dispose();
        },
        label: const Text("Scan"),
        icon: const Icon(Icons.camera),
      ),
      body: Column(
    children: <Widget>[
      Expanded(
        flex: 2,
        child: QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
        ),
      ),
      Expanded(
        flex: 1,
        child: Center(
          child: (result != null && dispose())
              ? Text(
              'Data: ${result!.code}')
              : Text('Scan a code'),
        ),
      )
    ],

      )
    );
  }

  //this function is logout function
  Future<void> logout() async{
    await FirebaseAuth.instance.signOut();
    Get.off(()=>const LoginPage());
  }

  void _onQRViewCreated(QRViewController controller) async {
    this.controller = controller;
    await controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  bool dispose() {
    controller?.dispose();
    super.dispose();
    return true;
  }
}