import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LogoutModel extends ChangeNotifier{
  
  void logoutData() async {
    try{
      final FirebaseAuth _auth = FirebaseAuth.instance;
      print("_auth = $_auth");
      await _auth.signOut();
    }catch(e){
      print("値はnullです");
    }
    
  }
}