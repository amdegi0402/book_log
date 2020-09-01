import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthModel extends ChangeNotifier{
  final emailInputController = TextEditingController();
  final passwordInputController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
//ログイン認証
  Future<AuthResult>  signIn(String email, String password) async {
    try{
      final AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
 
      return result;
    
    }catch(error){
      
      return null;

    }
   
  }


}


 