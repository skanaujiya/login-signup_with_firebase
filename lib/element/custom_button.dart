import 'package:flutter/material.dart';

Container CustomButton(BuildContext context,String name,Function onTap){
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    child: ElevatedButton(
      onPressed: (){
        onTap();
      },
      child: Text("${name}",
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Colors.white
      ),),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.purple),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ))
      ),
    ),
  );
}